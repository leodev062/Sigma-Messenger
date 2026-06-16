package services

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/url"
	"strings"
	"time"

	bizbotapi "sigma-server/internal/business/botapi"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/dto"
	platformbotapi "sigma-server/internal/platform/botapi"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type BotAPIService struct {
	bots           *storage.BotRepository
	webhooks       *storage.BotWebhookStore
	updates        *storage.BotUpdateStore
	accounts       *storage.AccountManager
	outbound       RealtimeMessenger
	offline        OfflineMessenger
	webhookClient  *platformbotapi.WebhookClient
	allowHTTPHook  bool
	logger         *log.Logger
}

func NewBotAPIService(
	bots *storage.BotRepository,
	webhooks *storage.BotWebhookStore,
	updates *storage.BotUpdateStore,
	accounts *storage.AccountManager,
	outbound RealtimeMessenger,
	offline OfflineMessenger,
	webhookClient *platformbotapi.WebhookClient,
	allowInsecureWebhook bool,
	logger *log.Logger,
) *BotAPIService {
	if logger == nil {
		logger = log.Default()
	}
	return &BotAPIService{
		bots:          bots,
		webhooks:      webhooks,
		updates:       updates,
		accounts:      accounts,
		outbound:      outbound,
		offline:       offline,
		webhookClient: webhookClient,
		allowHTTPHook: allowInsecureWebhook,
		logger:        logger,
	}
}

func (s *BotAPIService) GetMe(bot *entities.Account) *bizbotapi.BotInfo {
	return &bizbotapi.BotInfo{
		ID:        bot.ID,
		IsBot:     true,
		FirstName: deref(bot.DisplayName),
		Username:  deref(bot.Username),
	}
}

func (s *BotAPIService) IngestMessage(ctx context.Context, botID, fromUserID uuid.UUID, text string, rawPayload []byte) error {
	if s == nil {
		return errors.New("bot api service is not configured")
	}

	fromUser, err := s.accounts.FindByID(fromUserID.String())
	if err != nil {
		return err
	}

	updateID, err := s.updates.NextUpdateID(botID)
	if err != nil {
		return err
	}

	update := buildUpdate(updateID, fromUser, text)
	payload, err := json.Marshal(update)
	if err != nil {
		return err
	}

	row := &entities.BotUpdate{
		BotID:    botID,
		UpdateID: updateID,
		Payload:  payload,
	}
	if err := s.updates.Create(row); err != nil {
		return err
	}

	_ = s.webhooks.IncrementPending(botID)
	s.dispatchWebhook(ctx, botID, update)
	return nil
}

func (s *BotAPIService) GetUpdates(ctx context.Context, botID uuid.UUID, offset int64, limit, timeoutSec int) ([]bizbotapi.Update, error) {
	if timeoutSec < 0 {
		timeoutSec = 0
	}
	if timeoutSec > 50 {
		timeoutSec = 50
	}

	deadline := time.Now().Add(time.Duration(timeoutSec) * time.Second)
	if timeoutSec == 0 {
		deadline = time.Now()
	}

	for {
		rows, err := s.updates.FetchPending(botID, offset, limit)
		if err != nil {
			return nil, err
		}
		if len(rows) > 0 {
			return s.consumeRows(ctx, botID, rows)
		}
		if time.Now().After(deadline) {
			return []bizbotapi.Update{}, nil
		}
		select {
		case <-ctx.Done():
			return nil, ctx.Err()
		case <-time.After(400 * time.Millisecond):
		}
	}
}

func (s *BotAPIService) consumeRows(ctx context.Context, botID uuid.UUID, rows []entities.BotUpdate) ([]bizbotapi.Update, error) {
	_ = ctx
	ids := make([]int64, 0, len(rows))
	out := make([]bizbotapi.Update, 0, len(rows))
	for _, row := range rows {
		var update bizbotapi.Update
		if err := json.Unmarshal(row.Payload, &update); err != nil {
			continue
		}
		out = append(out, update)
		ids = append(ids, row.UpdateID)
	}
	if err := s.updates.MarkDelivered(botID, ids); err != nil {
		return nil, err
	}
	_ = s.webhooks.DecrementPending(botID, len(ids))
	return out, nil
}

func (s *BotAPIService) SendMessage(bot *entities.Account, req dto.BotAPISendMessageRequest) (*bizbotapi.Message, error) {
	chatID := strings.TrimSpace(req.ChatID)
	text := strings.TrimSpace(req.Text)
	if chatID == "" || text == "" {
		return nil, fmt.Errorf("chat_id and text are required")
	}

	recipientID, err := uuid.Parse(chatID)
	if err != nil {
		return nil, fmt.Errorf("invalid chat_id")
	}

	envelope, err := buildTextEnvelope(bot.ID, text)
	if err != nil {
		return nil, err
	}
	if err := s.deliverToUser(recipientID.String(), envelope); err != nil {
		return nil, err
	}

	now := time.Now().Unix()
	return &bizbotapi.Message{
		MessageID: now,
		Chat:      &bizbotapi.Chat{ID: chatID, Type: "private"},
		Date:      now,
		Text:      text,
	}, nil
}

func (s *BotAPIService) deliverToUser(userID string, envelope []byte) error {
	if s.outbound != nil && s.outbound.Send(userID, envelope) {
		return nil
	}
	if s.offline != nil {
		return s.offline.Deliver(userID, "USER", envelope, true)
	}
	return errors.New("delivery is not configured")
}

func (s *BotAPIService) SetWebhook(botID uuid.UUID, req dto.BotAPISetWebhookRequest) error {
	urlValue := strings.TrimSpace(req.URL)
	if urlValue == "" {
		return s.webhooks.Delete(botID)
	}
	if err := s.validateWebhookURL(urlValue); err != nil {
		return err
	}

	if req.DropPendingUpdates {
		if err := s.updates.DeletePending(botID); err != nil {
			return err
		}
		_ = s.webhooks.SetPendingCount(botID, 0)
	}

	maxConn := req.MaxConnections
	if maxConn <= 0 {
		maxConn = 40
	}

	hook := &entities.BotWebhook{
		BotID:          botID,
		URL:            urlValue,
		SecretToken:    strings.TrimSpace(req.SecretToken),
		MaxConnections: maxConn,
		AllowedUpdates: strings.Join(req.AllowedUpdates, ","),
	}
	if err := s.webhooks.Upsert(hook); err != nil {
		return err
	}
	return s.webhooks.ClearError(botID)
}

func (s *BotAPIService) DeleteWebhook(botID uuid.UUID, dropPending bool) error {
	if dropPending {
		if err := s.updates.DeletePending(botID); err != nil {
			return err
		}
		_ = s.webhooks.SetPendingCount(botID, 0)
	}
	return s.webhooks.Delete(botID)
}

func (s *BotAPIService) GetWebhookInfo(botID uuid.UUID) (*bizbotapi.WebhookInfo, error) {
	hook, err := s.webhooks.Get(botID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			pending, _ := s.updates.CountPending(botID)
			return &bizbotapi.WebhookInfo{PendingUpdateCount: int(pending)}, nil
		}
		return nil, err
	}

	info := &bizbotapi.WebhookInfo{
		URL:                  hook.URL,
		HasCustomCertificate: false,
		PendingUpdateCount:   hook.PendingUpdateCount,
		LastErrorMessage:     hook.LastErrorMessage,
		MaxConnections:       hook.MaxConnections,
	}
	if hook.LastErrorDate != nil {
		unix := hook.LastErrorDate.Unix()
		info.LastErrorDate = &unix
	}
	return info, nil
}

func (s *BotAPIService) HasWebhook(botID uuid.UUID) (bool, error) {
	hook, err := s.webhooks.Get(botID)
	if err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return false, nil
		}
		return false, err
	}
	return strings.TrimSpace(hook.URL) != "", nil
}

func (s *BotAPIService) validateWebhookURL(raw string) error {
	parsed, err := url.Parse(raw)
	if err != nil {
		return fmt.Errorf("invalid webhook url")
	}
	if parsed.Scheme != "https" && !(s.allowHTTPHook && parsed.Scheme == "http") {
		return fmt.Errorf("webhook url must use https")
	}
	if parsed.Host == "" {
		return fmt.Errorf("webhook url must have a host")
	}
	return nil
}

func (s *BotAPIService) dispatchWebhook(ctx context.Context, botID uuid.UUID, update bizbotapi.Update) {
	hook, err := s.webhooks.Get(botID)
	if err != nil || strings.TrimSpace(hook.URL) == "" {
		return
	}

	go func() {
		callCtx, cancel := context.WithTimeout(context.Background(), 12*time.Second)
		defer cancel()

		if err := s.webhookClient.PostUpdate(callCtx, hook.URL, hook.SecretToken, update); err != nil {
			_ = s.webhooks.RecordError(botID, err.Error())
			s.logger.Printf("bot webhook bot=%s url=%s: %v", botID, hook.URL, err)
			return
		}
		_ = s.webhooks.ClearError(botID)
		_ = s.updates.MarkDelivered(botID, []int64{update.UpdateID})
		_ = s.webhooks.DecrementPending(botID, 1)
	}()

	_ = ctx
}

func buildUpdate(updateID int64, from *entities.Account, text string) bizbotapi.Update {
	now := time.Now().Unix()
	chatID := from.ID
	return bizbotapi.Update{
		UpdateID: updateID,
		Message: &bizbotapi.Message{
			MessageID: updateID,
			From: &bizbotapi.User{
				ID:        chatID,
				IsBot:     false,
				FirstName: deref(from.DisplayName),
				Username:  deref(from.Username),
			},
			Chat: &bizbotapi.Chat{
				ID:   chatID,
				Type: "private",
			},
			Date: now,
			Text: text,
		},
	}
}

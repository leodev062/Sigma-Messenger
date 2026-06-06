package services

import (
	"context"
	"fmt"
	"strings"

	bizbot "sigma-server/internal/business/bot"
	"sigma-server/internal/domain/valueobjects"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
)

type BotService struct {
	bots        *storage.BotRepository
	father      *BotFatherService
	api         *BotAPIService
	outbound    RealtimeMessenger
	offline     OfflineMessenger
	botFatherID uuid.UUID
	apiBaseURL  string
}

func NewBotService(
	bots *storage.BotRepository,
	father *BotFatherService,
	api *BotAPIService,
	outbound RealtimeMessenger,
	offline OfflineMessenger,
	botFatherID uuid.UUID,
	apiBaseURL string,
) *BotService {
	return &BotService{
		bots:        bots,
		father:      father,
		api:         api,
		outbound:    outbound,
		offline:     offline,
		botFatherID: botFatherID,
		apiBaseURL:  strings.TrimRight(strings.TrimSpace(apiBaseURL), "/"),
	}
}

func (s *BotService) Handle(ctx context.Context, senderID, botID uuid.UUID, payload []byte) error {
	if s == nil || s.bots == nil {
		return fmt.Errorf("bot service is not configured")
	}

	botAccount, err := s.bots.FindByID(botID)
	if err != nil {
		return err
	}
	if botAccount.Type != string(valueobjects.RecipientBot) {
		return fmt.Errorf("destination is not a bot")
	}

	text := bizbot.ExtractCommandText(payload)

	if botID == s.botFatherID {
		return s.handleBotFather(ctx, senderID, botID, text, payload)
	}

	if s.api == nil {
		return fmt.Errorf("bot api is not configured")
	}
	return s.api.IngestMessage(ctx, botID, senderID, text, payload)
}

func (s *BotService) handleBotFather(ctx context.Context, senderID, botID uuid.UUID, text string, payload []byte) error {
	_ = ctx
	_ = payload

	cmd := bizbot.ParseCommand(text)
	var reply *bizbot.Reply

	if s.father != nil {
		owned, _ := s.father.ListOwnedBots(senderID)
		reply = s.father.businessFather().HandleCommand(cmd, owned)
		if cmd != nil && cmd.Name == bizbot.CommandNewBot {
			created, createErr := s.father.CreateBot(senderID, cmd.ArgString())
			if createErr != nil {
				reply = &bizbot.Reply{Text: "Não foi possível criar o bot: " + createErr.Error()}
			} else {
				token := deref(created.BotToken)
				apiHint := s.formatAPIHint(token)
				reply = &bizbot.Reply{Text: fmt.Sprintf(
					"Bot criado: %s\nToken: %s\n\n%s\n\nGuarde o token — use-o no seu servidor para controlar o bot.",
					deref(created.DisplayName),
					token,
					apiHint,
				)}
			}
		}
	}

	if reply == nil && cmd != nil && bizbot.IsStart(cmd) {
		reply = bizbot.NewFather().HandleCommand(&bizbot.Command{Name: bizbot.CommandStart}, nil)
	}
	if reply == nil || strings.TrimSpace(reply.Text) == "" {
		return nil
	}

	envelope, err := buildTextEnvelope(botID.String(), reply.Text)
	if err != nil {
		return err
	}
	return s.deliverReply(senderID.String(), envelope)
}

func (s *BotService) formatAPIHint(token string) string {
	if s.apiBaseURL == "" || token == "" {
		return "Configure bots.api_public_base_url no servidor para ver os endpoints da API."
	}
	return fmt.Sprintf(`API do bot (estilo Telegram):
• GET  %s/bot/%s/getMe
• GET  %s/bot/%s/getUpdates
• POST %s/bot/%s/sendMessage  {"chat_id":"<user_uuid>","text":"..."}
• POST %s/bot/%s/setWebhook     {"url":"https://seu-servidor.com/webhook"}`, s.apiBaseURL, token, s.apiBaseURL, token, s.apiBaseURL, token, s.apiBaseURL, token)
}

func (s *BotService) deliverReply(userID string, envelope []byte) error {
	if s.outbound != nil && s.outbound.Send(userID, envelope) {
		return nil
	}
	if s.offline != nil {
		return s.offline.Deliver(userID, envelope, true)
	}
	return nil
}

var _ BotMessageHandler = (*BotService)(nil)

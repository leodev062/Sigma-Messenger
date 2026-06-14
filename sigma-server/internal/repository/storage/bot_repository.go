package storage

import (
	"crypto/rand"
	"encoding/base64"
	"errors"
	"fmt"
	"strings"

	"sigma-server/internal/domain/entities"
	"sigma-server/internal/domain/valueobjects"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type BotRepository struct {
	db *gorm.DB
}

func NewBotRepository(db *gorm.DB) *BotRepository {
	return &BotRepository{db: db}
}

func (r *BotRepository) FindByID(id uuid.UUID) (*entities.Account, error) {
	var account entities.Account
	err := r.db.Where("id = ? AND type = ?", id, ChatTypeBot).First(&account).Error
	return &account, err
}

func (r *BotRepository) FindByToken(token string) (*entities.Account, error) {
	var account entities.Account
	err := r.db.Where("bot_token = ? AND type = ?", token, ChatTypeBot).First(&account).Error
	return &account, err
}

func (r *BotRepository) FindByUsername(username string) (*entities.Account, error) {
	clean := strings.TrimPrefix(strings.TrimSpace(username), "@")
	var account entities.Account
	err := r.db.Where("username = ? AND type = ?", clean, ChatTypeBot).First(&account).Error
	return &account, err
}

func (r *BotRepository) ListOwnedBots(ownerID uuid.UUID) ([]entities.Account, error) {
	var bots []entities.Account
	err := r.db.Where("owner_id = ? AND type = ?", ownerID, ChatTypeBot).Order("created_at ASC").Find(&bots).Error
	return bots, err
}

func (r *BotRepository) CreateBot(ownerID uuid.UUID, displayName, username string) (*entities.Account, error) {
	token, err := generateBotToken()
	if err != nil {
		return nil, err
	}

	bot := &entities.Account{
		Type:             string(valueobjects.RecipientBot),
		DisplayName:      &displayName,
		OwnerID:          &ownerID,
		BotToken:         &token,
		VerificationType: "none",
	}
	if username != "" {
		clean := strings.TrimPrefix(strings.TrimSpace(username), "@")
		bot.Username = &clean
	}

	err = r.db.Create(bot).Error
	return bot, err
}

func (r *BotRepository) EnsureBotFather(displayName, username string) (*entities.Account, error) {
	existing, err := r.FindByUsername(username)
	if err == nil {
		return existing, nil
	}
	if err != nil && !errors.Is(err, gorm.ErrRecordNotFound) {
		return nil, err
	}

	token, err := generateBotToken()
	if err != nil {
		return nil, err
	}
	name := displayName
	user := strings.TrimPrefix(username, "@")
	bot := &entities.Account{
		Type:             string(valueobjects.RecipientBot),
		DisplayName:      &name,
		Username:         &user,
		BotToken:         &token,
		VerificationType: "verified",
	}
	if err := r.db.Create(bot).Error; err != nil {
		return nil, err
	}
	return bot, nil
}

func (r *BotRepository) GetState(userID, botID uuid.UUID) (*entities.BotConversationState, error) {
	var state entities.BotConversationState
	err := r.db.Where("user_id = ? AND bot_id = ?", userID, botID).First(&state).Error
	return &state, err
}

func (r *BotRepository) SaveState(state *entities.BotConversationState) error {
	return r.db.Save(state).Error
}

func generateBotToken() (string, error) {
	buf := make([]byte, 32)
	if _, err := rand.Read(buf); err != nil {
		return "", err
	}
	return base64.RawURLEncoding.EncodeToString(buf), nil
}

func SlugUsername(name string) string {
	name = strings.ToLower(strings.TrimSpace(name))
	var b strings.Builder
	lastDash := false
	for _, r := range name {
		switch {
		case r >= 'a' && r <= 'z', r >= '0' && r <= '9':
			b.WriteRune(r)
			lastDash = false
		case r == ' ' || r == '-' || r == '_':
			if !lastDash && b.Len() > 0 {
				b.WriteByte('_')
				lastDash = true
			}
		}
	}
	out := strings.Trim(b.String(), "_")
	if out == "" {
		return fmt.Sprintf("bot_%s", uuid.NewString()[:8])
	}
	if len(out) > 40 {
		out = out[:40]
	}
	return out + "_bot"
}

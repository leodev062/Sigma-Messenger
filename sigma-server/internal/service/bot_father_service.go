package services

import (
	"fmt"
	"strings"

	bizbot "sigma-server/internal/business/bot"
	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
)

type BotFatherService struct {
	bots    *storage.BotRepository
	accounts *storage.AccountManager
	father  *bizbot.Father
}

func NewBotFatherService(bots *storage.BotRepository, accounts *storage.AccountManager) *BotFatherService {
	return &BotFatherService{
		bots:     bots,
		accounts: accounts,
		father:   bizbot.NewFather(),
	}
}

func (s *BotFatherService) businessFather() *bizbot.Father {
	return s.father
}

func (s *BotFatherService) Ensure(username, displayName string) (*entities.Account, error) {
	return s.bots.EnsureBotFather(displayName, username)
}

func (s *BotFatherService) CreateBot(ownerID uuid.UUID, name string) (*entities.Account, error) {
	name = strings.TrimSpace(name)
	if name == "" {
		return nil, fmt.Errorf("bot name is required")
	}
	username := storage.SlugUsername(name)
	return s.bots.CreateBot(ownerID, name, username)
}

func (s *BotFatherService) ListOwnedBots(ownerID uuid.UUID) ([]bizbot.OwnedBotSummary, error) {
	bots, err := s.bots.ListOwnedBots(ownerID)
	if err != nil {
		return nil, err
	}
	out := make([]bizbot.OwnedBotSummary, 0, len(bots))
	for _, bot := range bots {
		out = append(out, bizbot.OwnedBotSummary{
			ID:          bot.ID,
			DisplayName: deref(bot.DisplayName),
			Username:    deref(bot.Username),
		})
	}
	return out, nil
}

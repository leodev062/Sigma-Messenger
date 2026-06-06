package storage

import (
	"time"

	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type BotWebhookStore struct {
	db *gorm.DB
}

func NewBotWebhookStore(db *gorm.DB) *BotWebhookStore {
	return &BotWebhookStore{db: db}
}

func (s *BotWebhookStore) Get(botID uuid.UUID) (*entities.BotWebhook, error) {
	var hook entities.BotWebhook
	err := s.db.First(&hook, "bot_id = ?", botID).Error
	return &hook, err
}

func (s *BotWebhookStore) Upsert(hook *entities.BotWebhook) error {
	hook.UpdatedAt = time.Now()
	return s.db.Save(hook).Error
}

func (s *BotWebhookStore) Delete(botID uuid.UUID) error {
	return s.db.Delete(&entities.BotWebhook{}, "bot_id = ?", botID).Error
}

func (s *BotWebhookStore) RecordError(botID uuid.UUID, message string) error {
	now := time.Now()
	return s.db.Model(&entities.BotWebhook{}).Where("bot_id = ?", botID).Updates(map[string]interface{}{
		"last_error_message": message,
		"last_error_date":    now,
		"updated_at":         now,
	}).Error
}

func (s *BotWebhookStore) ClearError(botID uuid.UUID) error {
	return s.db.Model(&entities.BotWebhook{}).Where("bot_id = ?", botID).Updates(map[string]interface{}{
		"last_error_message": "",
		"last_error_date":    nil,
	}).Error
}

func (s *BotWebhookStore) SetPendingCount(botID uuid.UUID, count int) error {
	return s.db.Model(&entities.BotWebhook{}).Where("bot_id = ?", botID).Update("pending_update_count", count).Error
}

func (s *BotWebhookStore) IncrementPending(botID uuid.UUID) error {
	return s.db.Model(&entities.BotWebhook{}).Where("bot_id = ?", botID).
		UpdateColumn("pending_update_count", gorm.Expr("pending_update_count + 1")).Error
}

func (s *BotWebhookStore) DecrementPending(botID uuid.UUID, n int) error {
	if n <= 0 {
		return nil
	}
	return s.db.Model(&entities.BotWebhook{}).Where("bot_id = ?", botID).
		UpdateColumn("pending_update_count", gorm.Expr("GREATEST(pending_update_count - ?, 0)", n)).Error
}

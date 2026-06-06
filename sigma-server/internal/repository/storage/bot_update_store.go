package storage

import (
	"time"

	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
	"gorm.io/gorm"
)

type BotUpdateStore struct {
	db *gorm.DB
}

func NewBotUpdateStore(db *gorm.DB) *BotUpdateStore {
	return &BotUpdateStore{db: db}
}

func (s *BotUpdateStore) NextUpdateID(botID uuid.UUID) (int64, error) {
	var maxID int64
	err := s.db.Model(&entities.BotUpdate{}).
		Where("bot_id = ?", botID).
		Select("COALESCE(MAX(update_id), 0)").
		Scan(&maxID).Error
	return maxID + 1, err
}

func (s *BotUpdateStore) Create(update *entities.BotUpdate) error {
	return s.db.Create(update).Error
}

func (s *BotUpdateStore) FetchPending(botID uuid.UUID, offset int64, limit int) ([]entities.BotUpdate, error) {
	if limit <= 0 {
		limit = 100
	}
	if limit > 100 {
		limit = 100
	}

	var rows []entities.BotUpdate
	q := s.db.Where("bot_id = ? AND delivered_at IS NULL AND update_id > ?", botID, offset).
		Order("update_id ASC").
		Limit(limit)
	err := q.Find(&rows).Error
	return rows, err
}

func (s *BotUpdateStore) MarkDelivered(botID uuid.UUID, updateIDs []int64) error {
	if len(updateIDs) == 0 {
		return nil
	}
	now := time.Now()
	return s.db.Model(&entities.BotUpdate{}).
		Where("bot_id = ? AND update_id IN ?", botID, updateIDs).
		Update("delivered_at", now).Error
}

func (s *BotUpdateStore) DeletePending(botID uuid.UUID) error {
	return s.db.Where("bot_id = ? AND delivered_at IS NULL", botID).Delete(&entities.BotUpdate{}).Error
}

func (s *BotUpdateStore) CountPending(botID uuid.UUID) (int64, error) {
	var count int64
	err := s.db.Model(&entities.BotUpdate{}).
		Where("bot_id = ? AND delivered_at IS NULL", botID).
		Count(&count).Error
	return count, err
}

func (s *BotUpdateStore) HasWebhook(botID uuid.UUID) (bool, error) {
	var count int64
	err := s.db.Model(&entities.BotWebhook{}).Where("bot_id = ? AND url <> ''", botID).Count(&count).Error
	return count > 0, err
}

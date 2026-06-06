package entities

import (
	"time"

	"github.com/google/uuid"
)

type BotUpdate struct {
	ID          int64      `gorm:"primaryKey;autoIncrement"`
	BotID       uuid.UUID  `gorm:"column:bot_id;type:uuid;not null;index:idx_bot_updates_bot_update,priority:1"`
	UpdateID    int64      `gorm:"column:update_id;not null;index:idx_bot_updates_bot_update,priority:2"`
	Payload     []byte     `gorm:"type:jsonb;not null"`
	DeliveredAt *time.Time `gorm:"column:delivered_at"`
	CreatedAt   time.Time  `gorm:"column:created_at;autoCreateTime"`
}

func (BotUpdate) TableName() string {
	return "bot_updates"
}

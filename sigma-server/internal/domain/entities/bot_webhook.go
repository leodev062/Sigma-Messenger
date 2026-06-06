package entities

import (
	"time"

	"github.com/google/uuid"
)

type BotWebhook struct {
	BotID                uuid.UUID `gorm:"primaryKey;column:bot_id;type:uuid"`
	URL                  string    `gorm:"not null"`
	SecretToken          string    `gorm:"column:secret_token"`
	MaxConnections       int       `gorm:"column:max_connections;default:40"`
	AllowedUpdates       string    `gorm:"column:allowed_updates;type:text"`
	LastErrorMessage     string    `gorm:"column:last_error_message;type:text"`
	LastErrorDate        *time.Time `gorm:"column:last_error_date"`
	PendingUpdateCount   int       `gorm:"column:pending_update_count;default:0"`
	UpdatedAt            time.Time `gorm:"column:updated_at"`
}

func (BotWebhook) TableName() string {
	return "bot_webhooks"
}

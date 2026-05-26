package entities

import (
	"time"

	"github.com/google/uuid"
)

type PreKey struct {
	ID          int       `gorm:"primaryKey;autoIncrement" json:"id"`
	RecipientID uuid.UUID `gorm:"type:uuid;column:recipient_id" json:"recipient_id"`
	KeyID       int       `gorm:"column:key_id" json:"key_id"`
	PublicKey   string    `gorm:"column:public_key" json:"public_key"`
	CreatedAt   time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
}

func (PreKey) TableName() string {
	return "pre_keys"
}

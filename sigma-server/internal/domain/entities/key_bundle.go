package entities

import (
	"time"

	"github.com/google/uuid"
)

type KeyBundle struct {
	ID        int       `gorm:"primaryKey;autoIncrement" json:"id"`
	AccountID uuid.UUID `gorm:"type:uuid;column:account_id" json:"account_id"`
	Payload   []byte    `gorm:"column:payload;type:bytea" json:"payload"`
	CreatedAt time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
}

func (KeyBundle) TableName() string {
	return "key_bundles"
}

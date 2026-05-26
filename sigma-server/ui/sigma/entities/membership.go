package entities

import (
	"time"

	"github.com/google/uuid"
)

type Membership struct {
	ChatID   uuid.UUID `gorm:"primaryKey;column:recipient_id;type:uuid" json:"chat_id"`
	UserID   uuid.UUID `gorm:"primaryKey;column:user_id;type:uuid" json:"user_id"`
	Role     string    `gorm:"default:'member'" json:"role"`
	IsMuted  bool      `gorm:"column:is_muted;default:false" json:"is_muted"`
	JoinedAt time.Time `gorm:"column:joined_at;default:CURRENT_TIMESTAMP" json:"joined_at"`
}

func (Membership) TableName() string {
	return "memberships"
}

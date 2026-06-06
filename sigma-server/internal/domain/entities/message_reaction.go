package entities

import (
	"time"

	"github.com/google/uuid"
)

type MessageReaction struct {
	ID        int       `gorm:"primaryKey;autoIncrement" json:"id"`
	MessageID uuid.UUID `gorm:"type:uuid;column:message_id;index" json:"message_id"`
	ReactorID uuid.UUID `gorm:"type:uuid;column:reactor_id;index" json:"reactor_id"`
	Reaction  string    `gorm:"type:text;not null" json:"reaction"`
	CreatedAt time.Time `gorm:"autoCreateTime" json:"created_at"`
}

func (MessageReaction) TableName() string {
	return "message_reactions"
}

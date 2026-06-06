package entities

import (
	"time"

	"github.com/google/uuid"
)

type BotConversationState struct {
	UserID    uuid.UUID `gorm:"primaryKey;column:user_id;type:uuid"`
	BotID     uuid.UUID `gorm:"primaryKey;column:bot_id;type:uuid"`
	Step      string    `gorm:"column:step;size:50"`
	Metadata  string    `gorm:"column:metadata;type:text"`
	UpdatedAt time.Time `gorm:"column:updated_at"`
}

func (BotConversationState) TableName() string {
	return "bot_conversation_states"
}

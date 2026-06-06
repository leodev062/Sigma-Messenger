package entities

import "time"

type Chat struct {
	ID               int       `gorm:"primaryKey" json:"id"`
	Title            string    `gorm:"not null" json:"title"`
	Type             string    `gorm:"type:chat_type;not null" json:"type"`
	ParticipantCount int       `gorm:"default:1" json:"participant_count"`
	CreatedAt        time.Time `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	Username         *string   `gorm:"unique" json:"username"`
	VerificationType string    `gorm:"default:'none'" json:"verification_type"`
	AvatarURL        *string   `json:"avatar_url"`
	Description      *string   `json:"description"`
	OwnerID          *int      `gorm:"column:owner_id" json:"owner_id"`
}

func (Chat) TableName() string {
	return "chats"
}

package entities

import (
	"time"

	"github.com/google/uuid"
)

type Account struct {
	ID               uuid.UUID  `gorm:"type:uuid;default:gen_random_uuid();primaryKey" json:"id"`
	Type             string     `gorm:"default:'individual'" json:"type"`
	FirebaseUID      *string    `gorm:"column:firebase_uid;unique" json:"firebase_uid,omitempty"`
	Phone            *string    `gorm:"unique" json:"phone"`
	DisplayName      *string    `gorm:"column:display_name" json:"name"`
	Username         *string    `gorm:"unique" json:"username"`
	AvatarURL        *string    `gorm:"column:avatar_url" json:"avatar_url"`
	IsOnline         bool       `gorm:"default:false" json:"is_online"`
	FCMToken         *string    `gorm:"column:fcm_token" json:"fcm_token"`
	Email            *string    `gorm:"unique" json:"email"`
	Bio              *string    `gorm:"default:'Olá! Estou usando o Sigma.'" json:"bio"`
	Country          *string    `gorm:"column:country" json:"country,omitempty"`
	IsPrivateProfile bool       `gorm:"column:is_private_profile;default:false" json:"is_private_profile"`
	VerificationType string     `gorm:"column:verification_type;default:'none'" json:"verification_type"`
	OwnerID          *uuid.UUID `gorm:"column:owner_id;type:uuid" json:"owner_id"`
	BotToken         *string    `gorm:"column:bot_token;unique" json:"bot_token,omitempty"`
	ParticipantCount int        `gorm:"column:participant_count;default:0" json:"participant_count"`
	CreatedAt        time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	UpdatedAt        time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"updated_at"`
}

func (Account) TableName() string {
	return "recipients"
}

package entities

import "github.com/google/uuid"

type Account struct {
	ID           string `gorm:"primaryKey" json:"id"`
	UserID       string `json:"user_id"`
	Email        *string  `json:"email"`
	PasswordHash string  `json:"password_hash"`
	FCMToken     *string `json:"fcm_token"`
	IsVerified   bool    `gorm:"default:false" json:"is_verified"`
	CreatedAt    int64  `json:"created_at"`

	// Profile fields
	Phone            *string `json:"phone"`
	DisplayName      *string `json:"display_name"`
	Username         *string `json:"username"`
	AvatarURL        *string `json:"avatar_url"`
	Bio              *string `json:"bio"`
	IsPrivateProfile bool    `json:"is_private_profile"`
	Country          *string `json:"country"`

	// CSFA / Bot fields
	Type             string     `json:"type"`
	OwnerID          *uuid.UUID `json:"owner_id"`
	BotToken         *string    `json:"bot_token"`
	VerificationType string     `json:"verification_type"`
}

func (Account) TableName() string {
	return "accounts"
}

package entities

type Account struct {
	ID           string `gorm:"primaryKey" json:"id"`
	UserID       string `json:"user_id"`
	Email        string  `json:"email"`
	PasswordHash string  `json:"password_hash"`
	FCMToken     *string `json:"fcm_token"`
	IsVerified   bool    `gorm:"default:false" json:"is_verified"`
	CreatedAt    int64  `json:"created_at"`

	// CSFA / Bot fields
	Type             string     `json:"type"`
	DisplayName      *string    `json:"display_name"`
	Username         *string    `json:"username"`
	OwnerID          *uuid.UUID `json:"owner_id"`
	BotToken         *string    `json:"bot_token"`
	VerificationType string     `json:"verification_type"`
}

func (Account) TableName() string {
	return "accounts"
}

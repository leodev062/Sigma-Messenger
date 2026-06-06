package dto

import "github.com/google/uuid"

// CreateAccountRequest is intentionally flexible so the new API can accept the
// same fields that the legacy controller handled.
type CreateAccountRequest struct {
	Phone     string `json:"phone"`
	Email     string `json:"email"`
	Name      string `json:"name"`
	Username  string `json:"username"`
	AvatarURL string `json:"avatar_url"`
	Bio       string `json:"bio"`
	Country   string `json:"country"`
	IsPrivate bool   `json:"is_private"`
}

type UpdateAccountRequest struct {
	Name      string `json:"name"`
	AvatarURL string `json:"avatar_url"`
	Username  string `json:"username"`
	Bio       string `json:"bio"`
	Country   string `json:"country"`
	IsPrivate *bool  `json:"is_private"`
}

type SyncContactsRequest struct {
	Phones []string `json:"phones"`
}

type UpdateFCMTokenRequest struct {
	UserID   string `json:"user_id"`
	FCMToken string `json:"fcm_token"`
}

type SyncRecipientsRequest struct {
	IDs []string `json:"ids"`
}

type SyncRecipientsResponse struct {
	Recipients []uuid.UUID `json:"recipients"`
}

type AccountSearchResult struct {
	ID        string `json:"id"`
	Username  string `json:"username"`
	Name      string `json:"name"`
	Phone     string `json:"phone"`
	AvatarURL string `json:"avatar_url"`
}

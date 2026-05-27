package dto

import "github.com/google/uuid"

// CreateAccountRequest is intentionally flexible so the new API can accept the
// same fields that the legacy controller handled.
type CreateAccountRequest struct {
	Phone                 string        `json:"phone"`
	Email                 string        `json:"email"`
	Name                  string        `json:"name"`
	Username              string        `json:"username"`
	AvatarURL             string        `json:"avatar_url"`
	Bio                   string        `json:"bio"`
	Country               string        `json:"country"`
	RelativeName          string        `json:"relative_name"`
	RelativeID            string        `json:"relative_id"`
	IdentityKey           string        `json:"identity_key"`
	SignedPreKeyID        int           `json:"signed_pre_key_id"`
	SignedPreKeyPublic    string        `json:"signed_pre_key_public"`
	SignedPreKeySignature string        `json:"signed_pre_key_signature"`
	RegistrationID        int64         `json:"registration_id"`
	PreKeys               []PreKeyEntry `json:"pre_keys"`
}

type UpdateAccountRequest struct {
	Name                  string        `json:"name"`
	AvatarURL             string        `json:"avatar_url"`
	Username              string        `json:"username"`
	Bio                   string        `json:"bio"`
	Country               string        `json:"country"`
	RelativeName          string        `json:"relative_name"`
	RelativeID            string        `json:"relative_id"`
	IdentityKey           string        `json:"identity_key"`
	SignedPreKeyID        int           `json:"signed_pre_key_id"`
	SignedPreKeyPublic    string        `json:"signed_pre_key_public"`
	SignedPreKeySignature string        `json:"signed_pre_key_signature"`
	RegistrationID        int64         `json:"registration_id"`
	PreKeys               []PreKeyEntry `json:"pre_keys"`
}

type EditProfileRequest struct {
	UserID                string        `json:"user_id"`
	Name                  string        `json:"name"`
	AvatarURL             string        `json:"avatar_url"`
	Username              string        `json:"username"`
	Bio                   string        `json:"bio"`
	Country               string        `json:"country"`
	RelativeName          string        `json:"relative_name"`
	RelativeID            string        `json:"relative_id"`
	IdentityKey           string        `json:"identity_key"`
	SignedPreKeyID        int           `json:"signed_pre_key_id"`
	SignedPreKeyPublic    string        `json:"signed_pre_key_public"`
	SignedPreKeySignature string        `json:"signed_pre_key_signature"`
	RegistrationID        int64         `json:"registration_id"`
	PreKeys               []PreKeyEntry `json:"pre_keys"`
}

type PreKeyEntry struct {
	ID  int    `json:"id"`
	Key string `json:"key"`
}

type KeysResponse struct {
	RegistrationID        int64  `json:"registration_id"`
	PreKeyID              int    `json:"pre_key_id"`
	PreKeyPublic          string `json:"pre_key_public"`
	SignedPreKeyID        int    `json:"signed_pre_key_id"`
	SignedPreKeyPublic    string `json:"signed_pre_key_public"`
	SignedPreKeySignature string `json:"signed_pre_key_signature"`
	IdentityKey           string `json:"identity_key"`
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
	ID          string `json:"id"`
	Username    string `json:"username"`
	DisplayName string `json:"display_name"`
	AvatarURL   string `json:"avatar_url"`
}

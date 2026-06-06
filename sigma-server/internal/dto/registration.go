package dto

type CreateVerificationSessionRequest struct {
	Number            string  `json:"number" binding:"required,e164"`
	ClientType        string  `json:"client_type"`
	CaptchaToken      *string `json:"captcha_token,omitempty"`
	PushTokenRequired *bool   `json:"push_token_required,omitempty"`
}

type UpdateVerificationSessionRequest struct {
	CaptchaToken     *string `json:"captcha_token,omitempty"`
	PushChallengeKey *string `json:"push_challenge_key,omitempty"`
	PushToken        *string `json:"push_token,omitempty"`
}

type SendVerificationCodeRequest struct {
	SessionID      string  `json:"session_id" binding:"required"`
	Transport      string  `json:"transport" binding:"required,oneof=SMS VOICE"`
	Language       *string `json:"language,omitempty"`
	SenderOverride *string `json:"sender_override,omitempty"`
}

type CheckVerificationCodeRequest struct {
	SessionID        string `json:"session_id" binding:"required"`
	VerificationCode string `json:"verification_code" binding:"required"`
	DeviceID         string `json:"device_id"`
	DeviceName       string `json:"device_name"`
	Platform         string `json:"platform"`
	ClientVersion    string `json:"client_version"`
}

type RegistrationCreateAccountRequest struct {
	SessionID     string  `json:"session_id" binding:"required"`
	Password      string  `json:"password" binding:"required,min=8"`
	DeviceName    string  `json:"device_name" binding:"required"`
	DeviceID      string  `json:"device_id"`
	Platform      string  `json:"platform"`
	ClientVersion string  `json:"client_version"`
	AccessKey     *string `json:"access_key,omitempty"`
}

type VerificationSessionResponse struct {
	SessionID            string                 `json:"session_id"`
	Status               string                 `json:"status"` // pending, verified, expired
	E164                 string                 `json:"e164"`
	RequestedInfo        []string               `json:"requested_info,omitempty"`
	SubmittedInfo        []string               `json:"submitted_info,omitempty"`
	AllowedToRequestCode bool                   `json:"allowed_to_request_code"`
	ExpiresAt            int64                  `json:"expires_at"`
	AccountExists        bool                   `json:"account_exists"`
	AccountData          map[string]interface{} `json:"account_data,omitempty"`
	Token                string                 `json:"token,omitempty"`
}

type AuthCheckRequest struct {
	Number string   `json:"number" binding:"required,e164"`
	Tokens []string `json:"tokens" binding:"required,max=10"`
}

type AuthCheckResponseV2 struct {
	Matches map[string]string `json:"matches"` // token -> match/no-match/invalid
}

const (
	AuthCheckResultMatch   = "match"
	AuthCheckResultNoMatch = "no-match"
	AuthCheckResultInvalid = "invalid"
)

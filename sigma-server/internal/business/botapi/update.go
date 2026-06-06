package botapi

// Update is the payload delivered via webhook or getUpdates (Telegram-compatible shape).
type Update struct {
	UpdateID int64    `json:"update_id"`
	Message  *Message `json:"message,omitempty"`
}

type Message struct {
	MessageID int64  `json:"message_id"`
	From      *User  `json:"from,omitempty"`
	Chat      *Chat  `json:"chat"`
	Date      int64  `json:"date"`
	Text      string `json:"text,omitempty"`
}

type User struct {
	ID        string `json:"id"`
	IsBot     bool   `json:"is_bot"`
	FirstName string `json:"first_name"`
	Username  string `json:"username,omitempty"`
}

type Chat struct {
	ID   string `json:"id"`
	Type string `json:"type"`
}

type BotInfo struct {
	ID        string `json:"id"`
	IsBot     bool   `json:"is_bot"`
	FirstName string `json:"first_name"`
	Username  string `json:"username,omitempty"`
}

type WebhookInfo struct {
	URL                  string `json:"url,omitempty"`
	HasCustomCertificate bool   `json:"has_custom_certificate"`
	PendingUpdateCount   int    `json:"pending_update_count"`
	LastErrorDate        *int64 `json:"last_error_date,omitempty"`
	LastErrorMessage     string `json:"last_error_message,omitempty"`
	MaxConnections       int    `json:"max_connections,omitempty"`
}

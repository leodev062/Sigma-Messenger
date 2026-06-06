package dto

type BotAPISetWebhookRequest struct {
	URL                string   `json:"url"`
	Certificate        string   `json:"certificate,omitempty"`
	IPAddress          string   `json:"ip_address,omitempty"`
	MaxConnections     int      `json:"max_connections,omitempty"`
	AllowedUpdates     []string `json:"allowed_updates,omitempty"`
	DropPendingUpdates bool     `json:"drop_pending_updates,omitempty"`
	SecretToken        string   `json:"secret_token,omitempty"`
}

type BotAPISendMessageRequest struct {
	ChatID string `json:"chat_id"`
	Text   string `json:"text"`
}

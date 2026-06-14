package entities

type Envelope struct {
	EnvelopeID      string `gorm:"primaryKey" json:"envelope_id"`
	MessageID       string `json:"message_id"`
	FromUserID      string `json:"from_user_id"`
	DestinationType string `json:"destination_type"`
	DestinationID   string `json:"destination_id"`
	Payload         []byte `gorm:"type:bytea" json:"payload"`
	Status          string `gorm:"default:'pending'" json:"status"`
	CreatedAt       int64  `json:"created_at"`
	DeliverAt       int64  `json:"deliver_at"`
}

func (Envelope) TableName() string {
	return "envelopes"
}

package entities

import (
	"time"

	"github.com/google/uuid"
)

type PendingMessage struct {
	ID            int       `gorm:"primaryKey;autoIncrement" json:"id"`
	Envelope      []byte    `gorm:"type:bytea;not null" json:"envelope"`
	Timestamp     int64     `gorm:"not null" json:"timestamp"`
	ExpiresAt     time.Time `gorm:"default:(now() + '7 days'::interval)" json:"expires_at"`
	DestinationID uuid.UUID `gorm:"type:uuid;column:destination_id" json:"destination_id"`
	MessageID     uuid.UUID `gorm:"type:uuid;column:message_id" json:"message_id"`
}

func (PendingMessage) TableName() string {
	return "pending_envelopes"
}

func (m *PendingMessage) SetPayload(payload []byte) {
	// Apenas guardamos os bytes originais (Envelope Protobuf)
	m.Envelope = append([]byte(nil), payload...)
}

func (m *PendingMessage) Payload() ([]byte, error) {
	return m.Envelope, nil
}

package entities

import (
	"encoding/base64"
	"time"

	"google.golang.org/protobuf/proto"

	"github.com/google/uuid"

	sigmapb "sigma-server/proto"
)

type PendingMessage struct {
	ID            int       `gorm:"primaryKey;autoIncrement" json:"id"`
	Envelope      string    `gorm:"type:jsonb;not null" json:"envelope"`
	Timestamp     int64     `gorm:"not null" json:"timestamp"`
	ExpiresAt     time.Time `gorm:"default:(now() + '7 days'::interval)" json:"expires_at"`
	DestinationID uuid.UUID `gorm:"type:uuid;column:destination_id" json:"destination_id"`
	MessageID     uuid.UUID `gorm:"type:uuid;column:message_id" json:"message_id"`
}

func (PendingMessage) TableName() string {
	return "pending_envelopes"
}

func (m *PendingMessage) SetPayload(payload []byte) {
	envelope := &sigmapb.Envelope{
		Type:      sigmapb.Envelope_CIPHERTEXT,
		Source:    m.DestinationID.String(),
		Timestamp: uint64(m.Timestamp),
		Content:   append([]byte(nil), payload...),
	}

	serialized, err := proto.Marshal(envelope)
	if err != nil {
		m.Envelope = base64.StdEncoding.EncodeToString(payload)
		return
	}

	m.Envelope = base64.StdEncoding.EncodeToString(serialized)
}

func (m *PendingMessage) Payload() ([]byte, error) {
	serialized, err := base64.StdEncoding.DecodeString(m.Envelope)
	if err != nil {
		return nil, err
	}

	envelope := &sigmapb.Envelope{}
	if err := proto.Unmarshal(serialized, envelope); err != nil {
		return nil, err
	}

	return append([]byte(nil), envelope.GetContent()...), nil
}

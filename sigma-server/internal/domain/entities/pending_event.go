package entities

import (
	"time"

	"github.com/google/uuid"
)

type PendingEvent struct {
	ID           int       `gorm:"primaryKey;autoIncrement" json:"id"`
	EventType    string    `gorm:"not null" json:"event_type"`
	TargetUserID uuid.UUID `gorm:"type:uuid;column:target_user_id;not null" json:"target_user_id"`
	Payload      []byte    `gorm:"type:bytea;not null" json:"payload"` // Mudado para bytea para consistência com envelopes
	CreatedAt    int64     `gorm:"not null" json:"created_at"`
	ExpiresAt    time.Time `gorm:"default:(now() + '7 days'::interval)" json:"expires_at"`
}

func (PendingEvent) TableName() string {
	return "pending_events"
}

func (m *PendingEvent) PayloadBytes() []byte {
	return m.Payload
}

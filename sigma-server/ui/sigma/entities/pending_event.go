package entities

import (
	"time"

	"github.com/google/uuid"
)

type PendingEvent struct {
	ID           int       `gorm:"primaryKey;autoIncrement" json:"id"`
	EventType    string    `gorm:"not null" json:"event_type"`
	TargetUserID uuid.UUID `gorm:"type:uuid;column:target_user_id;not null" json:"target_user_id"`
	Payload      string    `gorm:"type:jsonb;not null" json:"payload"`
	CreatedAt    int64     `gorm:"not null" json:"created_at"`
	ExpiresAt    time.Time `gorm:"default:(now() + '7 days'::interval)" json:"expires_at"`
}

func (PendingEvent) TableName() string {
	return "pending_events"
}

func (m *PendingEvent) PayloadBytes() []byte {
	return []byte(m.Payload)
}

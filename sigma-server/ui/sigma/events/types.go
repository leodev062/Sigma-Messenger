package events

import (
	"encoding/json"
	"time"

	"github.com/google/uuid"
)

type EventType string

const (
	ProfileChanged            EventType = "PROFILE_CHANGED"
	ContactUpdated            EventType = "CONTACT_UPDATED"
	VerificationStatusChanged EventType = "VERIFICATION_STATUS_CHANGED"
)

type EventEnvelope struct {
	ID             string         `json:"id"`
	Type           EventType      `json:"type"`
	SourceUserID   string         `json:"source_user_id"`
	TargetUserIDs  []string       `json:"target_user_ids,omitempty"`
	Payload        map[string]any `json:"payload"`
	CreatedAt      int64          `json:"created_at"`
	SourceServerID string         `json:"source_server_id,omitempty"`
}

func NewEnvelope(eventType EventType, sourceUserID string, targets []string, payload map[string]any) EventEnvelope {
	if payload == nil {
		payload = map[string]any{}
	}

	return EventEnvelope{
		ID:            uuid.NewString(),
		Type:          eventType,
		SourceUserID:  sourceUserID,
		TargetUserIDs: append([]string(nil), targets...),
		Payload:       payload,
		CreatedAt:     time.Now().UnixMilli(),
	}
}

func (e EventEnvelope) Marshal() ([]byte, error) {
	return json.Marshal(e)
}

func DecodeEnvelope(payload []byte) (EventEnvelope, error) {
	var envelope EventEnvelope
	if err := json.Unmarshal(payload, &envelope); err != nil {
		return EventEnvelope{}, err
	}
	return envelope, nil
}

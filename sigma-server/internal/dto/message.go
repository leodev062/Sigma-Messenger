package dto

import (
	"time"

	"github.com/google/uuid"
)

type MessageReactionRequest struct {
	Reaction string `json:"reaction"`
}

type MessageReactionResponse struct {
	MessageID uuid.UUID `json:"message_id"`
	ReactorID uuid.UUID `json:"reactor_id"`
	Reaction  string    `json:"reaction"`
	CreatedAt time.Time `json:"created_at"`
}

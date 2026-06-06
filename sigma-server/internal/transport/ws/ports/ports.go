package ports

import (
	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
)

// TokenValidator validates JWT access tokens for websocket upgrades.
type TokenValidator interface {
	ValidateToken(token string) (userID string, err error)
}

// PendingMessageStore reads and acknowledges queued envelopes.
type PendingMessageStore interface {
	FindPendingByAccountID(accountID uuid.UUID) ([]entities.PendingMessage, error)
	DeleteForRecipient(id int, recipientID uuid.UUID) (int64, error)
	DeleteByMessageIDForRecipient(messageID, recipientID uuid.UUID) (int64, error)
}

// PendingEventStore reads and removes one-time push events.
type PendingEventStore interface {
	FindPendingByAccountID(accountID uuid.UUID) ([]entities.PendingEvent, error)
	Delete(id int) error
}

// AccountKeysReader fetches the protobuf PreKeyBundle from key_bundles.
type AccountKeysReader interface {
	GetKeys(accountID uuid.UUID) ([]byte, error)
}

// OutboundSession sends websocket responses to a connected client.
type OutboundSession interface {
	UserID() string
	SendResponse(requestID string, status int, body []byte)
	Enqueue(payload []byte) bool
}

// OutboundDispatcher routes outgoing websocket messages by recipient type.
type OutboundDispatcher interface {
	Dispatch(senderID, recipientID string, payload []byte) error
}

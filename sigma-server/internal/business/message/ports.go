package message

import (
	"context"

	"sigma-server/internal/domain/entities"
	"sigma-server/internal/domain/valueobjects"

	"github.com/google/uuid"
)

// RecipientInfo is the destination of an outgoing message.
type RecipientInfo struct {
	ID   uuid.UUID
	Type valueobjects.RecipientType
}

// MemberInfo is a chat member used for group/channel fan-out.
type MemberInfo struct {
	UserID  uuid.UUID
	Type    valueobjects.RecipientType
	IsMuted bool
}

type RecipientStore interface {
	FindRecipient(ctx context.Context, id uuid.UUID) (*RecipientInfo, error)
	ListMembers(ctx context.Context, chatID uuid.UUID) ([]MemberInfo, error)
	IsMember(ctx context.Context, chatID, userID uuid.UUID) (bool, error)
	GetMembership(ctx context.Context, chatID, userID uuid.UUID) (*entities.Membership, error)
}

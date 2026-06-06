package message

import (
	"context"
	"errors"

	"sigma-server/internal/domain/valueobjects"

	"github.com/google/uuid"
)

// DeliveryTarget describes one outbound leg after routing.
type DeliveryTarget struct {
	UserID   uuid.UUID
	SkipPush bool
}

// RoutePlan is the result of resolving a message destination.
type RoutePlan struct {
	Targets      []DeliveryTarget
	Silent       bool // bots in groups/channels do not respond
	HandleAsBot  bool
	Recipient    RecipientInfo
}

type Router struct {
	recipients RecipientStore
}

func NewRouter(recipients RecipientStore) *Router {
	return &Router{recipients: recipients}
}

func (r *Router) Resolve(ctx context.Context, senderID, destinationID uuid.UUID) (*RoutePlan, error) {
	if r == nil || r.recipients == nil {
		return nil, errors.New("message router is not configured")
	}
	if senderID == uuid.Nil || destinationID == uuid.Nil {
		return nil, errors.New("sender and destination are required")
	}

	recipient, err := r.recipients.FindRecipient(ctx, destinationID)
	if err != nil {
		return nil, err
	}

	plan := &RoutePlan{Recipient: *recipient}

	switch recipient.Type {
	case valueobjects.RecipientBot:
		plan.HandleAsBot = true
		plan.Targets = []DeliveryTarget{{UserID: senderID}}
		return plan, nil

	case valueobjects.RecipientIndividual:
		if destinationID == senderID {
			return nil, errors.New("cannot send a message to yourself")
		}
		plan.Targets = []DeliveryTarget{{UserID: destinationID}}
		return plan, nil

	case valueobjects.RecipientGroup, valueobjects.RecipientChannel:
		isMember, err := r.recipients.IsMember(ctx, destinationID, senderID)
		if err != nil {
			return nil, err
		}
		if !isMember {
			return nil, errors.New("sender is not a member of this chat")
		}
		members, err := r.recipients.ListMembers(ctx, destinationID)
		if err != nil {
			return nil, err
		}
		for _, member := range members {
			if member.UserID == senderID {
				continue
			}
			// Bots só respondem em conversa 1:1 (type=bot), não em grupos/canais.
			if member.Type.IsBot() {
				continue
			}
			plan.Targets = append(plan.Targets, DeliveryTarget{
				UserID:   member.UserID,
				SkipPush: member.IsMuted,
			})
		}
		return plan, nil

	default:
		return nil, errors.New("unsupported recipient type")
	}
}

// ShouldBotStaySilent returns true when a bot must ignore the message (e.g. group chat).
func ShouldBotStaySilent(recipientType valueobjects.RecipientType, senderInGroup bool) bool {
	if recipientType.IsBot() {
		return false
	}
	return recipientType.IsBroadcast() && senderInGroup
}

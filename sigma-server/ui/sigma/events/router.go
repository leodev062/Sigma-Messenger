package events

import (
	"context"

	"sigma-server/ui/sigma/delivery"
	"sigma-server/ui/sigma/entities"

	"github.com/google/uuid"
)

type PresenceBroadcaster interface {
	IsOnline(userID string) bool
	Send(userID string, payload []byte) bool
}

type PushSender interface {
	SendWakeupPush(token string) error
}

type AccountFinder interface {
	FindByID(id uuid.UUID) (*entities.Account, error)
}

type EventStore interface {
	Save(event *entities.PendingEvent) error
	FindPendingByAccountID(uuid.UUID) ([]entities.PendingEvent, error)
	Delete(int) error
}

type EventHub interface {
	Publish(ctx context.Context, event EventEnvelope) error
}

type ContactResolver interface {
	ResolveContacts(userID uuid.UUID) ([]uuid.UUID, error)
}

type EventDispatcher interface {
	Deliver(targetID string, eventType string, payload []byte) error
	DeliverTargets(targetIDs []string, eventType string, payload []byte) error
}

type Router struct {
	dispatcher      EventDispatcher
	hub             EventHub
	contactResolver ContactResolver
	sourceServerID  string
}

func NewRouter(store EventStore, presence PresenceBroadcaster, push PushSender, accounts AccountFinder, hub EventHub, contactResolver ...ContactResolver) *Router {
	dispatcher := delivery.NewEventDeliveryService(presence, store, accounts, push, nil)
	return NewRouterWithDelivery(dispatcher, hub, contactResolver...)
}

func NewRouterWithDelivery(dispatcher EventDispatcher, hub EventHub, contactResolver ...ContactResolver) *Router {
	var resolver ContactResolver
	if len(contactResolver) > 0 {
		resolver = contactResolver[0]
	}

	return &Router{
		dispatcher:      dispatcher,
		hub:             hub,
		contactResolver: resolver,
		sourceServerID:  uuid.NewString(),
	}
}

func (r *Router) PublishProfileChanged(ctx context.Context, account *entities.Account) error {
	payload := map[string]any{
		"user_id":           account.ID.String(),
		"display_name":      derefString(account.DisplayName),
		"username":          derefString(account.Username),
		"avatar_url":        derefString(account.AvatarURL),
		"bio":               derefString(account.Bio),
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(ProfileChanged, account.ID.String(), []string{account.ID.String()}, payload)
	event.SourceServerID = r.sourceServerID
	return r.publish(ctx, event)
}

func (r *Router) PublishContactUpdated(ctx context.Context, account *entities.Account) error {
	if r.contactResolver == nil {
		return nil
	}

	contacts, err := r.contactResolver.ResolveContacts(account.ID)
	if err != nil {
		return err
	}

	targets := make([]string, 0, len(contacts))
	for _, contact := range contacts {
		targets = append(targets, contact.String())
	}

	payload := map[string]any{
		"user_id":           account.ID.String(),
		"display_name":      derefString(account.DisplayName),
		"username":          derefString(account.Username),
		"avatar_url":        derefString(account.AvatarURL),
		"bio":               derefString(account.Bio),
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(ContactUpdated, account.ID.String(), targets, payload)
	event.SourceServerID = r.sourceServerID
	return r.publish(ctx, event)
}

func (r *Router) PublishVerificationStatusChanged(ctx context.Context, account *entities.Account) error {
	payload := map[string]any{
		"user_id":           account.ID.String(),
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(VerificationStatusChanged, account.ID.String(), []string{account.ID.String()}, payload)
	event.SourceServerID = r.sourceServerID
	return r.publish(ctx, event)
}

func (r *Router) HandleRemote(ctx context.Context, event EventEnvelope) error {
	if event.SourceServerID == r.sourceServerID {
		return nil
	}
	return r.publish(ctx, event)
}

func (r *Router) publish(ctx context.Context, event EventEnvelope) error {
	if event.SourceServerID == "" {
		event.SourceServerID = r.sourceServerID
	}

	payload, err := event.Marshal()
	if err != nil {
		return err
	}

	if err := r.dispatcher.DeliverTargets(event.TargetUserIDs, string(event.Type), payload); err != nil {
		return err
	}

	if r.hub != nil {
		return r.hub.Publish(ctx, event)
	}

	return nil
}

func derefString(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}

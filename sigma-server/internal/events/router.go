package events

import (
	"context"

	"sigma-server/internal/delivery"
	"sigma-server/internal/domain/entities"

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
	FindByID(id any) (*entities.Account, error)
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
		"user_id":           account.ID,
		"display_name":      derefString(account.DisplayName),
		"username":          derefString(account.Username),
		"avatar_url":        "", // Profile info should come from User entity if needed
		"bio":               "",
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(ProfileChanged, account.ID, []string{account.ID}, payload)
	event.SourceServerID = r.sourceServerID
	return r.publish(ctx, event)
}

func (r *Router) PublishContactUpdated(ctx context.Context, account *entities.Account) error {
	if r.contactResolver == nil {
		return nil
	}

	uid, _ := uuid.Parse(account.ID)
	contacts, err := r.contactResolver.ResolveContacts(uid)
	if err != nil {
		return err
	}

	targets := make([]string, 0, len(contacts))
	for _, contact := range contacts {
		targets = append(targets, contact.String())
	}

	payload := map[string]any{
		"user_id":           account.ID,
		"display_name":      derefString(account.DisplayName),
		"username":          derefString(account.Username),
		"avatar_url":        "",
		"bio":               "",
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(ContactUpdated, account.ID, targets, payload)
	event.SourceServerID = r.sourceServerID
	return r.publish(ctx, event)
}

func (r *Router) PublishVerificationStatusChanged(ctx context.Context, account *entities.Account) error {
	payload := map[string]any{
		"user_id":           account.ID,
		"verification_type": account.VerificationType,
	}

	event := NewEnvelope(VerificationStatusChanged, account.ID, []string{account.ID}, payload)
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

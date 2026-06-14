package delivery

import (
	"errors"
	"log"
	"strings"
	"time"

	"sigma-server/internal/domain/entities"

	"github.com/google/uuid"
)

type PresenceBroadcaster interface {
	IsOnline(userID string) bool
	Send(userID string, payload []byte) bool
}

type WakeupPusher interface {
	SendWakeupPush(token string) error
}

type AccountFinder interface {
	FindByID(id uuid.UUID) (*entities.Account, error)
}

type EnvelopeStore interface {
	Save(envelope *entities.Envelope) error
}

type EventStore interface {
	Save(event *entities.PendingEvent) error
}

type MessageDeliveryService struct {
	presence PresenceBroadcaster
	store    EnvelopeStore
	accounts AccountFinder
	push     WakeupPusher
	logger   *log.Logger
}

func NewMessageDeliveryService(presence PresenceBroadcaster, store EnvelopeStore, accounts AccountFinder, push WakeupPusher, logger *log.Logger) *MessageDeliveryService {
	if logger == nil {
		logger = log.Default()
	}
	return &MessageDeliveryService{
		presence: presence,
		store:    store,
		accounts: accounts,
		push:     push,
		logger:   logger,
	}
}

func (s *MessageDeliveryService) Deliver(recipientID string, payload []byte, notify ...bool) error {
	if recipientID == "" {
		return errors.New("recipient id is required")
	}
	sendPush := true
	if len(notify) > 0 {
		sendPush = notify[0]
	}
	return s.deliverTargets([]string{recipientID}, payload, sendPush)
}

func (s *MessageDeliveryService) DeliverTargets(recipientIDs []string, payload []byte) error {
	return s.deliverTargets(recipientIDs, payload, true)
}

func (s *MessageDeliveryService) deliverTargets(recipientIDs []string, payload []byte, notify bool) error {
	if s == nil {
		return errors.New("message delivery service is not configured")
	}
	for _, recipientID := range recipientIDs {
		if recipientID == "" {
			continue
		}

		// ALWAYS persist first to ensure at-least-once delivery (Relay Engine pattern)
		if err := s.persistAndNotify(recipientID, payload, notify); err != nil {
			s.logger.Printf("delivery: failed to persist for recipient=%s: %v", recipientID, err)
			return err
		}

		// Try realtime delivery.
		if s.presence != nil && s.presence.IsOnline(recipientID) {
			if s.presence.Send(recipientID, payload) {
				s.logger.Printf("delivery: realtime delivery initiated for recipient=%s", recipientID)
			}
		}
	}
	return nil
}

func (s *MessageDeliveryService) persistAndNotify(recipientID string, payload []byte, notify bool) error {
	if s.store == nil {
		return errors.New("envelope store is not configured")
	}

	uid, err := uuid.Parse(recipientID)
	if err != nil {
		return err
	}

	// NEW: Unmarshal payload to extract Envelope metadata for proper storage
	// We expect payload to be the serialized Protobuf Envelope from the client.
	// (Actually in Relay mode, the client sends Envelope bytes, and we store them).

	// For simple Relay persistence, we just store it as an Envelope record.
	// Since we don't necessarily want to unmarshal EVERY message for performance,
	// we use a simple approach:

	now := time.Now().UnixMilli()
	pending := &entities.Envelope{
		EnvelopeID:    uuid.New().String(), // Unique ID for deletion/ACK
		DestinationID: uid.String(),
		Payload:       append([]byte(nil), payload...),
		Status:        "pending",
		CreatedAt:     now,
		DeliverAt:     now,
	}

	if err := s.store.Save(pending); err != nil {
		return err
	}

	if !notify || s.accounts == nil || s.push == nil {
		return nil
	}

	account, err := s.accounts.FindByID(uid)
	if err != nil {
		s.logger.Printf("message delivery: failed to load account for wakeup push target=%s: %v", uid, err)
		return nil
	}
	if account == nil || account.FCMToken == nil || *account.FCMToken == "" {
		return nil
	}
	if err := s.push.SendWakeupPush(*account.FCMToken); err != nil {
		if strings.Contains(err.Error(), "FCM token unregistered") {
			s.logger.Printf("message delivery: wakeup push skipped for target=%s (token is no longer registered, user probably uninstalled or needs a new token)", uid)
			return nil
		}
		s.logger.Printf("message delivery: failed to send wakeup push target=%s: %v", uid, err)
	}
	return nil
}

type EventDeliveryService struct {
	presence PresenceBroadcaster
	store    EventStore
	accounts AccountFinder
	push     WakeupPusher
	logger   *log.Logger
}

func NewEventDeliveryService(presence PresenceBroadcaster, store EventStore, accounts AccountFinder, push WakeupPusher, logger *log.Logger) *EventDeliveryService {
	if logger == nil {
		logger = log.Default()
	}
	return &EventDeliveryService{
		presence: presence,
		store:    store,
		accounts: accounts,
		push:     push,
		logger:   logger,
	}
}

func (s *EventDeliveryService) Deliver(targetID string, eventType string, payload []byte) error {
	if targetID == "" {
		return errors.New("target id is required")
	}
	return s.DeliverTargets([]string{targetID}, eventType, payload)
}

func (s *EventDeliveryService) DeliverTargets(targetIDs []string, eventType string, payload []byte) error {
	if s == nil {
		return errors.New("event delivery service is not configured")
	}
	for _, targetID := range targetIDs {
		if targetID == "" {
			continue
		}
		if s.presence != nil && s.presence.IsOnline(targetID) && s.presence.Send(targetID, payload) {
			continue
		}
		if err := s.persistAndNotify(targetID, eventType, payload); err != nil {
			return err
		}
	}
	return nil
}

func (s *EventDeliveryService) persistAndNotify(targetID string, eventType string, payload []byte) error {
	if s.store == nil {
		return errors.New("event store is not configured")
	}

	uid, err := uuid.Parse(targetID)
	if err != nil {
		return err
	}

	pending := &entities.PendingEvent{
		EventType:    eventType,
		TargetUserID: uid,
		Payload:      append([]byte(nil), payload...),
		CreatedAt:    time.Now().UnixMilli(),
	}
	if err := s.store.Save(pending); err != nil {
		return err
	}

	if s.accounts == nil || s.push == nil {
		return nil
	}

	account, err := s.accounts.FindByID(uid)
	if err != nil {
		s.logger.Printf("event delivery: failed to load account for wakeup push target=%s: %v", uid, err)
		return nil
	}
	if account == nil || account.FCMToken == nil || *account.FCMToken == "" {
		return nil
	}
	if err := s.push.SendWakeupPush(*account.FCMToken); err != nil {
		if strings.Contains(err.Error(), "FCM token unregistered") {
			s.logger.Printf("event delivery: wakeup push skipped for target=%s (token is no longer registered)", uid)
			return nil
		}
		s.logger.Printf("event delivery: failed to send wakeup push target=%s: %v", uid, err)
	}
	return nil
}

package delivery

import (
	"errors"
	"log"
	"time"

	"sigma-server/ui/sigma/entities"

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

type MessageStore interface {
	Save(message *entities.PendingMessage) error
}

type EventStore interface {
	Save(event *entities.PendingEvent) error
}

type PresenceService struct {
	broadcaster PresenceBroadcaster
}

func NewPresenceService(broadcaster PresenceBroadcaster) *PresenceService {
	return &PresenceService{broadcaster: broadcaster}
}

func (s *PresenceService) IsOnline(userID string) bool {
	if s == nil || s.broadcaster == nil {
		return false
	}
	return s.broadcaster.IsOnline(userID)
}

func (s *PresenceService) Send(userID string, payload []byte) bool {
	if s == nil || s.broadcaster == nil {
		return false
	}
	return s.broadcaster.Send(userID, payload)
}

func (s *PresenceService) Deliver(userID string, payload []byte) bool {
	return s.Send(userID, payload)
}

type MessageDeliveryService struct {
	presence PresenceBroadcaster
	store    MessageStore
	accounts AccountFinder
	push     WakeupPusher
	logger   *log.Logger
}

func NewMessageDeliveryService(presence PresenceBroadcaster, store MessageStore, accounts AccountFinder, push WakeupPusher, logger *log.Logger) *MessageDeliveryService {
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

func (s *MessageDeliveryService) Deliver(recipientID string, payload []byte) error {
	if recipientID == "" {
		return errors.New("recipient id is required")
	}
	return s.DeliverTargets([]string{recipientID}, payload)
}

func (s *MessageDeliveryService) DeliverTargets(recipientIDs []string, payload []byte) error {
	if s == nil {
		return errors.New("message delivery service is not configured")
	}
	for _, recipientID := range recipientIDs {
		if recipientID == "" {
			continue
		}
		if s.presence != nil && s.presence.IsOnline(recipientID) && s.presence.Send(recipientID, payload) {
			continue
		}
		if err := s.persistAndNotify(recipientID, payload); err != nil {
			return err
		}
	}
	return nil
}

func (s *MessageDeliveryService) persistAndNotify(recipientID string, payload []byte) error {
	if s.store == nil {
		return errors.New("message store is not configured")
	}

	uid, err := uuid.Parse(recipientID)
	if err != nil {
		return err
	}

	pending := &entities.PendingMessage{
		DestinationID: uid,
		Timestamp:     time.Now().UnixMilli(),
	}
	pending.SetPayload(payload)

	if err := s.store.Save(pending); err != nil {
		return err
	}

	if s.accounts == nil || s.push == nil {
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
		Payload:      string(payload),
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
		s.logger.Printf("event delivery: failed to send wakeup push target=%s: %v", uid, err)
	}
	return nil
}

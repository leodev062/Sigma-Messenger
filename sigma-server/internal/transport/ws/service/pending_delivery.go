package service

import (
	"log"

	"strconv"

	"sigma-server/internal/transport/ws/ports"
	"sigma-server/internal/transport/ws/protocol"
	"sigma-server/internal/transport/ws/session"

	"github.com/google/uuid"
)

// PendingDelivery replays queued messages and events when a client connects.
type PendingDelivery struct {
	messages  ports.PendingMessageStore
	envelopes ports.EnvelopeStore
	events    ports.PendingEventStore
	logger    *log.Logger
}

func NewPendingDelivery(messages ports.PendingMessageStore, envelopes ports.EnvelopeStore, events ports.PendingEventStore, logger *log.Logger) *PendingDelivery {
	if logger == nil {
		logger = log.Default()
	}
	return &PendingDelivery{messages: messages, envelopes: envelopes, events: events, logger: logger}
}

func (d *PendingDelivery) DeliverAll(userID string, conn *session.Connection) {
	if d == nil || conn == nil {
		return
	}
	d.deliverEnvelopes(userID, conn)
	d.deliverMessages(userID, conn)
	d.deliverEvents(userID, conn)
}

func (d *PendingDelivery) deliverEnvelopes(userID string, conn *session.Connection) {
	if d.envelopes == nil {
		return
	}
	accountID, err := uuid.Parse(userID)
	if err != nil {
		return
	}
	envelopes, err := d.envelopes.FindPendingByRecipient(accountID)
	if err != nil {
		d.logger.Printf("ws pending delivery envelopes user=%s: %v", userID, err)
		return
	}
	if len(envelopes) > 0 {
		d.logger.Printf("ws pending delivery: sending %d relay envelopes to user=%s", len(envelopes), userID)
	}
	for _, env := range envelopes {
		payload, err := protocol.WrapEnvelope(env.Payload, env.EnvelopeID)
		if err != nil {
			continue
		}
		if !conn.Enqueue(payload) {
			return
		}
	}
}

func (d *PendingDelivery) deliverMessages(userID string, conn *session.Connection) {
	if d.messages == nil {
		return
	}
	accountID, err := uuid.Parse(userID)
	if err != nil {
		return
	}
	messages, err := d.messages.FindPendingByAccountID(accountID)
	if err != nil {
		d.logger.Printf("ws pending delivery messages user=%s: %v", userID, err)
		return
	}
	if len(messages) > 0 {
		d.logger.Printf("ws pending delivery: sending %d messages to user=%s", len(messages), userID)
	}
	for _, message := range messages {
		envelope, err := message.Payload()
		if err != nil {
			continue
		}
		payload, err := protocol.WrapEnvelope(envelope, strconv.Itoa(message.ID))
		if err != nil {
			continue
		}
		if !conn.Enqueue(payload) {
			return
		}
	}
}

func (d *PendingDelivery) deliverEvents(userID string, conn *session.Connection) {
	if d.events == nil {
		return
	}
	accountID, err := uuid.Parse(userID)
	if err != nil {
		return
	}
	events, err := d.events.FindPendingByAccountID(accountID)
	if err != nil {
		d.logger.Printf("ws pending delivery events user=%s: %v", userID, err)
		return
	}
	if len(events) > 0 {
		d.logger.Printf("ws pending delivery: sending %d events to user=%s", len(events), userID)
	}
	for _, event := range events {
		if !conn.Enqueue(event.Payload) {
			return
		}
		_ = d.events.Delete(event.ID)
	}
}

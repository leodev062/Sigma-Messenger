package services

import (
	"context"
	"errors"
	"log"

	bizmessage "sigma-server/internal/business/message"

	"github.com/google/uuid"
)

type RealtimeMessenger interface {
	Send(userID string, payload []byte) bool
}

type OfflineMessenger interface {
	Deliver(recipientID string, payload []byte, notify bool) error
}

type BotMessageHandler interface {
	Handle(ctx context.Context, senderID uuid.UUID, botID uuid.UUID, payload []byte) error
}

type MessageDispatchService struct {
	router     *bizmessage.Router
	realtime   RealtimeMessenger
	offline    OfflineMessenger
	botHandler BotMessageHandler
	logger     *log.Logger
}

func NewMessageDispatchService(
	router *bizmessage.Router,
	realtime RealtimeMessenger,
	offline OfflineMessenger,
	botHandler BotMessageHandler,
	logger *log.Logger,
) *MessageDispatchService {
	if logger == nil {
		logger = log.Default()
	}
	return &MessageDispatchService{
		router:     router,
		realtime:   realtime,
		offline:    offline,
		botHandler: botHandler,
		logger:     logger,
	}
}

func (s *MessageDispatchService) Dispatch(senderID, destinationID string, payload []byte) error {
	return s.DispatchContext(context.Background(), senderID, destinationID, payload)
}

func (s *MessageDispatchService) DispatchContext(ctx context.Context, senderID, destinationID string, payload []byte) error {
	if s == nil || s.router == nil {
		return errors.New("message dispatch service is not configured")
	}

	senderUUID, err := uuid.Parse(senderID)
	if err != nil {
		s.logger.Printf("dispatch error: invalid sender uuid=%s: %v", senderID, err)
		return err
	}
	destUUID, err := uuid.Parse(destinationID)
	if err != nil {
		s.logger.Printf("dispatch error: invalid destination uuid=%s: %v", destinationID, err)
		return err
	}

	plan, err := s.router.Resolve(ctx, senderUUID, destUUID)
	if err != nil {
		s.logger.Printf("dispatch error: routing failed sender=%s dest=%s: %v", senderID, destinationID, err)
		return err
	}

	if plan.HandleAsBot {
		if s.botHandler == nil {
			return errors.New("bot handler is not configured")
		}
		s.logger.Printf("dispatch: routing to bot sender=%s bot_id=%s", senderID, destinationID)
		return s.botHandler.Handle(ctx, senderUUID, destUUID, payload)
	}

	// Contar quantos targets receberão mensagem
	deliveredCount := 0

	for _, target := range plan.Targets {
		targetID := target.UserID.String()
		if s.realtime != nil {
			isOnline := s.realtime.Send(targetID, payload)
			if isOnline {
				s.logger.Printf("dispatch: message delivered online sender=%s target=%s", senderID, targetID)
				deliveredCount++
				continue
			}
		}
		if s.offline == nil {
			s.logger.Printf("dispatch: offline handler not configured for target=%s", targetID)
			continue
		}
		if err := s.offline.Deliver(targetID, payload, !target.SkipPush); err != nil {
			s.logger.Printf("dispatch error: offline delivery failed target=%s: %v", targetID, err)
			return err
		}

		s.logger.Printf("dispatch: message queued offline sender=%s target=%s", senderID, targetID)
		deliveredCount++
	}

	if deliveredCount == 0 {
		s.logger.Printf("dispatch warning: message not delivered to any target sender=%s destination=%s", senderID, destinationID)
		return errors.New("message not delivered to any target")
	}

	return nil
}

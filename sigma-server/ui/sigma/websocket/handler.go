package websocket

import (
	"fmt"
	"log"
	"net/http"
	"strings"

	"sigma-server/ui/sigma/auth"
	"sigma-server/ui/sigma/services"
	"sigma-server/ui/sigma/storage"

	"github.com/google/uuid"
	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
	CheckOrigin: func(r *http.Request) bool {
		return true
	},
}

type WebsocketHandler struct {
	Manager      *WebsocketConnectionManager
	MessageRepo  *storage.MessageManager
	EventRepo    *storage.PendingEventManager
	jwtGenerator *auth.JwtGenerator
	Router       *WebsocketRouter
}

func NewWebsocketHandler(manager *WebsocketConnectionManager, messageRepo *storage.MessageManager, eventRepo *storage.PendingEventManager, jwtGenerator *auth.JwtGenerator, accountService *services.AccountService) *WebsocketHandler {
	return &WebsocketHandler{
		Manager:      manager,
		MessageRepo:  messageRepo,
		EventRepo:    eventRepo,
		jwtGenerator: jwtGenerator,
		Router:       NewWebsocketRouter(accountService, messageRepo),
	}
}

func (h *WebsocketHandler) Handle(c echo.Context) error {
	userID, err := h.resolveUserID(c)
	if err != nil {
		log.Printf("WebsocketHandler rejected connection: %v", err)
		return c.String(http.StatusUnauthorized, err.Error())
	}

	conn, err := upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		log.Printf("WebsocketHandler upgrade failed for user=%s: %v", userID, err)
		return err
	}

	wsConnection := NewWebsocketConnection(h.Manager, conn, userID, h.Router)
	h.Manager.RegisterConnection(wsConnection)
	h.deliverPendingMessages(userID, wsConnection)
	h.deliverPendingEvents(userID, wsConnection)
	wsConnection.Start()

	return nil
}

func (h *WebsocketHandler) resolveUserID(c echo.Context) (string, error) {
	if h.jwtGenerator != nil {
		if token := extractBearerToken(c.Request().Header.Get("Authorization")); token != "" {
			userID, err := h.jwtGenerator.ValidateToken(token)
			if err != nil {
				return "", fmt.Errorf("invalid authorization token")
			}
			return userID, nil
		}

		if token := c.QueryParam("token"); token != "" {
			userID, err := h.jwtGenerator.ValidateToken(token)
			if err != nil {
				return "", fmt.Errorf("invalid authorization token")
			}
			return userID, nil
		}
	}

	userIDStr := c.QueryParam("userId")
	if userIDStr == "" {
		return "", fmt.Errorf("missing userId")
	}

	if _, err := uuid.Parse(userIDStr); err != nil {
		return "", fmt.Errorf("invalid userId format")
	}

	return userIDStr, nil
}

func extractBearerToken(authorization string) string {
	if authorization == "" {
		return ""
	}

	parts := strings.SplitN(authorization, " ", 2)
	if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
		return ""
	}

	return parts[1]
}

func (h *WebsocketHandler) deliverPendingMessages(userID string, connection *WebsocketConnection) {
	accountID, err := uuid.Parse(userID)
	if err != nil {
		log.Printf("WebsocketHandler ignored pending messages for non-uuid user=%s: %v", userID, err)
		return
	}

	messages, err := h.MessageRepo.FindPendingByAccountID(accountID)
	if err != nil {
		log.Printf("WebsocketHandler error reading pending messages for user=%s: %v", userID, err)
		return
	}

	for _, message := range messages {
		payload, err := message.Payload()
		if err != nil {
			log.Printf("WebsocketHandler error decoding pending message id=%d user=%s: %v", message.ID, userID, err)
			continue
		}

		connection.Send <- payload
		if err := h.MessageRepo.Delete(message.ID); err != nil {
			log.Printf("WebsocketHandler error deleting delivered message id=%d user=%s: %v", message.ID, userID, err)
		}
	}
}

func (h *WebsocketHandler) deliverPendingEvents(userID string, connection *WebsocketConnection) {
	if h.EventRepo == nil {
		return
	}

	accountID, err := uuid.Parse(userID)
	if err != nil {
		log.Printf("WebsocketHandler ignored pending events for non-uuid user=%s: %v", userID, err)
		return
	}

	events, err := h.EventRepo.FindPendingByAccountID(accountID)
	if err != nil {
		log.Printf("WebsocketHandler error reading pending events for user=%s: %v", userID, err)
		return
	}

	for _, event := range events {
		connection.Send <- []byte(event.Payload)
		if err := h.EventRepo.Delete(event.ID); err != nil {
			log.Printf("WebsocketHandler error deleting delivered event id=%d user=%s: %v", event.ID, userID, err)
		}
	}
}

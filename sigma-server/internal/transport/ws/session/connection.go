package session

import (
	"log"
	"strings"
	"sync"
	"time"

	"github.com/gorilla/websocket"
	"google.golang.org/protobuf/proto"

	"sigma-server/internal/transport/ws/middleware"
	"sigma-server/internal/transport/ws/ports"
	"sigma-server/internal/transport/ws/protocol"
	"sigma-server/internal/transport/ws/router"
	sigmapb "sigma-server/proto"
)

var _ ports.OutboundSession = (*Connection)(nil)

const (
	writeWait      = 10 * time.Second
	pongWait       = 60 * time.Second
	pingPeriod     = (pongWait * 9) / 10
	maxMessageSize = 512 * 1024
)

// Connection is an active websocket session.
type Connection struct {
	registry            Registry
	dispatcher          OutboundDispatcher
	router              *router.Router
	Conn                Conn
	Send                chan []byte
	Client              *Client
	closeOnce           chan struct{}
	teardownOnce        sync.Once
	rateLimiter         *middleware.RateLimiter
	presenceCoordinator *middleware.PresenceCoordinator
	logger              *log.Logger
}

// Conn abstracts gorilla websocket for tests.
type Conn interface {
	RemoteAddr() string
	SetReadLimit(limit int64)
	SetReadDeadline(t time.Time) error
	SetWriteDeadline(t time.Time) error
	SetPongHandler(h func(appData string) error)
	ReadMessage() (messageType int, p []byte, err error)
	WriteMessage(messageType int, data []byte) error
	Close() error
}

func NewConnection(registry Registry, dispatcher OutboundDispatcher, conn Conn, userID string, messageRouter *router.Router, rateLimiter *middleware.RateLimiter, presenceCoordinator *middleware.PresenceCoordinator) *Connection {
	if rateLimiter == nil {
		rateLimiter = middleware.NewRateLimiter(100, log.Default())
	}
	if presenceCoordinator == nil {
		presenceCoordinator = middleware.NewPresenceCoordinator(log.Default())
	}
	logger := log.Default()
	return &Connection{
		registry:            registry,
		dispatcher:          dispatcher,
		router:              messageRouter,
		Conn:                conn,
		Send:                make(chan []byte, 256),
		rateLimiter:         rateLimiter,
		presenceCoordinator: presenceCoordinator,
		logger:              logger,
		Client: &Client{
			UserID:      userID,
			RemoteAddr:  conn.RemoteAddr(),
			ConnectedAt: time.Now(),
			LastSeen:    time.Now(),
		},
		closeOnce: make(chan struct{}),
	}
}

func (c *Connection) UserID() string {
	if c == nil || c.Client == nil {
		return ""
	}
	return c.Client.UserID
}

func (c *Connection) Start() {
	if c == nil || c.Conn == nil {
		return
	}

	// Gerar deviceID a partir do RemoteAddr
	var deviceID uint32 = 1
	if c.Conn != nil {
		addr := c.Conn.RemoteAddr()
		for _, b := range []byte(addr) {
			deviceID = deviceID*31 + uint32(b)
		}
	}

	// Marcar como online no presenceCoordinator
	if c.presenceCoordinator != nil {
		c.presenceCoordinator.MarkOnline(c.Client.UserID, deviceID)
		c.logger.Printf("presence: user online user_id=%s device_id=%d", c.Client.UserID, deviceID)
	}

	c.Conn.SetReadLimit(maxMessageSize)
	c.Conn.SetReadDeadline(time.Now().Add(pongWait))
	c.Conn.SetPongHandler(func(appData string) error {
		c.Conn.SetReadDeadline(time.Now().Add(pongWait))
		c.Client.LastSeen = time.Now()
		if c.registry != nil {
			c.registry.RefreshPresence(c.Client.UserID)
		}
		if c.presenceCoordinator != nil {
			c.presenceCoordinator.MarkOnline(c.Client.UserID, deviceID)
		}
		return nil
	})

	go c.writePump()
	c.readPump()
}

func (c *Connection) closeSocket() {
	if c == nil {
		return
	}
	select {
	case <-c.closeOnce:
		return
	default:
		close(c.closeOnce)
		_ = c.Conn.Close()
	}
}

func (c *Connection) Teardown() {
	c.teardownOnce.Do(func() {
		if c.presenceCoordinator != nil {
			// Gerar deviceID a partir do RemoteAddr para logout consistente
			var deviceID uint32 = 1
			if c.Conn != nil {
				addr := c.Conn.RemoteAddr()
				for _, b := range []byte(addr) {
					deviceID = deviceID*31 + uint32(b)
				}
			}
			c.presenceCoordinator.MarkOffline(c.Client.UserID, deviceID)
			c.logger.Printf("presence: user offline user_id=%s device_id=%d", c.Client.UserID, deviceID)
		}
		c.closeSocket()
		if c.registry != nil {
			c.registry.Unregister(c)
		}
	})
}

func (c *Connection) Enqueue(payload []byte) bool {
	select {
	case <-c.closeOnce:
		return false
	case c.Send <- payload:
		return true
	default:
		log.Printf("ws session send buffer full user=%s", c.Client.UserID)
		c.Teardown()
		return false
	}
}

func (c *Connection) SendResponse(requestID string, status int, body []byte) {
	payload := &protocol.Message{
		Type: protocol.ResponseType,
		Response: &protocol.Response{
			Id:     requestID,
			Status: status,
			Body:   append([]byte(nil), body...),
		},
	}
	encoded, err := protocol.Encode(payload)
	if err != nil {
		log.Printf("ws session encode response failed user=%s: %v", c.Client.UserID, err)
		return
	}
	_ = c.Enqueue(encoded)
}

func (c *Connection) readPump() {
	defer c.Teardown()

	// Gerar deviceID a partir do RemoteAddr
	var deviceID uint32 = 1
	if c.Conn != nil {
		addr := c.Conn.RemoteAddr()
		for _, b := range []byte(addr) {
			deviceID = deviceID*31 + uint32(b)
		}
	}

	for {
		messageType, raw, err := c.Conn.ReadMessage()
		if err != nil {
			return
		}
		if messageType != websocket.BinaryMessage {
			continue
		}

		// Rate limiting check
		if c.rateLimiter != nil && !c.rateLimiter.Allow(c.Client.UserID) {
			c.logger.Printf("rate_limit: exceeded for user_id=%s", c.Client.UserID)
			c.SendResponse("", 429, []byte("rate limit exceeded"))
			continue
		}

		if c.registry != nil {
			c.registry.RefreshPresence(c.Client.UserID)
		}
		if c.presenceCoordinator != nil {
			c.presenceCoordinator.MarkOnline(c.Client.UserID, deviceID)
		}
		message, err := protocol.Decode(raw)
		if err != nil {
			log.Printf("ws session decode error user=%s: %v", c.Client.UserID, err)
			continue
		}
		c.handleMessage(message)
	}
}

func (c *Connection) writePump() {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		c.Teardown()
	}()

	for {
		select {
		case message, ok := <-c.Send:
			_ = c.Conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				_ = c.Conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}
			if err := c.Conn.WriteMessage(websocket.BinaryMessage, message); err != nil {
				return
			}
		case <-ticker.C:
			if c.registry != nil {
				c.registry.RefreshPresence(c.Client.UserID)
			}
			_ = c.Conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.Conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

func (c *Connection) handleMessage(message *protocol.Message) {
	if message == nil {
		return
	}

	if message.Type == protocol.MessageKind && message.Request == nil {
		if c.registry != nil {
			c.registry.RefreshPresence(c.Client.UserID)
		}
		c.SendResponse("", 200, nil)
		return
	}

	if (message.Type == protocol.RequestType || message.Type == protocol.MessageKind) && message.Request != nil {
		if recipientID, ok := extractDestination(message.Request.Path); ok {
			if recipientID == "" {
				c.SendResponse(message.Request.Id, 400, []byte("invalid destination"))
				return
			}

			// Parse envelope and fill source field with sender's user ID
			var envelope sigmapb.Envelope
			if err := proto.Unmarshal(message.Request.Body, &envelope); err != nil {
				c.logger.Printf("envelope unmarshal error: %v", err)
				c.SendResponse(message.Request.Id, 400, []byte("invalid envelope"))
				return
			}

			// Set source to current user ID if not already set
			if envelope.From == "" {
				envelope.From = c.Client.UserID
			}

			destType := envelope.DestinationType
			destTypeStr := "USER"
			switch destType {
			case sigmapb.EntityType_ENTITY_TYPE_BOT:
				destTypeStr = "BOT"
			case sigmapb.EntityType_ENTITY_TYPE_GROUP:
				destTypeStr = "GROUP"
			case sigmapb.EntityType_ENTITY_TYPE_CHANNEL:
				destTypeStr = "CHANNEL"
			}

			// Re-marshal the envelope with source filled
			enrichedPayload, err := proto.Marshal(&envelope)
			if err != nil {
				c.logger.Printf("envelope marshal error: %v", err)
				c.SendResponse(message.Request.Id, 500, []byte("marshal error"))
				return
			}

			if c.dispatcher != nil {
				if err := c.dispatcher.Dispatch(c.Client.UserID, recipientID, destTypeStr, enrichedPayload); err != nil {
					c.SendResponse(message.Request.Id, 400, []byte(err.Error()))
					return
				}
				c.SendResponse(message.Request.Id, 202, nil)
				return
			}
			if c.registry != nil {
				c.registry.Dispatch(recipientID, destTypeStr, enrichedPayload)
				c.SendResponse(message.Request.Id, 202, nil)
			}
			return
		}

		if c.router != nil {
			body, status, err := c.router.Handle(c, message.Request)
			if err != nil && status == 0 {
				status = 500
				body = router.MarshalError(500, err.Error())
			}
			if body == nil {
				body = []byte{}
			}
			c.SendResponse(message.Request.Id, status, body)
			return
		}
	}
}

func extractDestination(rawPath string) (string, bool) {
	path := strings.Trim(rawPath, "/")
	segments := strings.Split(path, "/")
	if len(segments) == 3 && strings.EqualFold(segments[0], "v2") && strings.EqualFold(segments[1], "messages") {
		// Do not treat "receipt" as a user destination
		if strings.EqualFold(segments[2], "receipt") {
			return "", false
		}
		return segments[2], true
	}
	return "", false
}

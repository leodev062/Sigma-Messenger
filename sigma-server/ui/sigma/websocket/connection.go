package websocket

import (
	"log"
	"strings"
	"time"

	"github.com/gorilla/websocket"
)

const (
	writeWait      = 10 * time.Second
	pongWait       = 60 * time.Second
	pingPeriod     = (pongWait * 9) / 10
	maxMessageSize = 512 * 1024
)

type AuthenticatedClient struct {
	UserID         string
	SessionContext *WebsocketSessionContext
}

type WebsocketSessionContext struct {
	UserID      string
	RemoteAddr  string
	ConnectedAt time.Time
	LastSeen    time.Time
}

type WebsocketConnection struct {
	manager   *WebsocketConnectionManager
	router    *WebsocketRouter
	Conn      *websocket.Conn
	Send      chan []byte
	Client    *AuthenticatedClient
	closeOnce chan struct{}
}

func NewWebsocketConnection(manager *WebsocketConnectionManager, conn *websocket.Conn, userID string, router *WebsocketRouter) *WebsocketConnection {
	return &WebsocketConnection{
		manager: manager,
		router:  router,
		Conn:    conn,
		Send:    make(chan []byte, 256),
		Client: &AuthenticatedClient{
			UserID: userID,
			SessionContext: &WebsocketSessionContext{
				UserID:      userID,
				RemoteAddr:  conn.RemoteAddr().String(),
				ConnectedAt: time.Now(),
				LastSeen:    time.Now(),
			},
		},
		closeOnce: make(chan struct{}),
	}
}

func (c *WebsocketConnection) Start() {
	if c == nil || c.Conn == nil {
		return
	}

	c.Conn.SetReadLimit(maxMessageSize)
	c.Conn.SetReadDeadline(time.Now().Add(pongWait))
	c.Conn.SetPongHandler(func(appData string) error {
		c.Conn.SetReadDeadline(time.Now().Add(pongWait))
		c.Client.SessionContext.LastSeen = time.Now()
		if c.manager != nil {
			c.manager.RefreshPresence(c.Client.UserID)
		}
		return nil
	})

	go c.writePump()
	go c.readPump()
}

func (c *WebsocketConnection) Close() {
	if c == nil || c.manager == nil {
		return
	}

	c.manager.UnregisterConnection(c)
	c.closeConnection()
}

func (c *WebsocketConnection) closeConnection() {
	if c == nil {
		return
	}

	select {
	case <-c.closeOnce:
		return
	default:
		close(c.closeOnce)
		if c.Conn != nil {
			c.Conn.Close()
		}
	}
}

func (c *WebsocketConnection) readPump() {
	defer func() {
		if c.manager != nil {
			c.manager.UnregisterConnection(c)
		}
		c.closeConnection()
	}()

	for {
		messageType, raw, err := c.Conn.ReadMessage()
		if err != nil {
			if websocket.IsUnexpectedCloseError(err, websocket.CloseGoingAway, websocket.CloseAbnormalClosure) {
				log.Printf("WebsocketConnection read error user=%s: %v", c.Client.UserID, err)
			}
			return
		}

		if messageType != websocket.BinaryMessage {
			log.Printf("WebsocketConnection ignoring non-binary message user=%s", c.Client.UserID)
			continue
		}

		if c.manager != nil {
			c.manager.RefreshPresence(c.Client.UserID)
		}

		message, err := DecodeWebsocketMessage(raw)
		if err != nil {
			log.Printf("WebsocketConnection decode error user=%s: %v", c.Client.UserID, err)
			continue
		}

		c.handleMessage(raw, message)
	}
}

func (c *WebsocketConnection) writePump() {
	ticker := time.NewTicker(pingPeriod)
	defer func() {
		ticker.Stop()
		if c.manager != nil {
			c.manager.UnregisterConnection(c)
		}
		c.closeConnection()
	}()

	for {
		select {
		case message, ok := <-c.Send:
			c.Conn.SetWriteDeadline(time.Now().Add(writeWait))
			if !ok {
				c.Conn.WriteMessage(websocket.CloseMessage, []byte{})
				return
			}

			if err := c.Conn.WriteMessage(websocket.BinaryMessage, message); err != nil {
				return
			}

		case <-ticker.C:
			if c.manager != nil {
				c.manager.RefreshPresence(c.Client.UserID)
			}
			c.Conn.SetWriteDeadline(time.Now().Add(writeWait))
			if err := c.Conn.WriteMessage(websocket.PingMessage, nil); err != nil {
				return
			}
		}
	}
}

func (c *WebsocketConnection) send(payload []byte) {
	select {
	case c.Send <- payload:
	default:
		log.Printf("WebsocketConnection send buffer full user=%s", c.Client.UserID)
		c.Close()
	}
}

func (c *WebsocketConnection) sendResponse(requestID string, status int, body []byte) {
	if c == nil {
		return
	}

	payload := &WebsocketMessage{
		Type: ResponseType,
		Response: &WebsocketResponseMessage{
			Id:      requestID,
			Status:  status,
			Message: "",
			Body:    append([]byte(nil), body...),
		},
	}

	encoded, err := EncodeWebsocketMessage(payload)
	if err != nil {
		log.Printf("WebsocketConnection failed to encode response user=%s: %v", c.Client.UserID, err)
		return
	}

	c.send(encoded)
}

func extractDestinationFromPath(rawPath string) (string, bool) {
	parsed := parseWebsocketPath(rawPath)
	segments := strings.Split(strings.Trim(parsed, "/"), "/")
	if len(segments) == 3 && strings.EqualFold(segments[0], "v2") && strings.EqualFold(segments[1], "messages") {
		return segments[2], true
	}
	return "", false
}

func (c *WebsocketConnection) handleMessage(raw []byte, message *WebsocketMessage) {
	if message == nil {
		return
	}

	if (message.Type == RequestType || message.Type == MessageType) && message.Request != nil {
		recipientID, ok := extractDestinationFromPath(message.Request.Path)
		if !ok {
			c.sendResponse(message.Request.Id, 404, []byte("unsupported websocket route"))
			return
		}
		if recipientID == "" {
			c.sendResponse(message.Request.Id, 400, []byte("invalid destination"))
			return
		}

		if c.manager != nil {
			c.manager.Dispatch(recipientID, raw)
			c.sendResponse(message.Request.Id, 202, nil)
			return
		}
	}

	if message.Type == ResponseType && message.Response != nil {
		log.Printf("WebsocketConnection ignored response message from user=%s", c.Client.UserID)
		return
	}

	log.Printf("WebsocketConnection ignored unsupported message user=%s type=%s", c.Client.UserID, message.Type)
}

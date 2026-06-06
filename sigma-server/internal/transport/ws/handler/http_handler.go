package handler

import (
	"log"
	"net/http"
	"time"

	"sigma-server/internal/repository/storage"
	"sigma-server/internal/transport/ws/hub"
	"sigma-server/internal/transport/ws/middleware"
	"sigma-server/internal/transport/ws/router"
	"sigma-server/internal/transport/ws/security"
	"sigma-server/internal/transport/ws/service"
	"sigma-server/internal/transport/ws/session"

	"github.com/google/uuid"
	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

// HTTPHandler upgrades HTTP connections to websocket sessions.
type HTTPHandler struct {
	Hub                 *hub.Hub
	PendingDelivery     *service.PendingDelivery
	Auth                *service.ConnectionAuth
	Router              *router.Router
	Dispatcher          session.OutboundDispatcher
	Devices             *storage.DeviceSessionManager
	RateLimiter         *middleware.RateLimiter
	PresenceCoordinator *middleware.PresenceCoordinator
	upgrader            websocket.Upgrader
}

func NewHTTPHandler(
	h *hub.Hub,
	pending *service.PendingDelivery,
	auth *service.ConnectionAuth,
	messageRouter *router.Router,
	dispatcher session.OutboundDispatcher,
	originChecker *security.OriginChecker,
	devices *storage.DeviceSessionManager,
	rateLimiter *middleware.RateLimiter,
	presenceCoordinator *middleware.PresenceCoordinator,
) *HTTPHandler {
	if rateLimiter == nil {
		rateLimiter = middleware.NewRateLimiter(100, log.Default())
	}
	if presenceCoordinator == nil {
		presenceCoordinator = middleware.NewPresenceCoordinator(log.Default())
	}
	return &HTTPHandler{
		Hub:                 h,
		PendingDelivery:     pending,
		Auth:                auth,
		Router:              messageRouter,
		Dispatcher:          dispatcher,
		Devices:             devices,
		RateLimiter:         rateLimiter,
		PresenceCoordinator: presenceCoordinator,
		upgrader: websocket.Upgrader{
			ReadBufferSize:  4096,
			WriteBufferSize: 4096,
			CheckOrigin:     originChecker.Allow,
		},
	}
}

func (h *HTTPHandler) Handle(c echo.Context) error {
	userID, err := h.Auth.ResolveUserID(c)
	if err != nil {
		log.Printf("ws upgrade rejected: %v", err)
		return c.String(http.StatusUnauthorized, err.Error())
	}
	if h.Hub != nil && !h.Hub.CanAccept(userID) {
		return c.String(http.StatusTooManyRequests, "too many websocket connections for this account")
	}

	rawConn, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return err
	}

	// Aggressive: Close any existing connections for this user before starting new one
	// This prevents "ghost" connections from receiving the pending messages.
	if h.Hub != nil {
		h.Hub.CloseUser(userID)
	}

	conn := session.NewConnection(h.Hub, h.Dispatcher, wrapGorilla(rawConn), userID, h.Router, h.RateLimiter, h.PresenceCoordinator)

	// Professional Algorithm: Sync session metadata on WS connection
	deviceID := c.QueryParam("deviceId")
	if deviceID != "" && h.Devices != nil {
		uid, _ := uuid.Parse(userID)
		go func() {
			_ = h.Devices.Touch(uid, deviceID, c.RealIP())
		}()
	}

	h.Hub.Register(conn)

	// Wait a small bit for registration to propagate through the hub channels
	// and ensure DeliverAll sends to the correct connection
	log.Printf("ws: registered user=%s. Starting delivery...", userID)

	go func() {
		// Small delay to ensure the hub loop has processed the registration
		time.Sleep(100 * time.Millisecond)
		h.PendingDelivery.DeliverAll(userID, conn)
	}()

	conn.Start()
	return nil
}

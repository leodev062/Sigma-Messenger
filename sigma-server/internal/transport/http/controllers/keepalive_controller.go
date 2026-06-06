package controllers

import (
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/transport/ws/hub"

	"github.com/labstack/echo/v4"
)

type KeepAliveController struct {
	hub *hub.Hub
}

func NewKeepAliveController(h *hub.Hub) *KeepAliveController {
	return &KeepAliveController{hub: h}
}

func (c *KeepAliveController) Get(e echo.Context) error {
	if c == nil || c.hub == nil {
		return httpx.InternalError(e, "keepalive hub is not configured")
	}

	userID, ok := middleware.UserIDFromContext(e)
	if !ok || userID == "" {
		return httpx.Unauthorized(e, "missing authenticated user")
	}

	online := c.hub.IsLocallyPresent(userID)
	if online {
		c.hub.RefreshPresence(userID)
	}

	return httpx.OK(e, http.StatusOK, map[string]any{
		"online": online,
	})
}

func (c *KeepAliveController) Provisioning(e echo.Context) error {
	return httpx.OK(e, http.StatusOK, map[string]any{
		"ok": true,
	})
}

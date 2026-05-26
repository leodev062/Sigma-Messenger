package controllers

import (
	"net/http"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/http/middleware"
	"sigma-server/ui/sigma/websocket"

	"github.com/labstack/echo/v4"
)

type KeepAliveController struct {
	manager *websocket.WebsocketConnectionManager
}

func NewKeepAliveController(manager *websocket.WebsocketConnectionManager) *KeepAliveController {
	return &KeepAliveController{manager: manager}
}

func (c *KeepAliveController) Get(e echo.Context) error {
	if c == nil || c.manager == nil {
		return api.InternalError(e, "keepalive manager is not configured")
	}

	userID, ok := middleware.UserIDFromContext(e)
	if !ok || userID == "" {
		return api.Unauthorized(e, "missing authenticated user")
	}

	online := c.manager.IsLocallyPresent(userID)
	if online {
		c.manager.RefreshPresence(userID)
	}

	return api.OK(e, http.StatusOK, map[string]any{
		"online": online,
	})
}

func (c *KeepAliveController) Provisioning(e echo.Context) error {
	return api.OK(e, http.StatusOK, map[string]any{
		"ok": true,
	})
}

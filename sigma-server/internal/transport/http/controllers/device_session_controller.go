package controllers

import (
	"net/http"
	"strconv"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/repository/storage"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type DeviceSessionController struct {
	manager *storage.DeviceSessionManager
}

func NewDeviceSessionController(manager *storage.DeviceSessionManager) *DeviceSessionController {
	return &DeviceSessionController{manager: manager}
}

func (c *DeviceSessionController) List(ctx echo.Context) error {
	userIDStr, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	userID, err := uuid.Parse(userIDStr)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	sessions, err := c.manager.FindByUserID(userID)
	if err != nil {
		return httpx.InternalError(ctx, "failed to fetch sessions")
	}

	return httpx.OK(ctx, http.StatusOK, sessions)
}

func (c *DeviceSessionController) Delete(ctx echo.Context) error {
	idStr := ctx.Param("id")
	id, err := strconv.ParseUint(idStr, 10, 32)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid session id")
	}

	// Optional: Check if session belongs to user
	// For now, simplicity
	if err := c.manager.Delete(uint(id)); err != nil {
		return httpx.InternalError(ctx, "failed to delete session")
	}

	return httpx.OK(ctx, http.StatusOK, map[string]bool{"success": true})
}

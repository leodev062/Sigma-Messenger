package controllers

import (
	"io"
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/service"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type KeysController struct {
	service *services.AccountService
}

func NewKeysController(service *services.AccountService) *KeysController {
	return &KeysController{service: service}
}

func (h *KeysController) PutKeys(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return httpx.Unauthorized(c, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(c, "invalid user id")
	}

	body, err := io.ReadAll(c.Request().Body)
	if err != nil {
		return httpx.BadRequest(c, "failed to read request body")
	}
	if len(body) == 0 {
		return httpx.BadRequest(c, "empty protobuf body")
	}

	if err := h.service.SavePreKeyBundle(uid, body); err != nil {
		return httpx.InternalError(c, err.Error())
	}

	return c.NoContent(http.StatusNoContent)
}

func (h *KeysController) GetPreKeyCount(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return httpx.Unauthorized(c, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(c, "invalid user id")
	}

	count, err := h.service.GetPreKeyCount(uid)
	if err != nil {
		return httpx.InternalError(c, err.Error())
	}

	return c.JSON(http.StatusOK, map[string]interface{}{
		"count": count,
	})
}

func (h *KeysController) GetKeys(c echo.Context) error {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return httpx.BadRequest(c, "invalid id")
	}

	payload, err := h.service.GetPreKeyBundle(id)
	if err != nil {
		return httpx.NotFound(c, "account not found")
	}

	return c.Blob(http.StatusOK, "application/x-protobuf", payload)
}

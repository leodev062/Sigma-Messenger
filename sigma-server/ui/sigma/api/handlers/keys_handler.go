package handlers

import (
	"io"
	"net/http"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/http/middleware"
	"sigma-server/ui/sigma/services"
)

type KeysHandler struct {
	service *services.AccountService
}

func NewKeysHandler(service *services.AccountService) *KeysHandler {
	return &KeysHandler{service: service}
}

func (h *KeysHandler) PutKeys(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return api.Unauthorized(c, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(c, "invalid user id")
	}

	body, err := io.ReadAll(c.Request().Body)
	if err != nil {
		return api.BadRequest(c, "failed to read request body")
	}
	if len(body) == 0 {
		return api.BadRequest(c, "empty protobuf body")
	}

	if err := h.service.SavePreKeyBundle(uid, body); err != nil {
		return api.InternalError(c, err.Error())
	}

	return c.NoContent(http.StatusNoContent)
}

func (h *KeysHandler) GetKeys(c echo.Context) error {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return api.BadRequest(c, "invalid id")
	}

	payload, err := h.service.GetPreKeyBundle(id)
	if err != nil {
		return api.NotFound(c, "account not found")
	}

	return c.Blob(http.StatusOK, "application/x-protobuf", payload)
}

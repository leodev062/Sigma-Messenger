package handlers

import (
	"context"
	"log"
	"net/http"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/events"
	"sigma-server/ui/sigma/http/middleware"
	"sigma-server/ui/sigma/services"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type AccountHandler struct {
	service     *services.AccountService
	eventRouter *events.Router
}

func NewAccountHandler(service *services.AccountService, eventRouter *events.Router) *AccountHandler {
	return &AccountHandler{service: service, eventRouter: eventRouter}
}

func (h *AccountHandler) Create(c echo.Context) error {
	var req dto.CreateAccountRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	account, err := h.service.CreateAccount(req)
	if err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusCreated, account)
}

func (h *AccountHandler) GetMe(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return api.Unauthorized(c, "unauthorized")
	}
	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(c, "invalid user id")
	}
	account, err := h.service.GetAccountByID(uid)
	if err != nil {
		return api.NotFound(c, "account not found")
	}
	return api.OK(c, http.StatusOK, account)
}

func (h *AccountHandler) Update(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return api.Unauthorized(c, "unauthorized")
	}
	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(c, "invalid user id")
	}
	var req dto.UpdateAccountRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	account, err := h.service.UpdateAccount(uid, req)
	if err != nil {
		if err.Error() == "account not found" {
			return api.NotFound(c, err.Error())
		}
		return api.InternalError(c, err.Error())
	}
	if h.eventRouter != nil {
		if err := h.eventRouter.PublishProfileChanged(context.Background(), account); err != nil {
			log.Printf("account handler: failed to publish profile changed event user=%s: %v", account.ID, err)
		}
	}
	return api.OK(c, http.StatusOK, account)
}

func (h *AccountHandler) Delete(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return api.Unauthorized(c, "unauthorized")
	}
	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(c, "invalid user id")
	}
	if err := h.service.DeleteAccount(uid); err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, map[string]bool{"deleted": true})
}

func (h *AccountHandler) GetByID(c echo.Context) error {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return api.BadRequest(c, "invalid id")
	}
	account, err := h.service.GetAccountByID(id)
	if err != nil {
		return api.NotFound(c, "account not found")
	}
	return api.OK(c, http.StatusOK, account)
}

func (h *AccountHandler) GetKeys(c echo.Context) error {
	id, err := uuid.Parse(c.Param("id"))
	if err != nil {
		return api.BadRequest(c, "invalid id")
	}
	keys, err := h.service.GetKeys(id)
	if err != nil {
		return api.NotFound(c, "account not found")
	}
	return api.OK(c, http.StatusOK, keys)
}

func (h *AccountHandler) CheckUsername(c echo.Context) error {
	username := c.Param("username")
	available := h.service.CheckUsername(username)
	return api.OK(c, http.StatusOK, map[string]bool{"available": available})
}

func (h *AccountHandler) SyncContacts(c echo.Context) error {
	var req dto.SyncContactsRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	contacts, err := h.service.SyncContacts(req.Phones)
	if err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, contacts)
}

func (h *AccountHandler) UpdateFCMToken(c echo.Context) error {
	userID, ok := middleware.UserIDFromContext(c)
	if !ok {
		return api.Unauthorized(c, "unauthorized")
	}
	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(c, "invalid user id")
	}
	var req dto.UpdateFCMTokenRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	if req.FCMToken == "" {
		return api.BadRequest(c, "fcm token is required")
	}
	if err := h.service.UpdateFCMToken(uid, req.FCMToken); err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, map[string]bool{"updated": true})
}

func (h *AccountHandler) SyncRecipients(c echo.Context) error {
	var req dto.SyncRecipientsRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	var ids []uuid.UUID
	for _, rawID := range req.IDs {
		uid, err := uuid.Parse(rawID)
		if err != nil {
			continue
		}
		ids = append(ids, uid)
	}
	recipients, err := h.service.SyncRecipients(ids)
	if err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, recipients)
}

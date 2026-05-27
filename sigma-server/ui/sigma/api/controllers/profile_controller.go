package controllers

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

type ProfileController struct {
	service     *services.ProfileService
	eventRouter *events.Router
}

func NewProfileController(service *services.ProfileService, eventRouter *events.Router) *ProfileController {
	return &ProfileController{service: service, eventRouter: eventRouter}
}

func (c *ProfileController) GetByID(ctx echo.Context) error {
	id, err := uuid.Parse(ctx.Param("id"))
	if err != nil {
		return api.BadRequest(ctx, "invalid id")
	}

	profile, err := c.service.GetByID(id)
	if err != nil {
		return api.NotFound(ctx, "account not found")
	}

	return api.OK(ctx, http.StatusOK, profile)
}

func (c *ProfileController) SyncRecipients(ctx echo.Context) error {
	var req dto.SyncRecipientsRequest
	if err := ctx.Bind(&req); err != nil {
		return api.BadRequest(ctx, "invalid request")
	}

	var ids []uuid.UUID
	for _, rawID := range req.IDs {
		uid, err := uuid.Parse(rawID)
		if err != nil {
			continue
		}
		ids = append(ids, uid)
	}

	recipients, err := c.service.SyncRecipients(ids)
	if err != nil {
		return api.InternalError(ctx, err.Error())
	}

	return api.OK(ctx, http.StatusOK, recipients)
}

func (c *ProfileController) Update(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return api.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return api.BadRequest(ctx, "invalid user id")
	}

	var req dto.UpdateAccountRequest
	if err := ctx.Bind(&req); err != nil {
		return api.BadRequest(ctx, "invalid request")
	}

	account, err := c.service.UpdateProfile(uid, req)
	if err != nil {
		if err.Error() == "account not found" {
			return api.NotFound(ctx, err.Error())
		}
		return api.InternalError(ctx, err.Error())
	}

	if c.eventRouter != nil {
		if err := c.eventRouter.PublishProfileChanged(context.Background(), account); err != nil {
			log.Printf("profile controller: failed to publish profile changed event user=%s: %v", account.ID, err)
		}
	}

	return api.OK(ctx, http.StatusOK, account)
}

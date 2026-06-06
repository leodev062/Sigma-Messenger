package controllers

import (
	"context"
	"log"
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/events"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/service"

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
		return httpx.BadRequest(ctx, "invalid id")
	}

	var requesterID *uuid.UUID
	if userID, ok := middleware.UserIDFromContext(ctx); ok {
		uid, err := uuid.Parse(userID)
		if err == nil {
			requesterID = &uid
		}
	}

	profile, err := c.service.GetByID(requesterID, id)
	if err != nil {
		return httpx.NotFound(ctx, "account not found")
	}

	return httpx.OK(ctx, http.StatusOK, profile)
}

func (c *ProfileController) SyncRecipients(ctx echo.Context) error {
	var req dto.SyncRecipientsRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	var ids []uuid.UUID
	for _, rawID := range req.IDs {
		uid, err := uuid.Parse(rawID)
		if err != nil {
			continue
		}
		ids = append(ids, uid)
	}

	var requesterID *uuid.UUID
	if userID, ok := middleware.UserIDFromContext(ctx); ok {
		uid, err := uuid.Parse(userID)
		if err == nil {
			requesterID = &uid
		}
	}

	recipients, err := c.service.SyncRecipients(requesterID, ids)
	if err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, recipients)
}

func (c *ProfileController) Update(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	var req dto.UpdateAccountRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	account, err := c.service.UpdateProfile(uid, req)
	if err != nil {
		if err.Error() == "account not found" {
			return httpx.NotFound(ctx, err.Error())
		}
		return httpx.InternalError(ctx, err.Error())
	}

	if c.eventRouter != nil {
		if err := c.eventRouter.PublishProfileChanged(context.Background(), account); err != nil {
			log.Printf("profile controller: failed to publish profile changed event user=%s: %v", account.ID, err)
		}
	}

	return httpx.OK(ctx, http.StatusOK, account)
}

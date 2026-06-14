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
	id := ctx.Param("id")
	if id == "" {
		return httpx.BadRequest(ctx, "invalid id")
	}

	requesterID, _ := middleware.UserIDFromContext(ctx)

	profile, err := c.service.GetByID(requesterID, id)
	if err != nil {
		return httpx.NotFound(ctx, "user not found")
	}

	return httpx.OK(ctx, http.StatusOK, profile)
}

func (c *ProfileController) SyncRecipients(ctx echo.Context) error {
	var req dto.SyncRecipientsRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	// For now, simple loop if service doesn't support bulk yet
	var results []entities.User
	requesterID, _ := middleware.UserIDFromContext(ctx)

	for _, id := range req.IDs {
		profile, err := c.service.GetByID(requesterID, id)
		if err == nil {
			results = append(results, *profile)
		}
	}

	return httpx.OK(ctx, http.StatusOK, results)
}

func (c *ProfileController) Update(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	var req dto.UpdateAccountRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	user, err := c.service.UpdateProfile(userID, req)
	if err != nil {
		if err.Error() == "user not found" {
			return httpx.NotFound(ctx, err.Error())
		}
		return httpx.InternalError(ctx, err.Error())
	}

	// Notify event router (needs updating if it uses Account)
	/*
	if c.eventRouter != nil {
		if err := c.eventRouter.PublishProfileChanged(context.Background(), user); err != nil {
			log.Printf("profile controller: failed to publish profile changed event user=%s: %v", user.ID, err)
		}
	}
	*/

	return httpx.OK(ctx, http.StatusOK, user)
}

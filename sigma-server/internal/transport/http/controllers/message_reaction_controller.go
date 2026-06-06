package controllers

import (
	"errors"
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/service"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type MessageReactionController struct {
	service *services.MessageReactionService
}

func NewMessageReactionController(service *services.MessageReactionService) *MessageReactionController {
	return &MessageReactionController{service: service}
}

func (c *MessageReactionController) Add(ctx echo.Context) error {
	messageID, err := uuid.Parse(ctx.Param("id"))
	if err != nil {
		return httpx.BadRequest(ctx, "invalid message id")
	}

	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	var req dto.MessageReactionRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	reaction, err := c.service.AddReaction(uid, messageID, req)
	if err != nil {
		if errors.Is(err, services.ErrInvalidReaction) {
			return httpx.BadRequest(ctx, err.Error())
		}
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusCreated, reaction)
}

func (c *MessageReactionController) Remove(ctx echo.Context) error {
	messageID, err := uuid.Parse(ctx.Param("id"))
	if err != nil {
		return httpx.BadRequest(ctx, "invalid message id")
	}

	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	if err := c.service.RemoveReaction(uid, messageID); err != nil {
		if errors.Is(err, services.ErrReactionNotFound) {
			return httpx.NotFound(ctx, err.Error())
		}
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, map[string]bool{"removed": true})
}

func (c *MessageReactionController) GetByMessage(ctx echo.Context) error {
	messageID, err := uuid.Parse(ctx.Param("id"))
	if err != nil {
		return httpx.BadRequest(ctx, "invalid message id")
	}

	reactions, err := c.service.GetReactions(messageID)
	if err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, reactions)
}

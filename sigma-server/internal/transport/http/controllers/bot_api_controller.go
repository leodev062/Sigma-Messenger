package controllers

import (
	"net/http"
	"strconv"

	"sigma-server/internal/dto"
	"sigma-server/internal/service"
	"sigma-server/internal/transport/http/middleware"

	"github.com/labstack/echo/v4"
)

type BotAPIController struct {
	api *services.BotAPIService
}

func NewBotAPIController(api *services.BotAPIService) *BotAPIController {
	return &BotAPIController{api: api}
}

func (c *BotAPIController) GetMe(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}
	return botOK(ctx, c.api.GetMe(bot))
}

func (c *BotAPIController) GetUpdates(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}

	offset, _ := strconv.ParseInt(ctx.QueryParam("offset"), 10, 64)
	limit, _ := strconv.Atoi(ctx.QueryParam("limit"))
	timeout, _ := strconv.Atoi(ctx.QueryParam("timeout"))

	updates, err := c.api.GetUpdates(ctx.Request().Context(), bot.ID, offset, limit, timeout)
	if err != nil {
		return botError(ctx, 500, err.Error())
	}
	return botOK(ctx, updates)
}

func (c *BotAPIController) SendMessage(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}

	var req dto.BotAPISendMessageRequest
	if err := ctx.Bind(&req); err != nil {
		return botError(ctx, 400, "invalid request body")
	}

	message, err := c.api.SendMessage(bot, req)
	if err != nil {
		return botError(ctx, 400, err.Error())
	}
	return botOK(ctx, message)
}

func (c *BotAPIController) SetWebhook(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}

	var req dto.BotAPISetWebhookRequest
	if err := ctx.Bind(&req); err != nil {
		return botError(ctx, 400, "invalid request body")
	}
	if err := c.api.SetWebhook(bot.ID, req); err != nil {
		return botError(ctx, 400, err.Error())
	}
	return botOK(ctx, true)
}

func (c *BotAPIController) DeleteWebhook(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}

	dropPending := ctx.QueryParam("drop_pending_updates") == "true"
	if err := c.api.DeleteWebhook(bot.ID, dropPending); err != nil {
		return botError(ctx, 500, err.Error())
	}
	return botOK(ctx, true)
}

func (c *BotAPIController) GetWebhookInfo(ctx echo.Context) error {
	bot, ok := middleware.BotFromContext(ctx)
	if !ok {
		return botUnauthorized(ctx)
	}

	info, err := c.api.GetWebhookInfo(bot.ID)
	if err != nil {
		return botError(ctx, 500, err.Error())
	}
	return botOK(ctx, info)
}

func botOK(ctx echo.Context, result interface{}) error {
	return ctx.JSON(http.StatusOK, map[string]interface{}{
		"ok":     true,
		"result": result,
	})
}

func botError(ctx echo.Context, code int, description string) error {
	status := http.StatusOK
	if code >= 500 {
		status = http.StatusInternalServerError
	}
	return ctx.JSON(status, map[string]interface{}{
		"ok":          false,
		"error_code":  code,
		"description": description,
	})
}

func botUnauthorized(ctx echo.Context) error {
	return botError(ctx, 401, "unauthorized")
}

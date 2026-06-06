package controllers

import (
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/transport/http/middleware"
	"sigma-server/internal/service"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

type AccountController struct {
	service *services.AccountService
}

func NewAccountController(service *services.AccountService) *AccountController {
	return &AccountController{service: service}
}

func (c *AccountController) Create(ctx echo.Context) error {
	var req dto.CreateAccountRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	account, err := c.service.CreateAccount(req)
	if err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusCreated, account)
}

func (c *AccountController) GetMe(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	account, err := c.service.GetAccountByID(uid)
	if err != nil {
		return httpx.NotFound(ctx, "account not found")
	}

	return httpx.OK(ctx, http.StatusOK, account)
}

func (c *AccountController) Delete(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	if err := c.service.DeleteAccount(uid); err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, map[string]bool{"deleted": true})
}

func (c *AccountController) GetKeys(ctx echo.Context) error {
	id, err := uuid.Parse(ctx.Param("id"))
	if err != nil {
		return httpx.BadRequest(ctx, "invalid id")
	}

	payload, err := c.service.GetKeys(id)
	if err != nil {
		return httpx.NotFound(ctx, "account not found")
	}

	return ctx.Blob(http.StatusOK, "application/x-protobuf", payload)
}

func (c *AccountController) UpdateFCMToken(ctx echo.Context) error {
	userID, ok := middleware.UserIDFromContext(ctx)
	if !ok {
		return httpx.Unauthorized(ctx, "unauthorized")
	}

	uid, err := uuid.Parse(userID)
	if err != nil {
		return httpx.BadRequest(ctx, "invalid user id")
	}

	var req dto.UpdateFCMTokenRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}
	if req.FCMToken == "" {
		return httpx.BadRequest(ctx, "fcm token is required")
	}

	if err := c.service.UpdateFCMToken(uid, req.FCMToken); err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, map[string]bool{"updated": true})
}

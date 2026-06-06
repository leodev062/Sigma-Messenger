package controllers

import (
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/service"

	"github.com/labstack/echo/v4"
)

type RegistrationController struct {
	registrationService *services.RegistrationService
}

func NewRegistrationController(registrationService *services.RegistrationService) *RegistrationController {
	return &RegistrationController{
		registrationService: registrationService,
	}
}

func (c *RegistrationController) CreateVerificationSession(ctx echo.Context) error {
	var req dto.CreateVerificationSessionRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	session, err := c.registrationService.CreateVerificationSession(&req)
	if err != nil {
		status := http.StatusInternalServerError
		switch err {
		case services.ErrInvalidPhoneNumber:
			status = http.StatusBadRequest
		case services.ErrRegistrationLockRequired:
			status = http.StatusForbidden
		case services.ErrAccountAlreadyExists:
			status = http.StatusConflict
		}
		return ctx.JSON(status, map[string]string{"error": err.Error()})
	}

	return httpx.OK(ctx, http.StatusOK, session)
}

func (c *RegistrationController) SendVerificationCode(ctx echo.Context) error {
	var req dto.SendVerificationCodeRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	session, err := c.registrationService.SendVerificationCode(&req)
	if err != nil {
		status := http.StatusInternalServerError
		switch err {
		case services.ErrSessionNotFound:
			status = http.StatusNotFound
		case services.ErrSessionExpired:
			status = http.StatusGone
		case services.ErrRateLimited:
			status = http.StatusTooManyRequests
		}
		return ctx.JSON(status, map[string]string{"error": err.Error()})
	}

	return httpx.OK(ctx, http.StatusOK, session)
}

func (c *RegistrationController) CheckVerificationCode(ctx echo.Context) error {
	var req dto.CheckVerificationCodeRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	session, err := c.registrationService.CheckVerificationCode(&req, ctx.RealIP())
	if err != nil {
		status := http.StatusInternalServerError
		switch err {
		case services.ErrSessionNotFound:
			status = http.StatusNotFound
		case services.ErrSessionExpired:
			status = http.StatusGone
		case services.ErrInvalidVerificationCode:
			status = http.StatusUnauthorized
		}
		return ctx.JSON(status, map[string]string{"error": err.Error()})
	}

	return httpx.OK(ctx, http.StatusOK, session)
}

func (c *RegistrationController) CreateAccount(ctx echo.Context) error {
	var req dto.RegistrationCreateAccountRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	account, token, err := c.registrationService.CreateAccount(&req, ctx.RealIP())
	if err != nil {
		status := http.StatusInternalServerError
		switch err {
		case services.ErrSessionNotFound:
			status = http.StatusNotFound
		case services.ErrSessionExpired:
			status = http.StatusGone
		case services.ErrPasswordTooWeak:
			status = http.StatusBadRequest
		case services.ErrAccountAlreadyExists:
			status = http.StatusConflict
		case services.ErrInvalidVerificationCode:
			status = http.StatusUnauthorized
		}
		return ctx.JSON(status, map[string]string{"error": err.Error()})
	}

	number := ""
	if account.Phone != nil {
		number = *account.Phone
	}

	return httpx.OK(ctx, http.StatusCreated, map[string]interface{}{
		"account_id": account.ID.String(),
		"number":     number,
		"token":      token,
	})
}

func (c *RegistrationController) GetVerificationSession(ctx echo.Context) error {
	sessionID := ctx.Param("sessionId")

	session, err := c.registrationService.GetVerificationSession(sessionID)
	if err != nil {
		status := http.StatusNotFound
		if err == services.ErrSessionNotFound {
			status = http.StatusNotFound
		}
		return ctx.JSON(status, map[string]string{"error": err.Error()})
	}

	return httpx.OK(ctx, http.StatusOK, session)
}

func (c *RegistrationController) CheckCredentials(ctx echo.Context) error {
	var req dto.AuthCheckRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	matches := make(map[string]string)
	for _, token := range req.Tokens {
		matches[token] = dto.AuthCheckResultNoMatch
	}

	response := &dto.AuthCheckResponseV2{
		Matches: matches,
	}

	return httpx.OK(ctx, http.StatusOK, response)
}

package controllers

import (
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/service"

	"github.com/labstack/echo/v4"
)

type AuthController struct {
	service *services.AuthService
}

func NewAuthController(service *services.AuthService) *AuthController {
	return &AuthController{service: service}
}

func (h *AuthController) RequestCode(c echo.Context) error {
	var req dto.RequestCodeRequest
	if err := c.Bind(&req); err != nil {
		return httpx.BadRequest(c, "invalid request")
	}
	if req.Phone == "" {
		return httpx.BadRequest(c, "phone is required")
	}
	if err := h.service.RequestCode(req.Phone); err != nil {
		return httpx.InternalError(c, err.Error())
	}
	return httpx.OK(c, http.StatusOK, map[string]string{"message": "verification code sent"})
}

func (h *AuthController) Login(c echo.Context) error {
	var req dto.LoginRequest
	if err := c.Bind(&req); err != nil {
		return httpx.BadRequest(c, "invalid request")
	}
	if req.Phone == "" || req.Code == "" {
		return httpx.BadRequest(c, "phone and code are required")
	}

	response, err := h.service.Login(req, c.RealIP())
	if err != nil {
		if err.Error() == "invalid verification code" {
			return httpx.Fail(c, http.StatusUnauthorized, "invalid_verification_code", "invalid verification code")
		}
		return httpx.InternalError(c, err.Error())
	}

	return httpx.OK(c, http.StatusOK, response)
}

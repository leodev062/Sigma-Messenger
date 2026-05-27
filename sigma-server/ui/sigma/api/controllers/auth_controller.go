package controllers

import (
	"net/http"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/services"

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
		return api.BadRequest(c, "invalid request")
	}
	if req.Phone == "" {
		return api.BadRequest(c, "phone is required")
	}
	if err := h.service.RequestCode(req.Phone); err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, map[string]string{"message": "verification code sent"})
}

func (h *AuthController) Login(c echo.Context) error {
	var req dto.LoginRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	if req.Phone == "" || req.Code == "" {
		return api.BadRequest(c, "phone and code are required")
	}

	response, err := h.service.Login(req)
	if err != nil {
		if err.Error() == "invalid verification code" {
			return api.Fail(c, http.StatusUnauthorized, "invalid_verification_code", "invalid verification code")
		}
		return api.InternalError(c, err.Error())
	}

	return api.OK(c, http.StatusOK, response)
}

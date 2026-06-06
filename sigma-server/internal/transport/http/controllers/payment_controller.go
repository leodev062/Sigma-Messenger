package controllers

import (
	"net/http"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/service"

	"github.com/labstack/echo/v4"
)

type PaymentController struct {
	service *services.PaymentService
}

func NewPaymentController(service *services.PaymentService) *PaymentController {
	return &PaymentController{service: service}
}

func (h *PaymentController) Create(c echo.Context) error {
	var req dto.CreatePaymentRequest
	if err := c.Bind(&req); err != nil {
		return httpx.BadRequest(c, "invalid request")
	}
	resp, err := h.service.CreatePayment(req)
	if err != nil {
		return httpx.InternalError(c, err.Error())
	}
	return httpx.OK(c, http.StatusCreated, resp)
}

func (h *PaymentController) Status(c echo.Context) error {
	status, err := h.service.CheckPaymentStatus(c.Param("id"))
	if err != nil {
		return httpx.InternalError(c, err.Error())
	}
	return httpx.OK(c, http.StatusOK, status)
}

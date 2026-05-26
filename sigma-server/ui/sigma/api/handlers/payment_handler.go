package handlers

import (
	"net/http"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/services"

	"github.com/labstack/echo/v4"
)

type PaymentHandler struct {
	service *services.PaymentService
}

func NewPaymentHandler(service *services.PaymentService) *PaymentHandler {
	return &PaymentHandler{service: service}
}

func (h *PaymentHandler) Create(c echo.Context) error {
	var req dto.CreatePaymentRequest
	if err := c.Bind(&req); err != nil {
		return api.BadRequest(c, "invalid request")
	}
	resp, err := h.service.CreatePayment(req)
	if err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusCreated, resp)
}

func (h *PaymentHandler) Status(c echo.Context) error {
	status, err := h.service.CheckPaymentStatus(c.Param("id"))
	if err != nil {
		return api.InternalError(c, err.Error())
	}
	return api.OK(c, http.StatusOK, status)
}

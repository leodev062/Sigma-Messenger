package api

import (
	"net/http"

	"github.com/labstack/echo/v4"
)

type ErrorDetail struct {
	Code    string `json:"code"`
	Message string `json:"message"`
}

type Envelope struct {
	Status string       `json:"status"`
	Data   interface{}  `json:"data,omitempty"`
	Error  *ErrorDetail `json:"error,omitempty"`
}

func OK(c echo.Context, status int, data interface{}) error {
	return c.JSON(status, Envelope{Status: "SUCCESS", Data: data})
}

func Fail(c echo.Context, status int, code, message string) error {
	return c.JSON(status, Envelope{Status: "ERROR", Error: &ErrorDetail{Code: code, Message: message}})
}

func BadRequest(c echo.Context, message string) error {
	return Fail(c, http.StatusBadRequest, "bad_request", message)
}

func Unauthorized(c echo.Context, message string) error {
	return Fail(c, http.StatusUnauthorized, "unauthorized", message)
}

func NotFound(c echo.Context, message string) error {
	return Fail(c, http.StatusNotFound, "not_found", message)
}

func InternalError(c echo.Context, message string) error {
	return Fail(c, http.StatusInternalServerError, "internal_error", message)
}

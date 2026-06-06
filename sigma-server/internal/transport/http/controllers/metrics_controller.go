package controllers

import (
	"net/http"

	"sigma-server/internal/platform/metrics"

	"github.com/labstack/echo/v4"
)

type MetricsController struct {
	collector *metrics.Collector
}

func NewMetricsController(collector *metrics.Collector) *MetricsController {
	return &MetricsController{collector: collector}
}

func (c *MetricsController) Get(ctx echo.Context) error {
	if c.collector == nil {
		return ctx.JSON(http.StatusOK, metrics.Snapshot{})
	}
	return ctx.JSON(http.StatusOK, c.collector.Snapshot())
}

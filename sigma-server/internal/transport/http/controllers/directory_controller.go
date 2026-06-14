package controllers

import (
	"net/http"
	"strconv"

	httpx "sigma-server/internal/transport/http"
	"sigma-server/internal/dto"
	"sigma-server/internal/service"

	"github.com/labstack/echo/v4"
)

type DirectoryController struct {
	service *services.DirectoryService
}

func NewDirectoryController(service *services.DirectoryService) *DirectoryController {
	return &DirectoryController{service: service}
}

func (c *DirectoryController) CheckUsername(ctx echo.Context) error {
	username := ctx.Param("username")
	available := c.service.CheckUsername(username)
	return httpx.OK(ctx, http.StatusOK, map[string]bool{"available": available})
}

func (c *DirectoryController) SyncContacts(ctx echo.Context) error {
	var req dto.SyncContactsRequest
	if err := ctx.Bind(&req); err != nil {
		return httpx.BadRequest(ctx, "invalid request")
	}

	contacts, err := c.service.SyncContacts(req.Phones)
	if err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	return httpx.OK(ctx, http.StatusOK, contacts)
}

func (c *DirectoryController) Search(ctx echo.Context) error {
	term := ctx.QueryParam("term")
	if term == "" {
		return httpx.BadRequest(ctx, "term query parameter is required")
	}

	limitParam := ctx.QueryParam("limit")
	limit := 20
	if limitParam != "" {
		parsedLimit, err := strconv.Atoi(limitParam)
		if err != nil || parsedLimit <= 0 {
			return httpx.BadRequest(ctx, "limit must be a positive integer")
		}
		limit = parsedLimit
	}

	if limit > 100 {
		limit = 100
	}

	users, err := c.service.SearchAccounts(term, limit)
	if err != nil {
		return httpx.InternalError(ctx, err.Error())
	}

	results := make([]dto.AccountSearchResult, 0, len(users))
	for _, user := range users {
		results = append(results, dto.AccountSearchResult{
			ID:        user.ID,
			Username:  user.Username,
			Name:      user.Name,
			Phone:     user.Phone,
			AvatarURL: user.AvatarURL,
		})
	}

	return httpx.OK(ctx, http.StatusOK, results)
}

func safeString(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}

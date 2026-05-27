package controllers

import (
	"net/http"
	"strconv"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/dto"
	"sigma-server/ui/sigma/services"

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
	return api.OK(ctx, http.StatusOK, map[string]bool{"available": available})
}

func (c *DirectoryController) SyncContacts(ctx echo.Context) error {
	var req dto.SyncContactsRequest
	if err := ctx.Bind(&req); err != nil {
		return api.BadRequest(ctx, "invalid request")
	}

	contacts, err := c.service.SyncContacts(req.Phones)
	if err != nil {
		return api.InternalError(ctx, err.Error())
	}

	return api.OK(ctx, http.StatusOK, contacts)
}

func (c *DirectoryController) Search(ctx echo.Context) error {
	term := ctx.QueryParam("term")
	if term == "" {
		return api.BadRequest(ctx, "term query parameter is required")
	}

	limitParam := ctx.QueryParam("limit")
	limit := 20
	if limitParam != "" {
		parsedLimit, err := strconv.Atoi(limitParam)
		if err != nil || parsedLimit <= 0 {
			return api.BadRequest(ctx, "limit must be a positive integer")
		}
		limit = parsedLimit
	}

	if limit > 100 {
		limit = 100
	}

	accounts, err := c.service.SearchAccounts(term, limit)
	if err != nil {
		return api.InternalError(ctx, err.Error())
	}

	results := make([]dto.AccountSearchResult, 0, len(accounts))
	for _, account := range accounts {
		results = append(results, dto.AccountSearchResult{
			ID:          account.ID.String(),
			Username:    safeString(account.Username),
			DisplayName: safeString(account.DisplayName),
			AvatarURL:   safeString(account.AvatarURL),
		})
	}

	return api.OK(ctx, http.StatusOK, results)
}

func safeString(value *string) string {
	if value == nil {
		return ""
	}
	return *value
}

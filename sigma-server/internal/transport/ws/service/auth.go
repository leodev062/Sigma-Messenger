package service

import (
	"fmt"
	"strings"

	"sigma-server/internal/transport/ws/config"
	"sigma-server/internal/transport/ws/ports"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
)

// ConnectionAuth resolves the user id for a websocket upgrade request.
type ConnectionAuth struct {
	tokens   ports.TokenValidator
	hubConfig config.HubConfig
}

func NewConnectionAuth(tokens ports.TokenValidator, hubConfig config.HubConfig) *ConnectionAuth {
	return &ConnectionAuth{tokens: tokens, hubConfig: hubConfig}
}

func (a *ConnectionAuth) ResolveUserID(c echo.Context) (string, error) {
	if a.tokens != nil {
		if token := extractBearer(c.Request().Header.Get("Authorization")); token != "" {
			return a.validateToken(token)
		}
		if a.hubConfig.AllowTokenQueryParam {
			if token := c.QueryParam("token"); token != "" {
				return a.validateToken(token)
			}
		}
	}
	if a.hubConfig.AllowLegacyUserIDQuery {
		userID := c.QueryParam("userId")
		if userID == "" {
			return "", fmt.Errorf("missing authorization token")
		}
		if _, err := uuid.Parse(userID); err != nil {
			return "", fmt.Errorf("invalid userId format")
		}
		return userID, nil
	}
	return "", fmt.Errorf("missing authorization token")
}

func (a *ConnectionAuth) validateToken(token string) (string, error) {
	userID, err := a.tokens.ValidateToken(token)
	if err != nil {
		return "", fmt.Errorf("invalid authorization token")
	}
	return userID, nil
}

func extractBearer(authorization string) string {
	if authorization == "" {
		return ""
	}
	parts := strings.SplitN(authorization, " ", 2)
	if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
		return ""
	}
	return parts[1]
}

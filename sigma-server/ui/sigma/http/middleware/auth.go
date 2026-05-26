package middleware

import (
	"strings"

	"sigma-server/ui/sigma/api"
	"sigma-server/ui/sigma/auth"

	"github.com/labstack/echo/v4"
)

const userIDContextKey = "userID"

func JWTAuth(jwtGenerator *auth.JwtGenerator) echo.MiddlewareFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			authorization := c.Request().Header.Get("Authorization")
			if authorization == "" {
				return api.Unauthorized(c, "missing authorization token")
			}

			parts := strings.SplitN(authorization, " ", 2)
			if len(parts) != 2 || !strings.EqualFold(parts[0], "Bearer") {
				return api.Unauthorized(c, "invalid authorization header")
			}

			userID, err := jwtGenerator.ValidateToken(parts[1])
			if err != nil {
				return api.Unauthorized(c, "invalid authorization token")
			}

			c.Set(userIDContextKey, userID)
			return next(c)
		}
	}
}

func UserIDFromContext(c echo.Context) (string, bool) {
	value, ok := c.Get(userIDContextKey).(string)
	return value, ok && value != ""
}

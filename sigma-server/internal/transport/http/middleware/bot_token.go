package middleware

import (
	"net/http"

	"sigma-server/internal/domain/entities"
	"sigma-server/internal/repository/storage"

	"github.com/labstack/echo/v4"
)

const botAccountContextKey = "bot_account"

type BotTokenAuth struct {
	bots *storage.BotRepository
}

func NewBotTokenAuth(bots *storage.BotRepository) *BotTokenAuth {
	return &BotTokenAuth{bots: bots}
}

func (m *BotTokenAuth) Middleware() echo.MiddlewareFunc {
	return func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			token := c.Param("token")
			if token == "" {
				return c.JSON(http.StatusUnauthorized, botAPIFail(401, "bot token is required"))
			}
			bot, err := m.bots.FindByToken(token)
			if err != nil {
				return c.JSON(http.StatusUnauthorized, botAPIFail(401, "invalid bot token"))
			}
			c.Set(botAccountContextKey, bot)
			return next(c)
		}
	}
}

func BotFromContext(c echo.Context) (*entities.Account, bool) {
	value := c.Get(botAccountContextKey)
	if value == nil {
		return nil, false
	}
	bot, ok := value.(*entities.Account)
	return bot, ok
}

func botAPIFail(code int, description string) map[string]interface{} {
	return map[string]interface{}{
		"ok":          false,
		"error_code":  code,
		"description": description,
	}
}

package security

import (
	"net/http"
	"strings"
)

// OriginChecker validates the Origin header on websocket upgrades.
type OriginChecker struct {
	allowed map[string]struct{}
}

func NewOriginChecker(origins []string) *OriginChecker {
	allowed := make(map[string]struct{}, len(origins))
	for _, origin := range origins {
		trimmed := strings.TrimSpace(origin)
		if trimmed != "" {
			allowed[trimmed] = struct{}{}
		}
	}
	return &OriginChecker{allowed: allowed}
}

func (c *OriginChecker) Allow(r *http.Request) bool {
	if c == nil || len(c.allowed) == 0 {
		return false
	}

	origin := strings.TrimSpace(r.Header.Get("Origin"))
	if origin == "" {
		return true
	}

	_, ok := c.allowed[origin]
	return ok
}

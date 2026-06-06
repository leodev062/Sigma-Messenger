package security

import (
	"net/http/httptest"
	"testing"
)

func TestOriginCheckerAllowsMissingOrigin(t *testing.T) {
	checker := NewOriginChecker([]string{"https://app.example.com"})
	req := httptest.NewRequest("GET", "/ws", nil)
	if !checker.Allow(req) {
		t.Fatal("expected missing Origin to be allowed")
	}
}

func TestOriginCheckerRejectsUnknownOrigin(t *testing.T) {
	checker := NewOriginChecker([]string{"https://app.example.com"})
	req := httptest.NewRequest("GET", "/ws", nil)
	req.Header.Set("Origin", "https://evil.example.com")
	if checker.Allow(req) {
		t.Fatal("expected unknown Origin to be rejected")
	}
}

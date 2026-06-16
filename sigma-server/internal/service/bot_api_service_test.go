package services

import (
	"testing"

	"sigma-server/internal/domain/entities"
)

func TestBotAPIService_validateWebhookURL(t *testing.T) {
	svc := &BotAPIService{allowHTTPHook: true}

	if err := svc.validateWebhookURL("https://example.com/hook"); err != nil {
		t.Fatalf("expected valid https url: %v", err)
	}
	if err := svc.validateWebhookURL("http://localhost:8080/hook"); err != nil {
		t.Fatalf("expected valid http url when allowed: %v", err)
	}
	if err := svc.validateWebhookURL("ftp://example.com"); err == nil {
		t.Fatal("expected invalid scheme")
	}
}

func TestBuildUpdate(t *testing.T) {
	name := "Ana"
	user := "dev01"
	account := &entities.Account{
		ID:          "11111111-1111-1111-1111-111111111111",
		DisplayName: &name,
		Username:    &user,
	}
	update := buildUpdate(7, account, "/clima SP")
	if update.UpdateID != 7 {
		t.Fatalf("unexpected update_id: %d", update.UpdateID)
	}
	if update.Message == nil || update.Message.Text != "/clima SP" {
		t.Fatalf("unexpected message: %+v", update.Message)
	}
}

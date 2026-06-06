package router

import (
	"encoding/json"
	"testing"

	"sigma-server/internal/transport/ws/protocol"
)

func TestRouterMatchDeleteMessagePaths(t *testing.T) {
	rt := New(nil, nil, nil, nil)
	paths := []string{"/api/v2/message", "/v2/message", "v2/message"}
	for _, path := range paths {
		route, _ := rt.match(&protocol.Request{Verb: "DELETE", Path: path})
		if route == nil {
			t.Fatalf("expected match for %s", path)
		}
	}
}

func TestDeleteMessagePayloadParse(t *testing.T) {
	raw, _ := json.Marshal(map[string]int{"pending_message_id": 42})
	var payload struct {
		PendingMessageID int `json:"pending_message_id"`
	}
	if err := json.Unmarshal(raw, &payload); err != nil {
		t.Fatal(err)
	}
	if payload.PendingMessageID != 42 {
		t.Fatalf("got %d", payload.PendingMessageID)
	}
}

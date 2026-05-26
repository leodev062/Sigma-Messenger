package websocket

import "testing"

func TestWebsocketConnectionManagerTracksLocalPresence(t *testing.T) {
	manager := NewWebsocketConnectionManager()
	connection := &WebsocketConnection{
		Client:    &AuthenticatedClient{UserID: "user-1"},
		Send:      make(chan []byte, 1),
		closeOnce: make(chan struct{}),
	}

	manager.RegisterConnection(connection)

	if !manager.IsOnline("user-1") {
		t.Fatalf("expected user to be online after register")
	}

	if !manager.IsLocallyPresent("user-1") {
		t.Fatalf("expected user to be locally present after register")
	}

	manager.UnregisterConnection(connection)

	if manager.IsOnline("user-1") {
		t.Fatalf("expected user to be offline after unregister")
	}
}

func TestWebsocketConnectionManagerCloseUserClosesAllLocalConnections(t *testing.T) {
	manager := NewWebsocketConnectionManager()
	first := &WebsocketConnection{
		Client:    &AuthenticatedClient{UserID: "user-1"},
		Send:      make(chan []byte, 1),
		closeOnce: make(chan struct{}),
	}
	second := &WebsocketConnection{
		Client:    &AuthenticatedClient{UserID: "user-1"},
		Send:      make(chan []byte, 1),
		closeOnce: make(chan struct{}),
	}

	manager.RegisterConnection(first)
	manager.RegisterConnection(second)

	manager.CloseUser("user-1")

	if manager.IsOnline("user-1") {
		t.Fatalf("expected user to be offline after closing local connections")
	}

	select {
	case <-first.closeOnce:
	default:
		t.Fatalf("expected first connection to be closed")
	}

	select {
	case <-second.closeOnce:
	default:
		t.Fatalf("expected second connection to be closed")
	}
}

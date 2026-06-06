package hub

import (
	"context"
	"testing"
	"time"

	"sigma-server/internal/transport/ws/config"
	"sigma-server/internal/transport/ws/session"
)

type mockConn struct{}

func (mockConn) RemoteAddr() string                { return "127.0.0.1:1" }
func (mockConn) SetReadLimit(int64)                {}
func (mockConn) SetReadDeadline(time.Time) error   { return nil }
func (mockConn) SetWriteDeadline(time.Time) error  { return nil }
func (mockConn) SetPongHandler(func(string) error) {}
func (mockConn) ReadMessage() (int, []byte, error) { return 0, nil, nil }
func (mockConn) WriteMessage(int, []byte) error    { return nil }
func (mockConn) Close() error                      { return nil }

func startTestHub(t *testing.T) *Hub {
	t.Helper()
	h := New(config.HubConfig{MaxConnectionsPerUser: 5})
	go h.Run()
	t.Cleanup(func() {
		ctx, cancel := context.WithTimeout(context.Background(), time.Second)
		defer cancel()
		h.Shutdown(ctx)
	})
	return h
}

func waitHub(t *testing.T) {
	t.Helper()
	time.Sleep(20 * time.Millisecond)
}

func TestHubTracksPresence(t *testing.T) {
	h := startTestHub(t)
	conn := session.NewConnection(h, nil, mockConn{}, "user-1", nil, nil, nil)
	h.Register(conn)
	waitHub(t)
	if !h.IsOnline("user-1") {
		t.Fatal("expected online")
	}
	conn.Teardown()
	waitHub(t)
	if h.IsOnline("user-1") {
		t.Fatal("expected offline")
	}
}

func TestHubCanAcceptLimit(t *testing.T) {
	h := New(config.HubConfig{MaxConnectionsPerUser: 1})
	go h.Run()
	defer func() {
		ctx, cancel := context.WithTimeout(context.Background(), time.Second)
		defer cancel()
		h.Shutdown(ctx)
	}()
	conn := session.NewConnection(h, nil, mockConn{}, "user-1", nil, nil, nil)
	h.Register(conn)
	waitHub(t)
	if h.CanAccept("user-1") {
		t.Fatal("expected limit reached")
	}
}

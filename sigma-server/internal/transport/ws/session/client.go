package session

import "time"

// Client holds authenticated identity for a websocket session.
type Client struct {
	UserID      string
	RemoteAddr  string
	ConnectedAt time.Time
	LastSeen    time.Time
}

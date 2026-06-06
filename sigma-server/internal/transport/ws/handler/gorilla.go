package handler

import (
	"time"

	"github.com/gorilla/websocket"
	"sigma-server/internal/transport/ws/session"
)

type gorillaConn struct {
	*websocket.Conn
}

func (g *gorillaConn) RemoteAddr() string {
	return g.Conn.RemoteAddr().String()
}

func wrapGorilla(conn *websocket.Conn) session.Conn {
	return &gorillaConn{Conn: conn}
}

// Ensure gorillaConn satisfies session.Conn at compile time.
var _ session.Conn = (*gorillaConn)(nil)

const (
	binaryMessage = websocket.BinaryMessage
	pingMessage   = websocket.PingMessage
	closeMessage  = websocket.CloseMessage
)

func init() {
	_ = time.Second
}

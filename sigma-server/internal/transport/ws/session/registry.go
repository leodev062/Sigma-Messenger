package session

// Registry is the hub contract used by an active connection.
type Registry interface {
	Register(conn *Connection)
	Unregister(conn *Connection)
	Dispatch(recipientID, destinationType string, payload []byte)
	RefreshPresence(userID string)
}

package session

// OutboundDispatcher routes outgoing websocket messages by recipient type.
type OutboundDispatcher interface {
	Dispatch(senderID, destinationID string, payload []byte) error
}

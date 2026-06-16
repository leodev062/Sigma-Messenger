package session

// OutboundDispatcher routes outgoing websocket messages by recipient type.
type OutboundDispatcher interface {
	Dispatch(senderID, destinationID, destinationType string, payload []byte) error
}

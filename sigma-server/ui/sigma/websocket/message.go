package websocket

import (
	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

type WebsocketMessageType string

const (
	UnknownType  WebsocketMessageType = "UNKNOWN"
	RequestType  WebsocketMessageType = "REQUEST"
	ResponseType WebsocketMessageType = "RESPONSE"
	MessageType  WebsocketMessageType = "MESSAGE"
)

type WebsocketMessage struct {
	Type     WebsocketMessageType
	Request  *WebsocketRequestMessage
	Response *WebsocketResponseMessage
}

type WebsocketRequestMessage struct {
	Verb        string
	Path        string
	Id          string
	Destination string
	Headers     []string
	Body        []byte
}

type WebsocketResponseMessage struct {
	Id          string
	Status      int
	Message     string
	Destination string
	Headers     []string
	Body        []byte
}

func DecodeWebsocketMessage(data []byte) (*WebsocketMessage, error) {
	var payload sigmapb.WebSocketMessage
	if err := proto.Unmarshal(data, &payload); err != nil {
		return nil, err
	}

	return fromProto(&payload), nil
}

func EncodeWebsocketMessage(msg *WebsocketMessage) ([]byte, error) {
	payload := toProto(msg)
	return proto.Marshal(payload)
}

func fromProto(payload *sigmapb.WebSocketMessage) *WebsocketMessage {
	if payload == nil {
		return &WebsocketMessage{Type: UnknownType}
	}

	message := &WebsocketMessage{Type: UnknownType}

	switch payload.GetType() {
	case sigmapb.WebSocketMessage_REQUEST:
		message.Type = RequestType
		message.Request = fromProtoRequest(payload.GetRequest())
	case sigmapb.WebSocketMessage_RESPONSE:
		message.Type = ResponseType
		message.Response = fromProtoResponse(payload.GetResponse())
	case sigmapb.WebSocketMessage_TYPE_UNKNOWN:
		message.Type = UnknownType
	default:
		message.Type = MessageType
		message.Request = fromProtoRequest(payload.GetRequest())
	}

	return message
}

func fromProtoRequest(request *sigmapb.WebSocketRequestMessage) *WebsocketRequestMessage {
	if request == nil {
		return nil
	}

	return &WebsocketRequestMessage{
		Verb: request.GetVerb(),
		Path: request.GetPath(),
		Id:   request.GetId(),
		Body: append([]byte(nil), request.GetBody()...),
	}
}

func fromProtoResponse(response *sigmapb.WebSocketResponseMessage) *WebsocketResponseMessage {
	if response == nil {
		return nil
	}

	return &WebsocketResponseMessage{
		Id:      response.GetId(),
		Status:  int(response.GetStatus()),
		Message: response.GetMessage(),
		Body:    append([]byte(nil), response.GetBody()...),
	}
}

func toProto(message *WebsocketMessage) *sigmapb.WebSocketMessage {
	if message == nil {
		return &sigmapb.WebSocketMessage{}
	}

	payload := &sigmapb.WebSocketMessage{}

	switch message.Type {
	case RequestType:
		payload.Type = sigmapb.WebSocketMessage_REQUEST
		payload.Request = toProtoRequest(message.Request)
	case ResponseType:
		payload.Type = sigmapb.WebSocketMessage_RESPONSE
		payload.Response = toProtoResponse(message.Response)
	case MessageType:
		payload.Type = sigmapb.WebSocketMessage_Type(3)
		payload.Request = toProtoRequest(message.Request)
	default:
		payload.Type = sigmapb.WebSocketMessage_TYPE_UNKNOWN
	}

	return payload
}

func toProtoRequest(request *WebsocketRequestMessage) *sigmapb.WebSocketRequestMessage {
	if request == nil {
		return nil
	}

	return &sigmapb.WebSocketRequestMessage{
		Id:   request.Id,
		Verb: request.Verb,
		Path: request.Path,
		Body: append([]byte(nil), request.Body...),
	}
}

func toProtoResponse(response *WebsocketResponseMessage) *sigmapb.WebSocketResponseMessage {
	if response == nil {
		return nil
	}

	return &sigmapb.WebSocketResponseMessage{
		Id:      response.Id,
		Status:  int32(response.Status),
		Message: response.Message,
		Body:    append([]byte(nil), response.Body...),
	}
}

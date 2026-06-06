package protocol

import (
	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

type MessageType string

const (
	UnknownType  MessageType = "UNKNOWN"
	RequestType  MessageType = "REQUEST"
	ResponseType MessageType = "RESPONSE"
	MessageKind  MessageType = "MESSAGE"
)

type Message struct {
	Type     MessageType
	Request  *Request
	Response *Response
}

type Request struct {
	Verb string
	Path string
	Id   string
	Body []byte
}

type Response struct {
	Id      string
	Status  int
	Message string
	Body    []byte
}

func Decode(data []byte) (*Message, error) {
	var payload sigmapb.WebSocketMessage
	if err := proto.Unmarshal(data, &payload); err != nil {
		return nil, err
	}
	return fromProto(&payload), nil
}

func Encode(msg *Message) ([]byte, error) {
	return proto.Marshal(toProto(msg))
}

func WrapEnvelope(envelope []byte, id string) ([]byte, error) {
	// Signal Pattern: Every incoming message is a REQUEST (PUT) to /v2/messages
	// Removed leading slash for better compatibility with app string matching
	path := "v2/messages"

	msg := &Message{
		Type: RequestType, // Using type 1 (REQUEST) which is the most reliable for Flutter side
		Request: &Request{
			Verb: "PUT",
			Path: path,
			Id:   id,
			Body: envelope,
		},
	}
	return Encode(msg)
}

func fromProto(payload *sigmapb.WebSocketMessage) *Message {
	if payload == nil {
		return &Message{Type: UnknownType}
	}

	message := &Message{Type: UnknownType}
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
		message.Type = MessageKind
		message.Request = fromProtoRequest(payload.GetRequest())
	}
	return message
}

func fromProtoRequest(request *sigmapb.WebSocketRequestMessage) *Request {
	if request == nil {
		return nil
	}
	return &Request{
		Verb: request.GetVerb(),
		Path: request.GetPath(),
		Id:   request.GetId(),
		Body: append([]byte(nil), request.GetBody()...),
	}
}

func fromProtoResponse(response *sigmapb.WebSocketResponseMessage) *Response {
	if response == nil {
		return nil
	}
	return &Response{
		Id:      response.GetId(),
		Status:  int(response.GetStatus()),
		Message: response.GetMessage(),
		Body:    append([]byte(nil), response.GetBody()...),
	}
}

func toProto(message *Message) *sigmapb.WebSocketMessage {
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
	case MessageKind:
		payload.Type = sigmapb.WebSocketMessage_Type(3)
		payload.Request = toProtoRequest(message.Request)
	default:
		payload.Type = sigmapb.WebSocketMessage_TYPE_UNKNOWN
	}
	return payload
}

func toProtoRequest(request *Request) *sigmapb.WebSocketRequestMessage {
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

func toProtoResponse(response *Response) *sigmapb.WebSocketResponseMessage {
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

package router

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/url"
	"strconv"
	"strings"

	"sigma-server/internal/transport/ws/ports"
	"sigma-server/internal/transport/ws/protocol"

	"github.com/google/uuid"
	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

// ReceiptHandler interface para processar recibos de mensagens
type ReceiptHandler interface {
	HandleReceipt(ctx context.Context, receipt *sigmapb.Message, senderID string) error
}

// TypingHandler interface para processar indicadores de digitação
type TypingHandler interface {
	HandleTyping(ctx context.Context, typing *sigmapb.Message, senderID, recipientID string) error
}

// SyncHandler interface para processar mensagens de sincronização
type SyncHandler interface {
	HandleSync(ctx context.Context, sync *sigmapb.Message, senderID string) error
}

type route struct {
	verb     string
	segments []string
	dynamic  []bool
	handler  func(*Context) ([]byte, int, error)
}

// Context carries per-request state for a websocket route handler.
type Context struct {
	Session     ports.OutboundSession
	Request     *protocol.Request
	UserID      string
	PathParams  map[string]string
	Messages    ports.PendingMessageStore
	Envelopes   ports.EnvelopeStore
	AccountKeys ports.AccountKeysReader
}

// Router dispatches websocket REQUEST frames to handlers.
type Router struct {
	routes      []route
	messages    ports.PendingMessageStore
	envelopes   ports.EnvelopeStore
	accountKeys ports.AccountKeysReader
	receipts    ReceiptHandler
	typing      TypingHandler
	sync        SyncHandler
	dispatcher  ports.OutboundDispatcher
	logger      *log.Logger
}

func New(messages ports.PendingMessageStore, envelopes ports.EnvelopeStore, keys ports.AccountKeysReader, dispatcher ports.OutboundDispatcher, logger *log.Logger) *Router {
	if logger == nil {
		logger = log.Default()
	}

	rt := &Router{
		messages:    messages,
		envelopes:   envelopes,
		accountKeys: keys,
		dispatcher:  dispatcher,
		logger:      logger,
	}

	rt.routes = []route{
		// Message deletion
		rt.route("DELETE", []string{"api", "v2", "message"}, nil, rt.deleteMessage),
		rt.route("DELETE", []string{"v2", "message"}, nil, rt.deleteMessage),
		rt.route("DELETE", []string{"v2", "messages", "receipt"}, nil, rt.deleteMessage),

		// Receipts
		rt.route("PUT", []string{"v2", "receipt", "{type}"}, []bool{false, false, true}, rt.putReceipt),

		// Typing indicators
		rt.route("PUT", []string{"v2", "typing", "{chatId}"}, []bool{false, false, true}, rt.putTyping),

		// Sync messages
		rt.route("PUT", []string{"v2", "sync"}, nil, rt.putSync),
	}

	return rt
}

// SetReceiptHandler define o handler de recibos
func (rt *Router) SetReceiptHandler(handler ReceiptHandler) {
	rt.receipts = handler
}

// SetTypingHandler define o handler de digitação
func (rt *Router) SetTypingHandler(handler TypingHandler) {
	rt.typing = handler
}

// SetSyncHandler define o handler de sincronização
func (rt *Router) SetSyncHandler(handler SyncHandler) {
	rt.sync = handler
}

func (rt *Router) route(verb string, segments []string, dynamic []bool, handler func(*Context) ([]byte, int, error)) route {
	return route{verb: verb, segments: segments, dynamic: dynamic, handler: handler}
}

func (rt *Router) Handle(session ports.OutboundSession, request *protocol.Request) ([]byte, int, error) {
	matched, params := rt.match(request)
	if matched == nil {
		return nil, 404, fmt.Errorf("unsupported websocket route: %s %s", request.Verb, request.Path)
	}
	ctx := &Context{
		Session:     session,
		Request:     request,
		UserID:      session.UserID(),
		PathParams:  params,
		Messages:    rt.messages,
		Envelopes:   rt.envelopes,
		AccountKeys: rt.accountKeys,
	}
	return matched.handler(ctx)
}

func (rt *Router) match(request *protocol.Request) (*route, map[string]string) {
	if request == nil {
		return nil, nil
	}
	path := strings.Trim(parsePath(request.Path), "/")
	segments := []string{}
	if path != "" {
		segments = strings.Split(path, "/")
	}
	for i := range rt.routes {
		r := &rt.routes[i]
		if !strings.EqualFold(r.verb, strings.TrimSpace(request.Verb)) {
			continue
		}
		if len(r.segments) != len(segments) {
			continue
		}
		params := make(map[string]string, len(r.segments))
		matched := true
		for idx, segment := range r.segments {
			if r.dynamic != nil && r.dynamic[idx] {
				params[segment[1:len(segment)-1]] = segments[idx]
				continue
			}
			if segment != segments[idx] {
				matched = false
				break
			}
		}
		if matched {
			return r, params
		}
	}
	return nil, nil
}

func parsePath(raw string) string {
	parsed, err := url.Parse(raw)
	if err != nil {
		return strings.Trim(raw, "/")
	}
	return strings.Trim(parsed.Path, "/")
}

func (rt *Router) deleteMessage(ctx *Context) ([]byte, int, error) {
	if ctx.Messages == nil {
		return MarshalError(500, "message store is not configured"), 500, nil
	}
	recipientID, err := uuid.Parse(ctx.UserID)
	if err != nil {
		return MarshalError(400, "invalid authenticated user"), 400, nil
	}

	if len(ctx.Request.Body) == 0 {
		return MarshalError(400, "empty receipt body"), 400, nil
	}

	// The client sends a sigmapb.Envelope with type RECEIPT and the requestId in Content
	var envelope sigmapb.Envelope
	if err := proto.Unmarshal(ctx.Request.Body, &envelope); err != nil {
		// Fallback: maybe it's the raw ID for backward compatibility
		requestID := strings.TrimSpace(string(ctx.Request.Body))
		return rt.deleteByID(ctx, requestID, recipientID)
	}

	if envelope.Status != "receipt" {
		return MarshalError(400, "invalid envelope type for deletion"), 400, nil
	}

	requestID := strings.TrimSpace(string(envelope.Payload))
	return rt.deleteByID(ctx, requestID, recipientID)
}

func (rt *Router) deleteByID(ctx *Context, requestID string, recipientID uuid.UUID) ([]byte, int, error) {
	// 0) Tentar deletar do EnvelopeStore (Relay Engine)
	if ctx.Envelopes != nil {
		rows, err := ctx.Envelopes.DeleteByEnvelopeIDForRecipient(requestID, recipientID.String())
		if err == nil && rows > 0 {
			return marshalJSON(map[string]bool{"deleted": true})
		}
		// Tentar como ID sequencial
		if pid, err := strconv.Atoi(requestID); err == nil {
			rows, err2 := ctx.Envelopes.DeleteForRecipient(pid, recipientID.String())
			if err2 == nil && rows > 0 {
				return marshalJSON(map[string]bool{"deleted": true})
			}
		}
	}

	// 1) tentar como uuid message_id (Backward Compatibility)
	if mid, err := uuid.Parse(requestID); err == nil {
		rows, err2 := ctx.Messages.DeleteByMessageIDForRecipient(mid, recipientID)
		if err2 != nil {
			return MarshalError(500, err2.Error()), 500, nil
		}
		if rows > 0 {
			return marshalJSON(map[string]bool{"deleted": true})
		}
	}

	// 2) tentar como int pending_message_id
	if pid, err := strconv.Atoi(requestID); err == nil {
		rows, err2 := ctx.Messages.DeleteForRecipient(pid, recipientID)
		if err2 != nil {
			return MarshalError(500, err2.Error()), 500, nil
		}
		if rows > 0 {
			return marshalJSON(map[string]bool{"deleted": true})
		}
	}

	return MarshalError(404, "pending message not found"), 404, nil
}

func marshalJSON(value interface{}) ([]byte, int, error) {
	body, err := json.Marshal(value)
	if err != nil {
		return MarshalError(500, err.Error()), 500, nil
	}
	return body, 200, nil
}

func MarshalError(status int, message string) []byte {
	body, _ := json.Marshal(map[string]string{"error": message})
	return body
}

// putReceipt processa confirmações de entrega/leitura.
func (rt *Router) putReceipt(ctx *Context) ([]byte, int, error) {
	if rt.receipts == nil {
		return MarshalError(500, "receipt service not configured"), 500, nil
	}

	receiptType := ctx.PathParams["type"]
	if receiptType == "" {
		return MarshalError(400, "missing receipt type"), 400, nil
	}

	// Desserializar ReceiptMessage do body
	var receipt sigmapb.Message
	if err := proto.Unmarshal(ctx.Request.Body, &receipt); err != nil {
		return MarshalError(400, fmt.Sprintf("invalid receipt payload: %v", err)), 400, nil
	}

	// Processar recibo
	if err := rt.receipts.HandleReceipt(context.Background(), &receipt, ctx.UserID); err != nil {
		rt.logger.Printf("router: receipt handler error: %v", err)
		return MarshalError(500, "failed to process receipt"), 500, nil
	}

	return marshalJSON(map[string]bool{"received": true})
}

// putTyping processa indicadores de digitação.
func (rt *Router) putTyping(ctx *Context) ([]byte, int, error) {
	if rt.typing == nil {
		return MarshalError(500, "typing service not configured"), 500, nil
	}

	chatID := ctx.PathParams["chatId"]
	if chatID == "" {
		return MarshalError(400, "missing chatId"), 400, nil
	}

	// Desserializar TypingMessage do body
	var typing sigmapb.Message
	if err := proto.Unmarshal(ctx.Request.Body, &typing); err != nil {
		return MarshalError(400, fmt.Sprintf("invalid typing payload: %v", err)), 400, nil
	}

	// Processar typing indicator
	if err := rt.typing.HandleTyping(context.Background(), &typing, ctx.UserID, chatID); err != nil {
		rt.logger.Printf("router: typing handler error: %v", err)
		return MarshalError(500, "failed to process typing"), 500, nil
	}

	return marshalJSON(map[string]bool{"received": true})
}

// putSync processa sincronização de status.
func (rt *Router) putSync(ctx *Context) ([]byte, int, error) {
	if rt.sync == nil {
		return MarshalError(500, "sync service not configured"), 500, nil
	}

	// Desserializar SyncMessage do body
	var sync sigmapb.Message
	if err := proto.Unmarshal(ctx.Request.Body, &sync); err != nil {
		return MarshalError(400, fmt.Sprintf("invalid sync payload: %v", err)), 400, nil
	}

	// Processar sync message
	if err := rt.sync.HandleSync(context.Background(), &sync, ctx.UserID); err != nil {
		rt.logger.Printf("router: sync handler error: %v", err)
		return MarshalError(500, "failed to process sync"), 500, nil
	}

	return marshalJSON(map[string]bool{"received": true})
}

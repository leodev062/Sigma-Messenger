package websocket

import (
	"encoding/json"
	"fmt"
	"net/url"
	"strings"

	"sigma-server/ui/sigma/services"
	"sigma-server/ui/sigma/storage"

	"github.com/google/uuid"
)

type websocketRoute struct {
	verb     string
	segments []string
	dynamic  []bool
	handler  func(*RequestContext) ([]byte, int, error)
}

type RequestContext struct {
	Connection     *WebsocketConnection
	Request        *WebsocketRequestMessage
	UserID         string
	PathParams     map[string]string
	AccountService *services.AccountService
	MessageManager *storage.MessageManager
}

type WebsocketRouter struct {
	routes         []websocketRoute
	accountService *services.AccountService
	messageManager *storage.MessageManager
}

func NewWebsocketRouter(accountService *services.AccountService, messageManager *storage.MessageManager) *WebsocketRouter {
	router := &WebsocketRouter{
		accountService: accountService,
		messageManager: messageManager,
	}

	router.registerRoutes()
	return router
}

func (r *WebsocketRouter) registerRoutes() {
	r.routes = []websocketRoute{
		{verb: "GET", segments: []string{"api", "v1", "accounts", "{id}", "keys"}, dynamic: []bool{false, false, false, true, false}, handler: r.handleGetKeys},
		{verb: "DELETE", segments: []string{"api", "v1", "message"}, handler: r.handleDeleteMessage},
	}
}

func parseWebsocketPath(rawPath string) string {
	parsed, err := url.Parse(rawPath)
	if err != nil {
		return strings.Trim(rawPath, "/")
	}

	return strings.Trim(parsed.Path, "/")
}

func (r *WebsocketRouter) Match(request *WebsocketRequestMessage) (*websocketRoute, map[string]string) {
	if request == nil {
		return nil, nil
	}

	path := parseWebsocketPath(request.Path)
	segments := []string{}
	if path != "" {
		segments = strings.Split(path, "/")
	}

	for _, route := range r.routes {
		if !strings.EqualFold(route.verb, strings.TrimSpace(request.Verb)) {
			continue
		}
		if len(route.segments) != len(segments) {
			continue
		}

		params := make(map[string]string, len(route.segments))
		matched := true
		for idx, segment := range route.segments {
			if route.dynamic != nil && route.dynamic[idx] {
				params[segment[1:len(segment)-1]] = segments[idx]
				continue
			}
			if segment != segments[idx] {
				matched = false
				break
			}
		}

		if !matched {
			continue
		}

		return &route, params
	}

	return nil, nil
}

func (r *WebsocketRouter) Handle(connection *WebsocketConnection, request *WebsocketRequestMessage) ([]byte, int, error) {
	route, params := r.Match(request)
	if route == nil {
		return nil, 404, fmt.Errorf("unsupported websocket route: %s %s", request.Verb, request.Path)
	}

	ctx := &RequestContext{
		Connection:     connection,
		Request:        request,
		UserID:         connection.Client.UserID,
		PathParams:     params,
		AccountService: r.accountService,
		MessageManager: r.messageManager,
	}

	return route.handler(ctx)
}

func (r *WebsocketRouter) handleGetKeys(ctx *RequestContext) ([]byte, int, error) {
	id, err := uuid.Parse(ctx.PathParams["id"])
	if err != nil {
		return marshalError(400, "invalid account id"), 400, nil
	}

	keys, err := ctx.AccountService.GetKeys(id)
	if err != nil {
		return marshalError(404, "account not found"), 404, nil
	}

	return marshalJSON(keys, 200)
}

func (r *WebsocketRouter) handleDeleteMessage(ctx *RequestContext) ([]byte, int, error) {
	if ctx.MessageManager == nil {
		return marshalError(500, "message manager is not configured"), 500, nil
	}

	var payload struct {
		PendingMessageID int       `json:"pending_message_id"`
		MessageID        uuid.UUID `json:"message_id"`
	}

	if len(ctx.Request.Body) > 0 {
		if err := json.Unmarshal(ctx.Request.Body, &payload); err != nil {
			return marshalError(400, "invalid request body"), 400, nil
		}
	}

	if payload.PendingMessageID != 0 {
		if err := ctx.MessageManager.Delete(payload.PendingMessageID); err != nil {
			return marshalError(500, err.Error()), 500, nil
		}
		return marshalJSON(map[string]bool{"deleted": true}, 200)
	}

	if payload.MessageID != uuid.Nil {
		if err := ctx.MessageManager.DeleteByMessageID(payload.MessageID); err != nil {
			return marshalError(500, err.Error()), 500, nil
		}
		return marshalJSON(map[string]bool{"deleted": true}, 200)
	}

	return marshalError(400, "message id is required"), 400, nil
}

func marshalJSON(value interface{}, status int) ([]byte, int, error) {
	body, err := json.Marshal(value)
	if err != nil {
		return marshalError(500, err.Error()), 500, nil
	}

	return body, status, nil
}

func marshalError(status int, message string) []byte {
	body, _ := json.Marshal(map[string]string{"error": message})
	return body
}

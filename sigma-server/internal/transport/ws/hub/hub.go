package hub

import (
	"context"
	"log"
	"sync"

	"sigma-server/internal/platform/metrics"
	"sigma-server/internal/platform/presence"
	"sigma-server/internal/transport/ws/config"
	"sigma-server/internal/transport/ws/protocol"
	"sigma-server/internal/transport/ws/session"
)

type dispatchJob struct {
	recipientID string
	payload     []byte
}

// Hub manages active websocket sessions and message fan-out.
type Hub struct {
	mu               sync.RWMutex
	connections      map[string]map[*session.Connection]struct{}
	register         chan *session.Connection
	unregister       chan *session.Connection
	dispatch         chan dispatchJob
	stop             chan struct{}
	stopped          chan struct{}
	OnOfflineMessage func(recipientID string, message []byte)
	logger           *log.Logger
	presence         *presence.Coordinator
	cfg              config.HubConfig
	metrics          *metrics.Collector
}

func New(cfg config.HubConfig) *Hub {
	if cfg.MaxConnectionsPerUser <= 0 {
		cfg.MaxConnectionsPerUser = 5
	}
	return &Hub{
		connections: make(map[string]map[*session.Connection]struct{}),
		register:    make(chan *session.Connection),
		unregister:  make(chan *session.Connection),
		dispatch:    make(chan dispatchJob, 256),
		stop:        make(chan struct{}),
		stopped:     make(chan struct{}),
		logger:      log.Default(),
		cfg:         cfg,
	}
}

func (h *Hub) SetPresenceCoordinator(coordinator *presence.Coordinator) {
	h.presence = coordinator
}

func (h *Hub) SetMetrics(collector *metrics.Collector) {
	h.metrics = collector
}

func (h *Hub) Run() {
	defer close(h.stopped)
	for {
		select {
		case <-h.stop:
			h.closeAll()
			return
		case conn := <-h.register:
			h.registerConnection(conn)
		case conn := <-h.unregister:
			h.unregisterConnection(conn)
		case job := <-h.dispatch:
			if h.deliver(job.recipientID, job.payload) {
				continue
			}
			if h.OnOfflineMessage != nil {
				h.OnOfflineMessage(job.recipientID, job.payload)
			}
		}
	}
}

func (h *Hub) Shutdown(ctx context.Context) {
	select {
	case <-h.stop:
		<-h.stopped
		return
	default:
		close(h.stop)
	}
	select {
	case <-h.stopped:
	case <-ctx.Done():
	}
}

func (h *Hub) CanAccept(userID string) bool {
	if userID == "" {
		return false
	}
	limit := h.cfg.MaxConnectionsPerUser
	if limit <= 0 {
		return true
	}
	h.mu.RLock()
	defer h.mu.RUnlock()
	set, ok := h.connections[userID]
	if !ok {
		return true
	}
	return len(set) < limit
}

func (h *Hub) Register(conn *session.Connection) {
	h.register <- conn
}

func (h *Hub) Unregister(conn *session.Connection) {
	h.unregisterConnection(conn)
}

func (h *Hub) RegisterConnection(conn *session.Connection) {
	h.Register(conn)
}

func (h *Hub) UnregisterConnection(conn *session.Connection) {
	h.unregister <- conn
}

func (h *Hub) registerConnection(conn *session.Connection) {
	if conn == nil || conn.Client == nil {
		return
	}
	userID := conn.Client.UserID
	h.logger.Printf("hub: registering connection for user=%s", userID)
	h.mu.Lock()
	if h.connections[userID] == nil {
		h.connections[userID] = map[*session.Connection]struct{}{}
	}
	h.connections[userID][conn] = struct{}{}
	h.mu.Unlock()

	if h.presence != nil {
		_ = h.presence.Register(userID)
	}
	if h.metrics != nil {
		h.metrics.ConnectionOpened()
	}
}

func (h *Hub) unregisterConnection(conn *session.Connection) {
	if conn == nil || conn.Client == nil {
		return
	}
	userID := conn.Client.UserID
	h.mu.Lock()
	if set, ok := h.connections[userID]; ok {
		delete(set, conn)
		if len(set) == 0 {
			delete(h.connections, userID)
		}
	}
	h.mu.Unlock()

	if h.presence != nil {
		_ = h.presence.Remove(userID)
	}
	if h.metrics != nil {
		h.metrics.ConnectionClosed()
	}
}

func (h *Hub) Dispatch(recipientID string, payload []byte) {
	h.dispatch <- dispatchJob{recipientID: recipientID, payload: payload}
}

func (h *Hub) Send(recipientID string, payload []byte) bool {
	return h.deliver(recipientID, payload)
}

func (h *Hub) IsOnline(userID string) bool {
	h.mu.RLock()
	defer h.mu.RUnlock()
	_, ok := h.connections[userID]
	return ok
}

func (h *Hub) IsLocallyPresent(userID string) bool {
	return h.IsOnline(userID)
}

func (h *Hub) RefreshPresence(userID string) {
	if h.presence == nil || userID == "" {
		return
	}
	_ = h.presence.Refresh(userID)
}

func (h *Hub) CloseUser(userID string) {
	h.mu.Lock()
	set, ok := h.connections[userID]
	if !ok {
		h.mu.Unlock()
		return
	}
	delete(h.connections, userID)
	conns := make([]*session.Connection, 0, len(set))
	for c := range set {
		conns = append(conns, c)
	}
	h.mu.Unlock()
	for _, c := range conns {
		c.Teardown()
	}
}

func (h *Hub) HandleRemotePresence(event presence.Event) error {
	if event.Type != "connected" || event.UserID == "" {
		return nil
	}
	h.CloseUser(event.UserID)
	return nil
}

func (h *Hub) closeAll() {
	h.mu.Lock()
	all := make([]*session.Connection, 0)
	for _, set := range h.connections {
		for c := range set {
			all = append(all, c)
		}
	}
	h.connections = make(map[string]map[*session.Connection]struct{})
	h.mu.Unlock()
	for _, c := range all {
		c.Teardown()
	}
}

func (h *Hub) deliver(recipientID string, payload []byte) bool {
	h.mu.RLock()
	set, ok := h.connections[recipientID]
	if !ok || len(set) == 0 {
		h.mu.RUnlock()
		return false
	}
	// Note: Online delivery uses empty ID because we don't have the DB ID easily available here
	// and we want the client to process it as a live message.
	// If the message is already in DB (from MessageDeliveryService), the client will
	// eventually get it via PendingDelivery if this live delivery fails.
	wrapped, err := protocol.WrapEnvelope(payload, "")
	if err != nil {
		h.mu.RUnlock()
		return false
	}
	conns := make([]*session.Connection, 0, len(set))
	for c := range set {
		conns = append(conns, c)
	}
	h.mu.RUnlock()

	delivered := false
	for _, c := range conns {
		if c.Enqueue(wrapped) {
			delivered = true
		}
	}
	if delivered && h.metrics != nil {
		h.metrics.MessageDispatched()
	}
	return delivered
}

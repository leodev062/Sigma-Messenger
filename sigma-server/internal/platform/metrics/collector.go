package metrics

import (
	"sync"
	"sync/atomic"
	"time"
)

// Snapshot is a point-in-time view of server metrics.
type Snapshot struct {
	WebSocket WebSocketMetrics `json:"websocket"`
}

type WebSocketMetrics struct {
	ActiveConnections      int64 `json:"active_connections"`
	MessagesDispatchedTotal uint64 `json:"messages_dispatched_total"`
	MessagesPerMinute      uint64 `json:"messages_per_minute"`
}

// Collector tracks runtime counters for observability.
type Collector struct {
	activeConnections       atomic.Int64
	messagesDispatchedTotal atomic.Uint64
	messagesPerMinute       atomic.Uint64

	mu          sync.Mutex
	windowStart time.Time
	windowCount uint64
}

func NewCollector() *Collector {
	c := &Collector{windowStart: time.Now()}
	go c.rotateWindow()
	return c
}

func (c *Collector) rotateWindow() {
	ticker := time.NewTicker(time.Minute)
	defer ticker.Stop()
	for range ticker.C {
		c.mu.Lock()
		c.messagesPerMinute.Store(c.windowCount)
		c.windowCount = 0
		c.windowStart = time.Now()
		c.mu.Unlock()
	}
}

func (c *Collector) ConnectionOpened() {
	c.activeConnections.Add(1)
}

func (c *Collector) ConnectionClosed() {
	c.activeConnections.Add(-1)
}

func (c *Collector) MessageDispatched() {
	c.messagesDispatchedTotal.Add(1)
	c.mu.Lock()
	c.windowCount++
	c.mu.Unlock()
}

func (c *Collector) Snapshot() Snapshot {
	return Snapshot{
		WebSocket: WebSocketMetrics{
			ActiveConnections:       c.activeConnections.Load(),
			MessagesDispatchedTotal: c.messagesDispatchedTotal.Load(),
			MessagesPerMinute:       c.messagesPerMinute.Load(),
		},
	}
}

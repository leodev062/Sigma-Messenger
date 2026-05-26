package websocket

import (
	"log"
	"sync"

	"sigma-server/ui/sigma/presence"
)

type websocketDispatch struct {
	recipientID string
	payload     []byte
}

type WebsocketConnectionManager struct {
	mu               sync.RWMutex
	connections      map[string]map[*WebsocketConnection]struct{}
	register         chan *WebsocketConnection
	unregister       chan *WebsocketConnection
	dispatch         chan websocketDispatch
	OnOfflineMessage func(recipientID string, message []byte)
	logger           *log.Logger
	presence         *presence.Coordinator
}

func NewWebsocketConnectionManager() *WebsocketConnectionManager {
	return &WebsocketConnectionManager{
		connections: make(map[string]map[*WebsocketConnection]struct{}),
		register:    make(chan *WebsocketConnection),
		unregister:  make(chan *WebsocketConnection),
		dispatch:    make(chan websocketDispatch),
		logger:      log.Default(),
	}
}

func (m *WebsocketConnectionManager) SetPresenceCoordinator(coordinator *presence.Coordinator) {
	m.presence = coordinator
}

func (m *WebsocketConnectionManager) Run() {
	for {
		select {
		case connection := <-m.register:
			if connection == nil || connection.Client == nil {
				continue
			}

			m.mu.Lock()
			if m.connections[connection.Client.UserID] == nil {
				m.connections[connection.Client.UserID] = map[*WebsocketConnection]struct{}{}
			}
			m.connections[connection.Client.UserID][connection] = struct{}{}
			m.mu.Unlock()

			if m.presence != nil {
				if err := m.presence.Register(connection.Client.UserID); err != nil {
					m.logger.Printf("WebsocketConnectionManager failed to register presence user=%s: %v", connection.Client.UserID, err)
				}
			}

			m.logger.Printf("WebsocketConnectionManager registered connection=%s", connection.Client.UserID)

		case connection := <-m.unregister:
			if connection == nil || connection.Client == nil {
				continue
			}

			m.mu.Lock()
			if set, ok := m.connections[connection.Client.UserID]; ok {
				delete(set, connection)
				if len(set) == 0 {
					delete(m.connections, connection.Client.UserID)
				}
			}
			m.mu.Unlock()

			if m.presence != nil {
				if err := m.presence.Remove(connection.Client.UserID); err != nil {
					m.logger.Printf("WebsocketConnectionManager failed to remove presence user=%s: %v", connection.Client.UserID, err)
				}
			}

			connection.closeConnection()
			m.logger.Printf("WebsocketConnectionManager unregistered connection=%s", connection.Client.UserID)

		case dispatch := <-m.dispatch:
			if m.sendToConnections(dispatch.recipientID, dispatch.payload) {
				m.logger.Printf("WebsocketConnectionManager dispatched message recipient=%s", dispatch.recipientID)
				continue
			}

			if m.OnOfflineMessage != nil {
				m.OnOfflineMessage(dispatch.recipientID, dispatch.payload)
				m.logger.Printf("WebsocketConnectionManager queued offline recipient=%s", dispatch.recipientID)
				continue
			}

			m.logger.Printf("WebsocketConnectionManager missing recipient and no offline callback recipient=%s", dispatch.recipientID)
		}
	}
}

func (m *WebsocketConnectionManager) RegisterConnection(connection *WebsocketConnection) {
	m.register <- connection
}

func (m *WebsocketConnectionManager) UnregisterConnection(connection *WebsocketConnection) {
	m.unregister <- connection
}

func (m *WebsocketConnectionManager) Dispatch(recipientID string, payload []byte) {
	m.dispatch <- websocketDispatch{recipientID: recipientID, payload: payload}
}

func (m *WebsocketConnectionManager) Send(recipientID string, payload []byte) bool {
	return m.sendToConnections(recipientID, payload)
}

func (m *WebsocketConnectionManager) IsOnline(userID string) bool {
	m.mu.RLock()
	defer m.mu.RUnlock()
	_, ok := m.connections[userID]
	return ok
}

func (m *WebsocketConnectionManager) IsLocallyPresent(userID string) bool {
	return m.IsOnline(userID)
}

func (m *WebsocketConnectionManager) RefreshPresence(userID string) {
	if m.presence == nil || userID == "" {
		return
	}

	if err := m.presence.Refresh(userID); err != nil {
		m.logger.Printf("WebsocketConnectionManager failed to refresh presence user=%s: %v", userID, err)
	}
}

func (m *WebsocketConnectionManager) CloseUser(userID string) {
	if userID == "" {
		return
	}

	m.mu.Lock()
	set, ok := m.connections[userID]
	if !ok || len(set) == 0 {
		m.mu.Unlock()
		return
	}
	delete(m.connections, userID)
	connections := make([]*WebsocketConnection, 0, len(set))
	for connection := range set {
		connections = append(connections, connection)
	}
	m.mu.Unlock()

	for _, connection := range connections {
		if connection != nil {
			connection.Close()
		}
	}
}

func (m *WebsocketConnectionManager) HandleRemotePresence(event presence.Event) error {
	if event.Type != "connected" || event.UserID == "" {
		return nil
	}

	m.CloseUser(event.UserID)
	return nil
}

func (m *WebsocketConnectionManager) sendToConnections(recipientID string, payload []byte) bool {
	m.mu.RLock()
	set, ok := m.connections[recipientID]
	if !ok || len(set) == 0 {
		m.mu.RUnlock()
		return false
	}

	connections := make([]*WebsocketConnection, 0, len(set))
	for connection := range set {
		connections = append(connections, connection)
	}
	m.mu.RUnlock()

	delivered := false
	for _, connection := range connections {
		if connection == nil {
			continue
		}
		select {
		case connection.Send <- payload:
			delivered = true
		default:
			m.logger.Printf("WebsocketConnectionManager send buffer full recipient=%s", recipientID)
			connection.Close()
		}
	}

	return delivered
}

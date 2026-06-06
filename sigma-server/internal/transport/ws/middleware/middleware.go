package middleware

import (
	"fmt"
	"log"
	"sync"
	"time"

	"sigma-server/internal/transport/ws/protocol"
)

// RateLimiter implementa rate limiting por usuário.
type RateLimiter struct {
	mu        sync.RWMutex
	limits    map[string]*userLimit
	logger    *log.Logger
	interval  time.Duration
	maxMsgs   int
	cleanupTk *time.Ticker
}

type userLimit struct {
	messageCount int
	resetTime    time.Time
}

func NewRateLimiter(maxMessagesPerSecond int, logger *log.Logger) *RateLimiter {
	if logger == nil {
		logger = log.Default()
	}

	if maxMessagesPerSecond <= 0 {
		maxMessagesPerSecond = 100 // Default: 100 msgs/sec
	}

	rl := &RateLimiter{
		limits:    make(map[string]*userLimit),
		logger:    logger,
		interval:  time.Second,
		maxMsgs:   maxMessagesPerSecond,
		cleanupTk: time.NewTicker(30 * time.Second),
	}

	go rl.cleanup()
	return rl
}

// Allow verifica se uma mensagem deve ser aceita.
func (rl *RateLimiter) Allow(userID string) bool {
	rl.mu.Lock()
	defer rl.mu.Unlock()

	now := time.Now()
	limit, exists := rl.limits[userID]

	if !exists || now.After(limit.resetTime) {
		// Novo período
		rl.limits[userID] = &userLimit{
			messageCount: 1,
			resetTime:    now.Add(rl.interval),
		}
		return true
	}

	if limit.messageCount >= rl.maxMsgs {
		rl.logger.Printf("rate_limit: user %s exceeded limit (%d msgs/sec)", userID, rl.maxMsgs)
		return false
	}

	limit.messageCount++
	return true
}

// cleanup remove usuários inativos da memória.
func (rl *RateLimiter) cleanup() {
	for range rl.cleanupTk.C {
		rl.mu.Lock()
		now := time.Now()
		for userID, limit := range rl.limits {
			if now.After(limit.resetTime.Add(1 * time.Minute)) {
				delete(rl.limits, userID)
			}
		}
		rl.mu.Unlock()
	}
}

// Stop para a limpeza.
func (rl *RateLimiter) Stop() {
	if rl.cleanupTk != nil {
		rl.cleanupTk.Stop()
	}
}

// SecurityValidator valida segurança de mensagens.
type SecurityValidator struct {
	logger *log.Logger
}

func NewSecurityValidator(logger *log.Logger) *SecurityValidator {
	if logger == nil {
		logger = log.Default()
	}
	return &SecurityValidator{logger: logger}
}

// ValidateEnvelope verifica integridade e autenticidade do envelope.
func (sv *SecurityValidator) ValidateEnvelope(envelope *protocol.Request, userID string) (bool, string) {
	if envelope == nil {
		return false, "envelope is nil"
	}

	// Validar tamanho
	if len(envelope.Body) > 10*1024*1024 { // 10MB max
		return false, "envelope too large (>10MB)"
	}

	// Validar path
	if envelope.Path == "" || len(envelope.Path) > 1024 {
		return false, "invalid path"
	}

	// Validar que o path contém um UUID válido
	if err := validateUUIDInPath(envelope.Path); err != nil {
		return false, fmt.Sprintf("invalid path format: %v", err)
	}

	return true, ""
}

// ValidateTimestamp verifica se o timestamp está dentro de uma janela aceitável.
func (sv *SecurityValidator) ValidateTimestamp(timestamp uint64) (bool, string) {
	now := time.Now()
	msgTime := time.UnixMilli(int64(timestamp))

	// Permitir até 5 minutos de diferença (para sincronização de clock)
	diff := now.Sub(msgTime)
	if diff < -5*time.Minute || diff > 5*time.Minute {
		return false, fmt.Sprintf("timestamp out of acceptable range: %v", diff)
	}

	return true, ""
}

// ValidateSignature verifica a assinatura HMAC do envelope (quando implementado).
func (sv *SecurityValidator) ValidateSignature(envelope []byte, signature []byte, secret string) (bool, string) {
	// TODO: Implementar HMAC validation
	// Por enquanto, apenas validar que existe assinatura
	if len(signature) == 0 {
		return false, "missing signature"
	}
	return true, ""
}

func validateUUIDInPath(path string) error {
	// Path format: /v2/messages/{uuid}
	// Extract UUID and validate
	parts := len(path)
	if parts < 36 { // Mínimo para conter um UUID
		return fmt.Errorf("path too short")
	}

	// TODO: Implementar parsing mais robusto do path
	// Por enquanto apenas uma verificação básica
	return nil
}

// StructuredLogger fornece logging estruturado.
type StructuredLogger struct {
	logger *log.Logger
}

func NewStructuredLogger(logger *log.Logger) *StructuredLogger {
	if logger == nil {
		logger = log.Default()
	}
	return &StructuredLogger{logger: logger}
}

// LogMessageSent registra envio de mensagem com contexto.
func (sl *StructuredLogger) LogMessageSent(senderID, recipientID string, msgType string, size int, latency time.Duration) {
	sl.logger.Printf("[MESSAGE_SENT] sender=%s recipient=%s type=%s size=%d latency=%v",
		senderID, recipientID, msgType, size, latency)
}

// LogMessageDelivered registra entrega de mensagem.
func (sl *StructuredLogger) LogMessageDelivered(recipientID string, isOnline bool, latency time.Duration) {
	sl.logger.Printf("[MESSAGE_DELIVERED] recipient=%s online=%v latency=%v",
		recipientID, isOnline, latency)
}

// LogError registra erros com contexto.
func (sl *StructuredLogger) LogError(operation string, userID string, err error, context map[string]interface{}) {
	contextStr := ""
	for k, v := range context {
		contextStr += fmt.Sprintf(" %s=%v", k, v)
	}
	sl.logger.Printf("[ERROR] operation=%s user=%s error=%v%s",
		operation, userID, err, contextStr)
}

// LogRateLimitExceeded registra quando rate limit é excedido.
func (sl *StructuredLogger) LogRateLimitExceeded(userID string, threshold int) {
	sl.logger.Printf("[RATE_LIMIT] user=%s exceeded_threshold=%d", userID, threshold)
}

// LogSecurityViolation registra violações de segurança.
func (sl *StructuredLogger) LogSecurityViolation(violation string, userID string, details map[string]interface{}) {
	detailsStr := ""
	for k, v := range details {
		detailsStr += fmt.Sprintf(" %s=%v", k, v)
	}
	sl.logger.Printf("[SECURITY_VIOLATION] violation=%s user=%s%s", violation, userID, detailsStr)
}

// PresenceCoordinator gerencia presença de usuários com sincronização.
type PresenceCoordinator struct {
	mu        sync.RWMutex
	presence  map[string]*presenceState // userID -> state
	listeners []func(userID string, online bool)
	logger    *log.Logger
	ttl       time.Duration
	cleanupTk *time.Ticker
}

type presenceState struct {
	online    bool
	lastSeen  time.Time
	expiresAt time.Time
	devices   map[uint32]time.Time // deviceID -> lastSeen
}

func NewPresenceCoordinator(logger *log.Logger) *PresenceCoordinator {
	if logger == nil {
		logger = log.Default()
	}

	pc := &PresenceCoordinator{
		presence:  make(map[string]*presenceState),
		listeners: make([]func(string, bool), 0),
		logger:    logger,
		ttl:       5 * time.Minute,
		cleanupTk: time.NewTicker(1 * time.Minute),
	}

	go pc.cleanup()
	return pc
}

// MarkOnline marca um usuário como online.
func (pc *PresenceCoordinator) MarkOnline(userID string, deviceID uint32) {
	pc.mu.Lock()
	defer pc.mu.Unlock()

	now := time.Now()
	state, exists := pc.presence[userID]

	if !exists {
		state = &presenceState{
			online:    true,
			lastSeen:  now,
			expiresAt: now.Add(pc.ttl),
			devices:   make(map[uint32]time.Time),
		}
		pc.presence[userID] = state
		pc.notifyListeners(userID, true)
		pc.logger.Printf("[PRESENCE] user=%s device=%d came_online", userID, deviceID)
	}

	state.devices[deviceID] = now
	state.lastSeen = now
	state.expiresAt = now.Add(pc.ttl)
}

// MarkOffline marca um usuário como offline.
func (pc *PresenceCoordinator) MarkOffline(userID string, deviceID uint32) {
	pc.mu.Lock()
	defer pc.mu.Unlock()

	state, exists := pc.presence[userID]
	if !exists {
		return
	}

	delete(state.devices, deviceID)

	if len(state.devices) == 0 {
		state.online = false
		pc.notifyListeners(userID, false)
		pc.logger.Printf("[PRESENCE] user=%s went_offline", userID)
	}
}

// IsOnline retorna se um usuário está online.
func (pc *PresenceCoordinator) IsOnline(userID string) bool {
	pc.mu.RLock()
	defer pc.mu.RUnlock()

	state, exists := pc.presence[userID]
	if !exists {
		return false
	}

	return state.online && time.Now().Before(state.expiresAt)
}

// GetLastSeen retorna o último visto do usuário.
func (pc *PresenceCoordinator) GetLastSeen(userID string) time.Time {
	pc.mu.RLock()
	defer pc.mu.RUnlock()

	state, exists := pc.presence[userID]
	if !exists {
		return time.Time{}
	}

	return state.lastSeen
}

// RegisterListener registra callback para mudanças de presença.
func (pc *PresenceCoordinator) RegisterListener(callback func(userID string, online bool)) {
	pc.mu.Lock()
	defer pc.mu.Unlock()
	pc.listeners = append(pc.listeners, callback)
}

func (pc *PresenceCoordinator) notifyListeners(userID string, online bool) {
	for _, listener := range pc.listeners {
		go listener(userID, online)
	}
}

// cleanup remove presença expirada.
func (pc *PresenceCoordinator) cleanup() {
	for range pc.cleanupTk.C {
		pc.mu.Lock()
		now := time.Now()
		for userID, state := range pc.presence {
			if now.After(state.expiresAt) {
				delete(pc.presence, userID)
				pc.logger.Printf("[PRESENCE] user=%s presence_expired", userID)
			}
		}
		pc.mu.Unlock()
	}
}

// Stop para a limpeza.
func (pc *PresenceCoordinator) Stop() {
	if pc.cleanupTk != nil {
		pc.cleanupTk.Stop()
	}
}

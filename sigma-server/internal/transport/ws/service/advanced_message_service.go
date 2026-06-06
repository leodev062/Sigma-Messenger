package service

import (
	"context"
	"log"
	"sync"
	"time"

	"sigma-server/internal/transport/ws/ports"

	"github.com/google/uuid"
	"google.golang.org/protobuf/proto"

	sigmapb "sigma-server/proto"
)

// ReceiptService processa e roteia recibos de mensagens.
type ReceiptService struct {
	dispatcher ports.OutboundDispatcher
	logger     *log.Logger
}

func NewReceiptService(dispatcher ports.OutboundDispatcher, logger *log.Logger) *ReceiptService {
	if logger == nil {
		logger = log.Default()
	}
	return &ReceiptService{
		dispatcher: dispatcher,
		logger:     logger,
	}
}

// HandleReceipt processa um ReceiptMessage recebido.
func (s *ReceiptService) HandleReceipt(ctx context.Context, receipt *sigmapb.ReceiptMessage, senderID string) error {
	if receipt == nil || receipt.SenderId == "" {
		return nil
	}

	// Rotear recibo de volta para quem enviou a mensagem original
	envelope := &sigmapb.Envelope{
		Type:      sigmapb.Envelope_RECEIPT,
		Source:    senderID,
		Timestamp: uint64(time.Now().UnixMilli()),
		Content:   nil, // Recibos não vão criptografados
	}

	payload, err := proto.Marshal(envelope)
	if err != nil {
		s.logger.Printf("receipt service: failed to marshal receipt envelope: %v", err)
		return err
	}

	if s.dispatcher != nil {
		if err := s.dispatcher.Dispatch(senderID, receipt.SenderId, payload); err != nil {
			s.logger.Printf("receipt service: failed to dispatch receipt to=%s: %v", receipt.SenderId, err)
			return err
		}
	}

	s.logger.Printf("receipt service: receipt %v sent from=%s to=%s", receipt.Type, senderID, receipt.SenderId)
	return nil
}

// TypingService gerencia indicadores de digitação.
type TypingService struct {
	mu            sync.RWMutex
	activeTypers  map[string]map[string]*typingState // map[recipientID][senderID]state
	dispatcher    ports.OutboundDispatcher
	logger        *log.Logger
	typingTimeout time.Duration
	cleanupTicker *time.Ticker
}

type typingState struct {
	startedAt time.Time
	chatID    string
}

func NewTypingService(dispatcher ports.OutboundDispatcher, logger *log.Logger) *TypingService {
	if logger == nil {
		logger = log.Default()
	}

	s := &TypingService{
		activeTypers:  make(map[string]map[string]*typingState),
		dispatcher:    dispatcher,
		logger:        logger,
		typingTimeout: 5 * time.Second,
		cleanupTicker: time.NewTicker(2 * time.Second),
	}

	go s.cleanupExpiredTyping()
	return s
}

// HandleTyping processa um indicador de digitação.
func (s *TypingService) HandleTyping(ctx context.Context, typing *sigmapb.TypingMessage, senderID, recipientID string) error {
	if typing == nil {
		return nil
	}

	s.mu.Lock()
	defer s.mu.Unlock()

	if typing.State == sigmapb.TypingMessage_STARTED {
		// Registrar novo typer
		if s.activeTypers[recipientID] == nil {
			s.activeTypers[recipientID] = make(map[string]*typingState)
		}
		s.activeTypers[recipientID][senderID] = &typingState{
			startedAt: time.Now(),
			chatID:    recipientID,
		}
		s.logger.Printf("typing service: user %s started typing to %s", senderID, recipientID)
	} else {
		// Remover typer
		if s.activeTypers[recipientID] != nil {
			delete(s.activeTypers[recipientID], senderID)
		}
		s.logger.Printf("typing service: user %s stopped typing to %s", senderID, recipientID)
	}

	// Retransmitir para destinatário
	envelope := &sigmapb.Envelope{
		Type:      sigmapb.Envelope_TYPING,
		Source:    senderID,
		Timestamp: uint64(time.Now().UnixMilli()),
		Content:   nil,
	}

	payload, err := proto.Marshal(envelope)
	if err != nil {
		return err
	}

	if s.dispatcher != nil {
		_ = s.dispatcher.Dispatch(senderID, recipientID, payload)
	}

	return nil
}

// IsUserTyping verifica se um usuário está digitando para outro.
func (s *TypingService) IsUserTyping(recipientID, senderID string) bool {
	s.mu.RLock()
	defer s.mu.RUnlock()

	if states, ok := s.activeTypers[recipientID]; ok {
		if state, exists := states[senderID]; exists {
			// Verificar se não expirou
			if time.Since(state.startedAt) < s.typingTimeout {
				return true
			}
		}
	}
	return false
}

// cleanupExpiredTyping remove typing indicators que expiraram.
func (s *TypingService) cleanupExpiredTyping() {
	for range s.cleanupTicker.C {
		s.mu.Lock()
		now := time.Now()
		for recipientID, typers := range s.activeTypers {
			for senderID, state := range typers {
				if now.Sub(state.startedAt) > s.typingTimeout {
					delete(typers, senderID)
				}
			}
			if len(typers) == 0 {
				delete(s.activeTypers, recipientID)
			}
		}
		s.mu.Unlock()
	}
}

// Stop para a TypingService.
func (s *TypingService) Stop() {
	if s.cleanupTicker != nil {
		s.cleanupTicker.Stop()
	}
}

// SyncService gerencia sincronização de status de mensagens.
type SyncService struct {
	dispatcher ports.OutboundDispatcher
	logger     *log.Logger
}

func NewSyncService(dispatcher ports.OutboundDispatcher, logger *log.Logger) *SyncService {
	if logger == nil {
		logger = log.Default()
	}
	return &SyncService{
		dispatcher: dispatcher,
		logger:     logger,
	}
}

// HandleSync processa uma SyncMessage.
func (s *SyncService) HandleSync(ctx context.Context, sync *sigmapb.SyncMessage, senderID string) error {
	if sync == nil {
		return nil
	}

	s.logger.Printf("sync service: received sync type=%v message=%s from=%s", sync.Type, sync.MessageId, senderID)

	// Se for múltiplos targets (grupo), rotear para cada um
	if len(sync.TargetIds) > 0 {
		for _, targetID := range sync.TargetIds {
			if targetID == senderID {
				continue // Não enviar para si mesmo
			}
			s.syncToTarget(ctx, sync, senderID, targetID)
		}
	}

	return nil
}

func (s *SyncService) syncToTarget(ctx context.Context, sync *sigmapb.SyncMessage, senderID, targetID string) error {
	envelope := &sigmapb.Envelope{
		Type:      sigmapb.Envelope_SYNC_MESSAGE,
		Source:    senderID,
		Timestamp: uint64(time.Now().UnixMilli()),
	}

	// Encapsular sync em Content
	content := &sigmapb.Content{
		Content: &sigmapb.Content_Sync{Sync: sync},
	}

	contentBytes, err := proto.Marshal(content)
	if err != nil {
		s.logger.Printf("sync service: failed to marshal content: %v", err)
		return err
	}
	envelope.Content = contentBytes

	payload, err := proto.Marshal(envelope)
	if err != nil {
		s.logger.Printf("sync service: failed to marshal envelope: %v", err)
		return err
	}

	if s.dispatcher != nil {
		if err := s.dispatcher.Dispatch(senderID, targetID, payload); err != nil {
			s.logger.Printf("sync service: failed to dispatch sync to=%s: %v", targetID, err)
			return err
		}
	}

	return nil
}

// GroupPermissionValidator valida permissões de grupo.
type GroupPermissionValidator struct {
	logger *log.Logger
	// Aqui você adicionaria um repository para consultar membros do grupo
}

func NewGroupPermissionValidator(logger *log.Logger) *GroupPermissionValidator {
	if logger == nil {
		logger = log.Default()
	}
	return &GroupPermissionValidator{logger: logger}
}

// CanUserSendToGroup verifica se um usuário pode enviar para um grupo.
func (v *GroupPermissionValidator) CanUserSendToGroup(userID uuid.UUID, groupID uuid.UUID) bool {
	// TODO: Implementar consulta ao repository
	// Por enquanto, todos podem enviar
	return true
}

// RetryManager gerencia retry de mensagens com backoff exponencial.
type RetryManager struct {
	mu      sync.RWMutex
	retries map[string]*retryState
	logger  *log.Logger
}

type retryState struct {
	attempts      int
	lastAttempt   time.Time
	nextRetryTime time.Time
	maxAttempts   int
}

func NewRetryManager(logger *log.Logger) *RetryManager {
	if logger == nil {
		logger = log.Default()
	}
	return &RetryManager{
		retries: make(map[string]*retryState),
		logger:  logger,
	}
}

// ShouldRetry verifica se deve fazer retry e calcula tempo.
func (r *RetryManager) ShouldRetry(messageID string) (shouldRetry bool, nextRetryTime time.Time) {
	r.mu.Lock()
	defer r.mu.Unlock()

	state, exists := r.retries[messageID]
	if !exists {
		// Primeira tentativa
		state = &retryState{
			attempts:    0,
			maxAttempts: 5,
		}
		r.retries[messageID] = state
	}

	state.attempts++

	if state.attempts > state.maxAttempts {
		delete(r.retries, messageID)
		return false, time.Time{}
	}

	// Exponential backoff: 1s, 2s, 4s, 8s, 16s
	backoffDuration := time.Duration(1<<uint(state.attempts-1)) * time.Second
	nextRetry := time.Now().Add(backoffDuration)

	state.nextRetryTime = nextRetry
	state.lastAttempt = time.Now()

	r.logger.Printf("retry manager: scheduling retry for %s (attempt %d/%d) at %v",
		messageID, state.attempts, state.maxAttempts, nextRetry)

	return true, nextRetry
}

// MarkSuccess remove a mensagem da fila de retry.
func (r *RetryManager) MarkSuccess(messageID string) {
	r.mu.Lock()
	defer r.mu.Unlock()
	delete(r.retries, messageID)
}

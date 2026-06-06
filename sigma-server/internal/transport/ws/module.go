package ws

import (
	"log"

	"sigma-server/internal/auth"
	"sigma-server/internal/config"
	"sigma-server/internal/platform/metrics"
	"sigma-server/internal/repository/storage"
	services "sigma-server/internal/service"
	"sigma-server/internal/transport/ws/adapters"
	wsconfig "sigma-server/internal/transport/ws/config"
	"sigma-server/internal/transport/ws/handler"
	"sigma-server/internal/transport/ws/hub"
	"sigma-server/internal/transport/ws/middleware"
	"sigma-server/internal/transport/ws/router"
	"sigma-server/internal/transport/ws/security"
	wsservice "sigma-server/internal/transport/ws/service"
	"sigma-server/internal/transport/ws/session"
)

// Module wires the websocket transport stack.
type Module struct {
	Hub         *hub.Hub
	HTTPHandler *handler.HTTPHandler
}

// Dependencies required to build the websocket module.
type Dependencies struct {
	ServerConfig         config.ServerConfiguration
	JWT                  *auth.JwtGenerator
	MessageManager       *storage.MessageManager
	PendingEventManager  *storage.PendingEventManager
	AccountService       *services.AccountService
	MessageDispatcher    session.OutboundDispatcher
	DeviceSessionManager *storage.DeviceSessionManager
	Metrics              *metrics.Collector
}

func NewModule(h *hub.Hub, deps Dependencies) *Module {
	hubCfg := wsconfig.FromServer(deps.ServerConfig)
	if h == nil {
		h = hub.New(hubCfg)
	}
	if deps.Metrics != nil {
		h.SetMetrics(deps.Metrics)
	}

	msgStore := &adapters.MessageStore{MessageManager: deps.MessageManager}
	eventStore := &adapters.EventStore{PendingEventManager: deps.PendingEventManager}
	keysReader := &adapters.AccountKeys{AccountService: deps.AccountService}

	// Criar instâncias de middleware
	logger := log.Default()
	rateLimiter := middleware.NewRateLimiter(100, logger)
	presenceCoordinator := middleware.NewPresenceCoordinator(logger)

	// Criar router com dispatcher e logger
	messageRouter := router.New(msgStore, keysReader, deps.MessageDispatcher, logger)

	// Criar e injetar serviços no router
	receiptService := wsservice.NewReceiptService(deps.MessageDispatcher, logger)
	typingService := wsservice.NewTypingService(deps.MessageDispatcher, logger)
	syncService := wsservice.NewSyncService(deps.MessageDispatcher, logger)
	messageRouter.SetReceiptHandler(receiptService)
	messageRouter.SetTypingHandler(typingService)
	messageRouter.SetSyncHandler(syncService)

	pending := wsservice.NewPendingDelivery(msgStore, eventStore, log.Default())
	connAuth := wsservice.NewConnectionAuth(deps.JWT, hubCfg)
	originChecker := security.NewOriginChecker(hubCfg.AllowedOrigins)

	return &Module{
		Hub: h,
		HTTPHandler: handler.NewHTTPHandler(
			h,
			pending,
			connAuth,
			messageRouter,
			deps.MessageDispatcher,
			originChecker,
			deps.DeviceSessionManager,
			rateLimiter,
			presenceCoordinator,
		),
	}
}

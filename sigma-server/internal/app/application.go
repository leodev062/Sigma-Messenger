package app

import (
	"context"
	"log"

	"sigma-server/internal/auth"
	bizmessage "sigma-server/internal/business/message"
	"sigma-server/internal/config"
	"sigma-server/internal/delivery"
	"sigma-server/internal/events"
	wsconfig "sigma-server/internal/transport/ws/config"
	"sigma-server/internal/transport/ws/hub"
	"sigma-server/internal/platform/metrics"
	"sigma-server/internal/platform/presence"
	"sigma-server/internal/platform/pubsub"
	platformbotapi "sigma-server/internal/platform/botapi"
	"sigma-server/internal/platform/push"
	"sigma-server/internal/platform/telephony"
	"sigma-server/internal/registration"
	"sigma-server/internal/repository/storage"
	"sigma-server/internal/service"
	"sigma-server/internal/transport/ws"

	"github.com/google/uuid"
	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
)

// Application holds wired dependencies for HTTP, WebSocket, and background workers.
type Application struct {
	Config *config.WhisperServerConfiguration
	DB     *gorm.DB

	AccountManager         *storage.AccountManager
	UserManager            *storage.UserManager
	ChatManager            *storage.ChatManager
	MessageManager         *storage.MessageManager
	EnvelopeManager        *storage.EnvelopeManager
	MessageReactionManager *storage.MessageReactionManager
	PendingEventManager    *storage.PendingEventManager
	DeviceSessionManager   *storage.DeviceSessionManager

	JWT                    *auth.JwtGenerator
	AuthService            *services.AuthService
	AccountService         *services.AccountService
	DirectoryService       *services.DirectoryService
	ProfileService         *services.ProfileService
	MessageReactionService *services.MessageReactionService
	PaymentService         *services.PaymentService
	RegistrationService    *services.RegistrationService
	BotFatherService       *services.BotFatherService
	BotAPIService          *services.BotAPIService
	BotService             *services.BotService
	MessageDispatchService *services.MessageDispatchService

	EventRouter *events.Router
	Metrics     *metrics.Collector
	WS          *ws.Module

	PresenceCoordinator *presence.Coordinator
	EventHub            *pubsub.RedisEventHub
	RegistrationClient  *registration.RegistrationServiceClient

	Echo *echo.Echo

	botFatherID  uuid.UUID
	messageRouter *bizmessage.Router
	closes        []func() error
}

func NewApplication(cfg *config.WhisperServerConfiguration) (*Application, error) {
	dbConn, err := storage.NewDatabaseFactory(cfg.Database)
	if err != nil {
		return nil, err
	}

	app := &Application{
		Config: cfg,
		DB:     dbConn,
	}

	app.AccountManager = storage.NewAccountManager(dbConn)
	app.UserManager = storage.NewUserManager(dbConn)
	app.ChatManager = storage.NewChatManager(dbConn)
	app.MessageManager = storage.NewMessageManager(dbConn)
	app.EnvelopeManager = storage.NewEnvelopeManager(dbConn)
	app.MessageReactionManager = storage.NewMessageReactionManager(dbConn)
	app.PendingEventManager = storage.NewPendingEventManager(dbConn)
	app.DeviceSessionManager = storage.NewDeviceSessionManager(dbConn)

	pushManager := push.NewPushManager(cfg.Push.FirebaseServiceAccountPath)
	pushManager.InitFirebase()

	telephonyManager := telephony.NewTelephonyManager(cfg.Telephony)
	app.JWT = auth.NewJwtGenerator(cfg.Auth.JWTSecret)
	phoneVerificationManager := auth.NewPhoneVerificationManager(telephonyManager)

	app.Metrics = metrics.NewCollector()

	if err := app.initRegistrationClient(telephonyManager); err != nil {
		return nil, err
	}

	app.AuthService = services.NewAuthService(app.AccountManager, app.UserManager, app.DeviceSessionManager, app.JWT, phoneVerificationManager)
	app.AccountService = services.NewAccountService(app.AccountManager)
	app.DirectoryService = services.NewDirectoryService(app.UserManager)
	app.ProfileService = services.NewProfileService(app.UserManager)
	app.MessageReactionService = services.NewMessageReactionService(app.MessageReactionManager)
	app.PaymentService = services.NewPaymentService(telephonyManager, cfg.Payment.MercadoPagoAccessToken)
	app.RegistrationService = services.NewRegistrationService(
		app.AccountManager,
		app.UserManager,
		app.MessageManager,
		app.DeviceSessionManager,
		app.RegistrationClient,
		telephonyManager,
		app.JWT,
	)

	if err := app.initMessaging(pushManager); err != nil {
		return nil, err
	}

	wsHub := hub.New(wsconfig.FromServer(cfg.Server))
	app.wireRealtimeMessaging(wsHub, pushManager)

	app.WS = ws.NewModule(wsHub, ws.Dependencies{
		ServerConfig:        cfg.Server,
		JWT:                 app.JWT,
		MessageManager:      app.MessageManager,
		EnvelopeManager:     app.EnvelopeManager,
		PendingEventManager: app.PendingEventManager,
		AccountService:      app.AccountService,
		MessageDispatcher:   app.MessageDispatchService,
		DeviceSessionManager: app.DeviceSessionManager,
		Metrics:             app.Metrics,
	})

	if err := app.initRedis(pushManager); err != nil {
		return nil, err
	}

	app.Echo = echo.New()
	registerHTTPRoutes(app)

	return app, nil
}

func (a *Application) initMessaging(pushManager *push.PushManager) error {
	botRepo := storage.NewBotRepository(a.DB)
	botsCfg := a.Config.Bots.Resolved()

	a.BotFatherService = services.NewBotFatherService(botRepo, a.AccountManager)
	botFather, err := a.BotFatherService.Ensure(botsCfg.BotFatherUsername, botsCfg.BotFatherName)
	if err != nil {
		return err
	}

	a.botFatherID, _ = uuid.Parse(botFather.ID)

	recipientReader := storage.NewRecipientReader(a.AccountManager, a.ChatManager)
	a.messageRouter = bizmessage.NewRouter(recipientReader)
	return nil
}

func (a *Application) wireRealtimeMessaging(wsHub *hub.Hub, pushManager *push.PushManager) {
	presenceService := delivery.NewPresenceService(wsHub)
	messageDelivery := delivery.NewMessageDeliveryService(
		presenceService,
		a.EnvelopeManager,
		a.AccountManager,
		pushManager,
		log.Default(),
	)
	offline := delivery.NewOfflineDeliveryAdapter(messageDelivery)

	botRepo := storage.NewBotRepository(a.DB)
	botsCfg := a.Config.Bots.Resolved()
	webhookStore := storage.NewBotWebhookStore(a.DB)
	updateStore := storage.NewBotUpdateStore(a.DB)

	a.BotAPIService = services.NewBotAPIService(
		botRepo,
		webhookStore,
		updateStore,
		a.AccountManager,
		wsHub,
		offline,
		platformbotapi.NewWebhookClient(),
		botsCfg.AllowInsecureWebhook,
		log.Default(),
	)

	a.BotService = services.NewBotService(
		botRepo,
		a.BotFatherService,
		a.BotAPIService,
		wsHub,
		offline,
		a.botFatherID,
		botsCfg.APIPublicBaseURL,
	)

	a.MessageDispatchService = services.NewMessageDispatchService(
		a.messageRouter,
		wsHub,
		offline,
		a.BotService,
		log.Default(),
	)

	wsHub.OnOfflineMessage = func(recipientID, destinationType string, message []byte) {
		if err := messageDelivery.Deliver(recipientID, destinationType, message); err != nil {
			log.Printf("Failed to persist offline websocket message recipient=%s: %v", recipientID, err)
		}
	}
}

func (a *Application) initRedis(pushManager *push.PushManager) error {
	presenceService := delivery.NewPresenceService(a.WS.Hub)
	eventDelivery := delivery.NewEventDeliveryService(
		presenceService,
		a.PendingEventManager,
		a.AccountManager,
		pushManager,
		log.Default(),
	)

	a.EventRouter = events.NewRouterWithDelivery(eventDelivery, nil, a.ChatManager)

	if len(a.Config.Redis.Addresses) == 0 {
		return nil
	}

	var err error
	a.PresenceCoordinator, err = presence.NewCoordinator(a.Config.Redis, func(event presence.Event) {
		if handleErr := a.WS.Hub.HandleRemotePresence(event); handleErr != nil {
			log.Printf("Failed to handle remote presence: %v", handleErr)
		}
	})
	if err != nil {
		log.Printf("Failed to initialize presence coordinator: %v", err)
	} else {
		a.WS.Hub.SetPresenceCoordinator(a.PresenceCoordinator)
		a.closes = append(a.closes, a.PresenceCoordinator.Close)
	}

	rc, err := pubsub.NewRedisEventHub(a.Config.Redis, func(event events.EventEnvelope) {
		if handleErr := a.EventRouter.HandleRemote(context.Background(), event); handleErr != nil {
			log.Printf("Failed to handle remote event: %v", handleErr)
		}
	})
	if err != nil {
		log.Printf("Failed to initialize Redis event hub: %v", err)
		return nil
	}

	a.EventHub = rc
	a.EventRouter = events.NewRouterWithDelivery(eventDelivery, rc, a.ChatManager)
	a.closes = append(a.closes, rc.Close)

	return nil
}

func (a *Application) initRegistrationClient(telephonyManager telephony.TelephonyProvider) error {
	registrationClientConfig := &registration.RegistrationServiceClientConfig{
		Host:     "localhost",
		Port:     443,
		Audience: "sigma-server",
	}
	registrationClient, err := registration.NewRegistrationServiceClient(registrationClientConfig)
	if err != nil {
		log.Printf("Failed to initialize registration client: %v", err)
		a.RegistrationClient = nil
		return nil
	}

	a.RegistrationClient = registrationClient
	a.closes = append(a.closes, func() error {
		if a.RegistrationClient != nil {
			a.RegistrationClient.Close()
		}
		return nil
	})
	return nil
}

func (a *Application) Close() error {
	var firstErr error
	for i := len(a.closes) - 1; i >= 0; i-- {
		if err := a.closes[i](); err != nil && firstErr == nil {
			firstErr = err
		}
	}
	return firstErr
}

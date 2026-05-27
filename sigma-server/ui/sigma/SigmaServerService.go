package sigma

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	apiControllers "sigma-server/ui/sigma/api/controllers"
	"sigma-server/ui/sigma/auth"
	"sigma-server/ui/sigma/controllers"
	"sigma-server/ui/sigma/delivery"
	"sigma-server/ui/sigma/events"
	"sigma-server/ui/sigma/http/middleware"
	"sigma-server/ui/sigma/presence"
	"sigma-server/ui/sigma/pubsub"
	"sigma-server/ui/sigma/push"
	"sigma-server/ui/sigma/services"
	"sigma-server/ui/sigma/storage"
	"sigma-server/ui/sigma/telephony"
	"sigma-server/ui/sigma/websocket"
	"syscall"
	"time"

	"github.com/labstack/echo/v4"
	echoMiddleware "github.com/labstack/echo/v4/middleware"
)

func SigmaServerService(cfg *WhisperServerConfiguration) {
	dbConn, err := storage.NewDatabaseFactory(cfg.Database)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}

	accountManager := storage.NewAccountManager(dbConn)
	chatManager := storage.NewChatManager(dbConn)
	messageManager := storage.NewMessageManager(dbConn)
	pendingEventManager := storage.NewPendingEventManager(dbConn)

	pushManager := push.NewPushManager(cfg.Push.FirebaseServiceAccountPath)
	pushManager.InitFirebase()
	telephonyManager := telephony.NewTelephonyManager(cfg.Telephony)
	jwtGenerator := auth.NewJwtGenerator(cfg.Auth.JWTSecret)
	phoneVerificationManager := auth.NewPhoneVerificationManager(telephonyManager)

	wsManager := websocket.NewWebsocketConnectionManager()
	presenceCoordinator := (*presence.Coordinator)(nil)
	if len(cfg.Redis.Addresses) > 0 {
		presenceCoordinator, err = presence.NewCoordinator(cfg.Redis, func(event presence.Event) {
			if err := wsManager.HandleRemotePresence(event); err != nil {
				log.Printf("⚠️  Failed to handle remote presence event: %v", err)
			}
		})
		if err != nil {
			log.Printf("⚠️  Failed to initialize presence coordinator: %v", err)
		} else {
			wsManager.SetPresenceCoordinator(presenceCoordinator)
			defer func() {
				if err := presenceCoordinator.Close(); err != nil {
					log.Printf("⚠️  Failed to close presence coordinator: %v", err)
				}
			}()
		}
	}

	presenceService := delivery.NewPresenceService(wsManager)
	messageDelivery := delivery.NewMessageDeliveryService(presenceService, messageManager, accountManager, pushManager, log.Default())
	eventDelivery := delivery.NewEventDeliveryService(presenceService, pendingEventManager, accountManager, pushManager, log.Default())

	wsManager.OnOfflineMessage = func(recipientID string, message []byte) {
		if err := messageDelivery.Deliver(recipientID, message); err != nil {
			log.Printf("⚠️  Failed to persist pending websocket message recipient=%s: %v", recipientID, err)
		}
	}

	go wsManager.Run()

	authService := services.NewAuthService(accountManager, jwtGenerator, phoneVerificationManager)
	accountService := services.NewAccountService(accountManager)
	directoryService := services.NewDirectoryService(accountManager)
	profileService := services.NewProfileService(accountManager)
	paymentService := services.NewPaymentService(telephonyManager, cfg.Payment.MercadoPagoAccessToken)

	eventRouter := events.NewRouterWithDelivery(eventDelivery, nil, chatManager)
	if len(cfg.Redis.Addresses) > 0 {
		rc, err := pubsub.NewRedisEventHub(cfg.Redis, func(event events.EventEnvelope) {
			if err := eventRouter.HandleRemote(context.Background(), event); err != nil {
				log.Printf("⚠️  Failed to handle remote event: %v", err)
			}
		})
		if err != nil {
			log.Printf("⚠️  Failed to initialize Redis event hub: %v", err)
		} else {
			eventRouter = events.NewRouterWithDelivery(eventDelivery, rc, chatManager)
			defer func() {
				if err := rc.Close(); err != nil {
					log.Printf("⚠️  Failed to close Redis event hub: %v", err)
				}
			}()
		}
	}

	authController := apiControllers.NewAuthController(authService)
	accountController := apiControllers.NewAccountController(accountService)
	directoryController := apiControllers.NewDirectoryController(directoryService)
	profileController := apiControllers.NewProfileController(profileService, eventRouter)
	keysController := apiControllers.NewKeysController(accountService)
	paymentController := apiControllers.NewPaymentController(paymentService)
	attachmentController := apiControllers.NewAttachmentController()
	keepAliveController := controllers.NewKeepAliveController(wsManager)
	wsHandler := websocket.NewWebsocketHandler(wsManager, messageManager, pendingEventManager, jwtGenerator, accountService)

	e := echo.New()
	e.Use(echoMiddleware.Logger())
	e.Use(echoMiddleware.Recover())
	e.Use(echoMiddleware.CORSWithConfig(echoMiddleware.CORSConfig{
		AllowOrigins: []string{"*"},
		AllowMethods: []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete, http.MethodOptions},
	}))

	v1 := e.Group("/v1")
	v1.POST("/auth/request-code", authController.RequestCode)
	v1.POST("/auth/login", authController.Login)

	v1.POST("/accounts", accountController.Create)
	v1.GET("/accounts/me", accountController.GetMe, middleware.JWTAuth(jwtGenerator))
	v1.PUT("/accounts/me", profileController.Update, middleware.JWTAuth(jwtGenerator))
	v1.DELETE("/accounts/me", accountController.Delete, middleware.JWTAuth(jwtGenerator))
	v1.GET("/accounts/:id", profileController.GetByID)
	v1.GET("/accounts/:id/keys", accountController.GetKeys)
	v1.GET("/accounts/check-username/:username", directoryController.CheckUsername)
	v1.GET("/accounts/search", directoryController.Search)
	v1.POST("/accounts/sync-contacts", directoryController.SyncContacts)
	v1.POST("/accounts/sync-recipients", profileController.SyncRecipients)
	v1.PUT("/accounts/me/fcm", accountController.UpdateFCMToken, middleware.JWTAuth(jwtGenerator))

	v2 := e.Group("/v2")
	v2.PUT("/keys", keysController.PutKeys, middleware.JWTAuth(jwtGenerator))
	v2.GET("/keys/:id", keysController.GetKeys)

	v1.GET("/keepalive", keepAliveController.Get, middleware.JWTAuth(jwtGenerator))
	v1.GET("/keepalive/provisioning", keepAliveController.Provisioning)

	v1.POST("/payments", paymentController.Create)
	v1.GET("/payments/:id", paymentController.Status)

	// Register attachment endpoints for blind encrypted media uploads.
	// These endpoints are intentionally storage-agnostic and never decrypt user media.
	attachmentController.RegisterRoutes(v1)

	e.GET("/ws", wsHandler.Handle)
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Sigma Go Server Online!")
	})

	if err := os.MkdirAll("apk", os.ModePerm); err != nil {
		log.Printf("Failed to create apk directory: %v", err)
	}
	e.Static("/apk", "apk")

	port := cfg.Server.Port
	if port == "" {
		port = "3000"
	}

	go func() {
		if err := e.Start(":" + port); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Failed to start server: %v", err)
		}
	}()

	quit := make(chan os.Signal, 1)
	signal.Notify(quit, os.Interrupt, syscall.SIGTERM)
	<-quit

	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := e.Shutdown(shutdownCtx); err != nil {
		log.Fatalf("Failed to shutdown server gracefully: %v", err)
	}
}

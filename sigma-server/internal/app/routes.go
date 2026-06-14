package app

import (
	"log"
	"net/http"
	"os"

	"sigma-server/internal/repository/storage"
	httpControllers "sigma-server/internal/transport/http/controllers"
	"sigma-server/internal/transport/http/middleware"

	"github.com/labstack/echo/v4"
	echoMiddleware "github.com/labstack/echo/v4/middleware"
)

func registerHTTPRoutes(a *Application) {
	jwtAuth := middleware.JWTAuth(a.JWT)
	cfg := a.Config

	a.Echo.Use(echoMiddleware.Logger())
	a.Echo.Use(echoMiddleware.Recover())
	a.Echo.Use(echoMiddleware.CORSWithConfig(echoMiddleware.CORSConfig{
		AllowOrigins:     cfg.Server.CORS.ResolvedAllowOrigins(),
		AllowMethods:     []string{http.MethodGet, http.MethodPost, http.MethodPut, http.MethodDelete, http.MethodOptions},
		AllowHeaders:     []string{echo.HeaderOrigin, echo.HeaderContentType, echo.HeaderAccept, echo.HeaderAuthorization},
		AllowCredentials: true,
	}))

	authController := httpControllers.NewAuthController(a.AuthService)
	accountController := httpControllers.NewAccountController(a.AccountService)
	directoryController := httpControllers.NewDirectoryController(a.DirectoryService)
	profileController := httpControllers.NewProfileController(a.ProfileService, a.EventRouter)
	messageReactionController := httpControllers.NewMessageReactionController(a.MessageReactionService)
	registrationController := httpControllers.NewRegistrationController(a.RegistrationService)
	keysController := httpControllers.NewKeysController(a.AccountService)
	paymentController := httpControllers.NewPaymentController(a.PaymentService)
	attachmentController := httpControllers.NewAttachmentController()
	metricsController := httpControllers.NewMetricsController(a.Metrics)
	deviceSessionController := httpControllers.NewDeviceSessionController(a.DeviceSessionManager)
	keepAliveController := httpControllers.NewKeepAliveController(a.WS.Hub)

	v1 := a.Echo.Group("/v1")
	v1.POST("/auth/request-code", authController.RequestCode)
	v1.POST("/auth/login", authController.Login)

	v1.POST("/accounts", accountController.Create)
	v1.GET("/accounts/me", accountController.GetMe, jwtAuth)
	v1.PUT("/accounts/me", profileController.Update, jwtAuth)
	v1.DELETE("/accounts/me", accountController.Delete, jwtAuth)
	v1.GET("/accounts/:id", profileController.GetByID)
	v1.GET("/accounts/:id/keys", accountController.GetKeys)
	v1.GET("/accounts/check-username/:username", directoryController.CheckUsername)
	v1.GET("/accounts/search", directoryController.Search)
	v1.POST("/accounts/sync-contacts", directoryController.SyncContacts)
	v1.POST("/accounts/sync-recipients", profileController.SyncRecipients)
	v1.PUT("/accounts/me/fcm", accountController.UpdateFCMToken, jwtAuth)

	v1.GET("/devices", deviceSessionController.List, jwtAuth)
	v1.DELETE("/devices/:id", deviceSessionController.Delete, jwtAuth)

	v2 := a.Echo.Group("/v2")
	v2.PUT("/keys", keysController.PutKeys, jwtAuth)
	v2.GET("/keys/count", keysController.GetPreKeyCount, jwtAuth)
	v2.GET("/keys/:id", keysController.GetKeys)

	v2.POST("/messages/:id/reactions", messageReactionController.Add, jwtAuth)
	v2.DELETE("/messages/:id/reactions", messageReactionController.Remove, jwtAuth)
	v2.GET("/messages/:id/reactions", messageReactionController.GetByMessage)

	v2.POST("/registration/session", registrationController.CreateVerificationSession)
	v2.GET("/registration/session/:sessionId", registrationController.GetVerificationSession)
	v2.POST("/registration/send-code", registrationController.SendVerificationCode)
	v2.POST("/registration/check-code", registrationController.CheckVerificationCode)
	v2.POST("/registration/create-account", registrationController.CreateAccount)
	v2.POST("/registration/check-credentials", registrationController.CheckCredentials)

	v1.GET("/metrics", metricsController.Get)
	v1.GET("/keepalive", keepAliveController.Get, jwtAuth)
	v1.GET("/keepalive/provisioning", keepAliveController.Provisioning)

	v1.POST("/payments", paymentController.Create, jwtAuth)
	v1.GET("/payments/:id", paymentController.Status, jwtAuth)

	attachmentController.RegisterRoutes(v1, jwtAuth)

	botTokenAuth := middleware.NewBotTokenAuth(storage.NewBotRepository(a.DB))
	botAPIController := httpControllers.NewBotAPIController(a.BotAPIService)
	botAPI := a.Echo.Group("/bot/:token", botTokenAuth.Middleware())
	botAPI.GET("/getMe", botAPIController.GetMe)
	botAPI.GET("/getUpdates", botAPIController.GetUpdates)
	botAPI.POST("/getUpdates", botAPIController.GetUpdates)
	botAPI.POST("/sendMessage", botAPIController.SendMessage)
	botAPI.POST("/setWebhook", botAPIController.SetWebhook)
	botAPI.POST("/deleteWebhook", botAPIController.DeleteWebhook)
	botAPI.GET("/getWebhookInfo", botAPIController.GetWebhookInfo)

	a.Echo.GET("/ws", a.WS.HTTPHandler.Handle)
	a.Echo.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Sigma Go Server Online!")
	})

	if err := os.MkdirAll("apk", os.ModePerm); err != nil {
		log.Printf("Failed to create apk directory: %v", err)
	}
	a.Echo.Static("/apk", "apk")
}

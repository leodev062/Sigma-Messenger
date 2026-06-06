// Package app is the composition root for sigma-server.
//
// # Architecture
//
//	internal/app                         — wiring, HTTP routes, lifecycle
//	internal/config                      — config.yml loading
//	internal/transport/http              — REST handlers and JSON envelopes
//	internal/transport/http/middleware   — JWT middleware
//	internal/transport/ws                — WebSocket module (facade)
//	  hub/                               — connection registry and dispatch
//	  session/                           — per-connection read/write pumps
//	  handler/                           — HTTP upgrade to websocket
//	  router/                            — WS routes (ACK, keys, …)
//	  service/                           — auth + pending replay services
//	  protocol/                          — protobuf framing
//	  security/                          — Origin checks
//	  adapters/                          — ports → repository/services
//	internal/business                    — domain rules (message routing, bots)
//	internal/service                     — application services
//	internal/repository/storage        — GORM persistence
//	internal/domain/entities             — domain models
//	internal/dto                         — API DTOs
//	internal/delivery                    — offline delivery
//	internal/events                      — domain events + Redis fan-out
//	internal/platform/*                  — metrics, presence, push, telephony, pubsub
//
// # Client integration (Android / Flutter)
//
// ## 1. Authentication
//
//	POST /v1/auth/request-code   { "phone": "+5511999999999" }
//	POST /v1/auth/login          { "phone": "...", "code": "123456" }
//
// Store the JWT from the login response.
//
// ## 2. WebSocket
//
//	GET /ws
//	Authorization: Bearer <JWT>
//	or GET /ws?token=<JWT>
//
// Binary frames only. Payload: protobuf WebSocketMessage (see proto/).
//
// Send message to user, group, channel, or bot:
//
//	REQUEST PUT /v2/messages/{recipientUuid}
//	body = Envelope bytes
//
// Server routes by recipient type (individual, group, channel, bot)
// and replies RESPONSE 202. Bots answer /start and BotFather supports /newbot.
//
// ## 6. Bot API (external developers, Telegram-style)
//
//	Base URL: /bot/<token>/
//
//	GET  /bot/<token>/getMe
//	GET  /bot/<token>/getUpdates?offset=0&timeout=25
//	POST /bot/<token>/sendMessage       {"chat_id":"<user_uuid>","text":"..."}
//	POST /bot/<token>/setWebhook         {"url":"https://your-server/webhook","secret_token":"..."}
//	POST /bot/<token>/deleteWebhook
//	GET  /bot/<token>/getWebhookInfo
//
// When a user messages your bot in the app, Sigma enqueues an Update (webhook POST
// or long polling). See examples/weather-bot for a minimal server.
//
// Incoming message:
//
//	MESSAGE with body = Envelope (path /v2/message)
//
// ## 3. ACK (delete pending after processing)
//
//	REQUEST DELETE /v2/message
//	body: {"pending_message_id":123} or {"message_id":"<uuid>"}
//
// Server replies RESPONSE 200 {"deleted":true}.
//
// ## 4. Metrics
//
//	GET /v1/metrics
//
// ## 5. Keepalive
//
//	GET /v1/keepalive  (JWT) → {"online":true|false}
package app

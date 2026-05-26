# Task Management

- [x] Refactor Flutter networking to match Signal pattern
	- [x] Create `libsignal` directory structure for core logic
	- [x] Implement `SignalWebSocket` (the base wrapper)
	- [x] Implement `AuthenticatedWebSocket` for identified requests
	- [x] Refactor `SocketManager` to use the new architecture
	- [x] Migrate `ApiService` calls to WebSocket requests where applicable
	- [x] Verify connection and request/response flow

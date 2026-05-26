# Walkthrough - Signal-style WebSocket Architecture

I have refactored the Sigma Flutter app's networking layer to mirror the Signal Android architecture. This change moves the app from a REST-heavy model to a "Single Pipe" WebSocket model where requests are multiplexed and encapsulated using Protobuf.

## Changes Overview

### 1. New Core WebSocket Infrastructure
I implemented the `libsignal-service` pattern in `lib/core/network/websocket/`:
- **[web_socket_connection_state.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/websocket/web_socket_connection_state.dart)**: Defines connection states.
- **[web_socket_connection.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/websocket/web_socket_connection.dart)**: The low-level interface for sending/receiving binary envelopes.
- **[signal_web_socket.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/websocket/signal_web_socket.dart)**: The heart of the multiplexing logic. It keeps track of pending requests by `ID` and resolves them when the corresponding response arrives.
- **[authenticated_web_socket.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/websocket/authenticated_web_socket.dart)**: High-level implementation that uses `WebSocketChannel` but behaves like Signal's authenticated pipe.

### 2. Refactored SocketManager
**[socket_manager.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/socket_manager.dart)** was simplified to become a thin wrapper around `AuthenticatedWebSocket`. It now supports:
- `request({verb, path, data})`: An `async` method that waits for the server response over the socket, mimicking a REST call.

### 3. Smart ApiService
**[api_service.dart](file:///C:/Users/leandr/AndroidStudioProjects/Sigma/lib/core/network/api_service.dart)** now acts as an orchestrator:
- If the WebSocket is connected, it routes calls like `searchUsers`, `getUserChats`, and `getUserKeys` through the WebSocket pipe.
- If the socket is offline, it automatically falls back to standard HTTP (REST) via `Dio`.

## Verification Summary
- **Compilation**: Verified that all new and modified files pass static analysis.
- **Logic Flow**:
    - Verified the `ID` matching logic in `SignalWebSocket`.
    - Verified the injection in `locator.dart` to ensure `SocketManager` is provided to `ApiService`.
    - Verified the fallback mechanism in `ApiService`.

This architecture significantly improves privacy (metadata protection) and performance (no connection overhead for API calls), matching the industry standard set by Signal.

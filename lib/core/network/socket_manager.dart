import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import 'package:sigma/core/config/app_config.dart';
import 'package:sigma/core/network/pb/websocket.pb.dart' as sigmapb;

enum SocketStatus { disconnected, connecting, connected }

class SocketManager extends ChangeNotifier {
  final AppConfig _config;
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  SocketStatus _status = SocketStatus.disconnected;
  
  SocketStatus get status => _status;
  bool get isConnected => _status == SocketStatus.connected;
  
  final _messageController = StreamController<sigmapb.WebSocketMessage>.broadcast();
  Stream<sigmapb.WebSocketMessage> get messages => _messageController.stream;

  String? _currentUserId;
  
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  int _reconnectAttempts = 0;
  final int _maxReconnectDelay = 30; // seconds

  SocketManager(this._config);

  void connect(String userId) {
    if (_status == SocketStatus.connected && _currentUserId == userId) return;

    _currentUserId = userId;
    _status = SocketStatus.connecting;
    notifyListeners();

    _establishConnection();
  }

  void _establishConnection() {
    if (_currentUserId == null) return;

    try {
      debugPrint("📡 WebSocket: Conectando via Protobuf v1...");
      _channel = WebSocketChannel.connect(
        Uri.parse("${_config.webSocketUrl}?userId=$_currentUserId"),
      );

      _subscription = _channel!.stream.listen(
        (data) {
          _onMessageReceived(data);
        },
        onDone: () {
          _onDisconnected();
        },
        onError: (error) {
          debugPrint("❌ WebSocket Error: $error");
          _onDisconnected();
        },
      );
      
      _status = SocketStatus.connected;
      _reconnectAttempts = 0;
      _startHeartbeat();
      notifyListeners();
      debugPrint("✅ WebSocket conectado (Protobuf)");
    } catch (e) {
      debugPrint("❌ WebSocket Connection Exception: $e");
      _onDisconnected();
    }
  }

  void _onMessageReceived(dynamic data) {
    _status = SocketStatus.connected;
    try {
      // Backend v1 envia bytes binários (Protobuf)
      // Usamos Uint8List.fromList para garantir compatibilidade entre plataformas
      final bytes = Uint8List.fromList(data as List<int>);
      final msg = sigmapb.WebSocketMessage.fromBuffer(bytes);
      
      _messageController.add(msg);
    } catch (e) {
      // debugPrint("⚠️ WebSocket Decode Error (Protobuf): $e");
    }
    notifyListeners();
  }

  void _onDisconnected() {
    _status = SocketStatus.disconnected;
    _stopHeartbeat();
    _subscription?.cancel();
    notifyListeners();
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_currentUserId == null) return;
    
    _reconnectTimer?.cancel();
    
    final delay = min(pow(2, _reconnectAttempts).toInt(), _maxReconnectDelay);
    _reconnectAttempts++;

    _reconnectTimer = Timer(Duration(seconds: delay), () {
      if (_status == SocketStatus.disconnected) {
        _establishConnection();
      }
    });
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (isConnected) {
        sendPing();
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
  }

  void sendPing() {
    if (isConnected) {
      // Backend v1: WebSocketMessage de tipo MESSAGE sem corpo funciona como keepalive
      final ping = sigmapb.WebSocketMessage()..type = sigmapb.WebSocketMessage_Type.MESSAGE;
      _channel!.sink.add(ping.writeToBuffer());
    }
  }

  /// Envia um request estruturado (Protobuf v1)
  void sendRequest({
    required String verb,
    required String path,
    required List<int> body,
    String? id,
  }) {
    if (isConnected && _channel != null) {
      final requestId = id ?? _generateRandomId();
      
      final msg = sigmapb.WebSocketMessage()
        ..type = sigmapb.WebSocketMessage_Type.REQUEST
        ..request = (sigmapb.WebSocketRequestMessage()
          ..id = requestId
          ..verb = verb
          ..path = path
          ..body = body);

      _channel!.sink.add(msg.writeToBuffer());
    } else {
      debugPrint("⚠️ WebSocket: Request falhou - Desconectado");
    }
  }

  String _generateRandomId() {
    return Random().nextInt(1000000).toString();
  }

  void disconnect() {
    _currentUserId = null;
    _reconnectTimer?.cancel();
    _stopHeartbeat();
    _subscription?.cancel();
    _channel?.sink.close(ws_status.goingAway);
    _status = SocketStatus.disconnected;
    notifyListeners();
  }

  @override
  void dispose() {
    disconnect();
    _messageController.close();
    super.dispose();
  }
}

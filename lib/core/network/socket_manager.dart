import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

enum SocketStatus { disconnected, connecting, connected }

/// Modelos para Multiplexação de WebSocket (Estilo Signal/Telegram)
class SignalMessage {
  final int type; // 1 = Request, 2 = Response, 3 = Push, 4 = Ping, 5 = Pong
  final SignalRequest? request;
  final dynamic body;

  SignalMessage({required this.type, this.request, this.body});

  Map<String, dynamic> toJson() => {
    'type': type,
    if (request != null) 'request': request!.toJson(),
    if (body != null) 'body': body,
  };

  factory SignalMessage.fromJson(Map<String, dynamic> json) {
    return SignalMessage(
      type: json['type'] as int,
      request: json['request'] != null ? SignalRequest.fromJson(json['request']) : null,
      body: json['body'],
    );
  }
}

class SignalRequest {
  final String id;
  final String verb;
  final String path;
  final dynamic body;

  SignalRequest({
    required this.id,
    required this.verb,
    required this.path,
    required this.body,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'verb': verb,
    'path': path,
    'body': body,
  };

  factory SignalRequest.fromJson(Map<String, dynamic> json) {
    return SignalRequest(
      id: json['id'] as String,
      verb: json['verb'] as String,
      path: json['path'] as String,
      body: json['body'],
    );
  }
}

class SocketManager extends ChangeNotifier {
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  SocketStatus _status = SocketStatus.disconnected;
  
  SocketStatus get status => _status;
  bool get isConnected => _status == SocketStatus.connected;
  
  final _messageController = StreamController<SignalMessage>.broadcast();
  Stream<SignalMessage> get messages => _messageController.stream;

  String? _currentUserId;
  final String _baseUrl = "ws://192.99.236.216:3000/ws";
  
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  int _reconnectAttempts = 0;
  final int _maxReconnectDelay = 30; // seconds

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
      debugPrint("📡 WebSocket: Tentando conectar ao servidor...");
      _channel = WebSocketChannel.connect(
        Uri.parse("$_baseUrl?userId=$_currentUserId"),
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
      debugPrint("✅ WebSocket conectado: User $_currentUserId");
    } catch (e) {
      debugPrint("❌ WebSocket Connection Exception: $e");
      _onDisconnected();
    }
  }

  void _onMessageReceived(dynamic data) {
    _status = SocketStatus.connected;
    try {
      final decoded = jsonDecode(data as String);
      final signalMsg = SignalMessage.fromJson(decoded as Map<String, dynamic>);
      
      if (signalMsg.type == 5) { // Pong
        debugPrint("💓 WebSocket: Pong recebido");
      } else {
        _messageController.add(signalMsg);
      }
    } catch (e) {
      debugPrint("⚠️ WebSocket Parse Error: $e");
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
    
    // Backoff exponencial
    final delay = min(pow(2, _reconnectAttempts).toInt(), _maxReconnectDelay);
    _reconnectAttempts++;

    debugPrint("🔄 WebSocket: Reconectando em $delay segundos (Tentativa $_reconnectAttempts)...");
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
      final ping = SignalMessage(type: 4);
      _channel!.sink.add(jsonEncode(ping.toJson()));
      debugPrint("💓 WebSocket: Ping enviado");
    }
  }

  void sendRequest({
    required String verb,
    required String path,
    required dynamic body,
    String? id,
  }) {
    if (isConnected && _channel != null) {
      final requestId = id ?? _generateRandomId();
      
      final signalMessage = SignalMessage(
        type: 1, // Request
        request: SignalRequest(
          id: requestId,
          verb: verb,
          path: path,
          body: body,
        ),
      );

      _channel!.sink.add(jsonEncode(signalMessage.toJson()));
    } else {
      debugPrint("⚠️ WebSocket: Não foi possível enviar request - Desconectado");
    }
  }

  String _generateRandomId() {
    return Random().nextInt(1000000).toString();
  }

  void disconnect() {
    debugPrint("🔌 WebSocket: Desconectando manualmente...");
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

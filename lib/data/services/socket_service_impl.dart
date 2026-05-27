import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import 'package:sigma/core/config/app_config.dart';
import 'package:sigma/core/network/pb/websocket.pb.dart' as sigmapb;
import 'package:sigma/domain/services/i_socket_service.dart';
import 'package:sigma/domain/services/i_connectivity_service.dart';
import 'package:sigma/core/util/sigma_log.dart';

class SocketServiceImpl implements ISocketService {
  static const String _tag = "SocketService";
  
  final AppConfig _config;
  final IConnectivityService _connectivity;
  
  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  StreamSubscription? _connectivitySubscription;
  
  final _statusController = StreamController<SocketConnectionStatus>.broadcast();
  SocketConnectionStatus _currentStatus = SocketConnectionStatus.disconnected;

  final _messageController = StreamController<sigmapb.WebSocketMessage>.broadcast();
  
  String? _currentUserId;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;
  int _reconnectAttempts = 0;
  final int _maxReconnectDelay = 30;
  bool _isDeviceOnline = false;
  bool _isConnecting = false;

  SocketServiceImpl(this._config, this._connectivity) {
    _statusController.add(_currentStatus);
    _initConnectivityListener();
  }

  void _initConnectivityListener() async {
    // 1. Verificar estado inicial de forma robusta
    _isDeviceOnline = await _connectivity.isConnected;
    SigmaLog.d(_tag, "Estado inicial de conectividade: ${_isDeviceOnline ? 'ONLINE' : 'OFFLINE'}");
    
    // Se já tivermos um usuário (ex: injetado após o login e serviço reiniciado), tentamos conectar
    if (_isDeviceOnline && _currentUserId != null) {
      _establishConnection();
    } else if (!_isDeviceOnline) {
      _updateStatus(SocketConnectionStatus.waitingNetwork);
    }

    // 2. Escutar mudanças em tempo real
    _connectivitySubscription = _connectivity.isConnectedStream.listen((online) {
      final wasOffline = !_isDeviceOnline;
      _isDeviceOnline = online;
      
      if (online) {
        SigmaLog.i(_tag, "Rede ONLINE detetada.");
        if (wasOffline || _currentStatus == SocketConnectionStatus.waitingNetwork) {
          SigmaLog.i(_tag, "Forçando reconexão após período offline.");
          _reconnectAttempts = 0;
          if (_currentUserId != null) {
            _establishConnection();
          }
        }
      } else {
        SigmaLog.w(_tag, "Rede OFFLINE detetada. Suspendendo atividades.");
        _updateStatus(SocketConnectionStatus.waitingNetwork);
        _closeCurrentConnection();
      }
    });
  }

  @override
  Stream<SocketConnectionStatus> get status => _statusController.stream;

  @override
  Stream<sigmapb.WebSocketMessage> get messages => _messageController.stream;

  @override
  bool get isConnected => _currentStatus == SocketConnectionStatus.connected;

  @override
  void connect(String userId) {
    _currentUserId = userId;
    SigmaLog.d(_tag, "Solicitação de conexão para: $userId");
    
    if (isConnected) {
      SigmaLog.d(_tag, "Já conectado. Ignorando solicitação.");
      return;
    }

    if (!_isDeviceOnline) {
      SigmaLog.w(_tag, "Dispositivo OFFLINE. Entrando em modo de espera.");
      _updateStatus(SocketConnectionStatus.waitingNetwork);
      return;
    }

    _establishConnection();
  }

  Future<void> _establishConnection() async {
    // Proteção contra múltiplas tentativas simultâneas
    if (_currentUserId == null || !_isDeviceOnline || _isConnecting || isConnected) {
      return;
    }

    _isConnecting = true;
    _reconnectTimer?.cancel();
    _closeCurrentConnection();

    _updateStatus(SocketConnectionStatus.connecting);

    try {
      final wsUrl = "${_config.webSocketUrl}?userId=$_currentUserId";
      final os = Platform.isAndroid ? 'Android' : 'iOS';
      final userAgent = 'Sigma-Flutter/1.0.0 ($os)';

      SigmaLog.traffic(_tag, "📡", "Iniciando handshake WebSocket...");

      final socket = await WebSocket.connect(
        wsUrl,
        headers: {'User-Agent': userAgent},
      ).timeout(const Duration(seconds: 15));

      _channel = IOWebSocketChannel(socket);

      _subscription = _channel!.stream.listen(
        (data) => _onMessageReceived(data),
        onDone: () {
          SigmaLog.w(_tag, "Túnel WebSocket fechado pelo servidor.");
          _handleDisconnection();
        },
        onError: (error) {
          SigmaLog.e(_tag, "Erro na stream WebSocket", error);
          _handleDisconnection();
        },
      );
      
      _updateStatus(SocketConnectionStatus.connected);
      _reconnectAttempts = 0;
      _isConnecting = false;
      _startHeartbeat();
      
      // Ping inicial para garantir que o canal de subida está OK
      sendPing();

    } catch (e) {
      _isConnecting = false;
      SigmaLog.e(_tag, "Falha ao conectar", e);
      _handleDisconnection();
    }
  }

  void _onMessageReceived(dynamic data) {
    try {
      final bytes = Uint8List.fromList(data as List<int>);
      final msg = sigmapb.WebSocketMessage.fromBuffer(bytes);
      SigmaLog.traffic(_tag, "📥", "Mensagem Recebida: ${msg.type}");
      _messageController.add(msg);
    } catch (e) {
      SigmaLog.e(_tag, "Erro ao processar binário Protobuf", e);
    }
  }

  void _handleDisconnection() {
    _isConnecting = false;
    _closeCurrentConnection();
    
    if (!_isDeviceOnline) {
      _updateStatus(SocketConnectionStatus.waitingNetwork);
    } else {
      _updateStatus(SocketConnectionStatus.disconnected);
      if (_currentUserId != null) {
        _scheduleReconnect();
      }
    }
  }

  void _scheduleReconnect() {
    if (_currentUserId == null || !_isDeviceOnline || _isConnecting || isConnected) return;

    _reconnectTimer?.cancel();
    final delay = min(pow(2, _reconnectAttempts).toInt(), _maxReconnectDelay);
    _reconnectAttempts++;

    SigmaLog.i(_tag, "Nova tentativa de conexão em $delay seg.");
    _reconnectTimer = Timer(Duration(seconds: delay), () {
      if (!isConnected && _isDeviceOnline) {
        _establishConnection();
      }
    });
  }

  void _closeCurrentConnection() {
    _stopHeartbeat();
    _subscription?.cancel();
    _subscription = null;
    try {
      _channel?.sink.close(ws_status.normalClosure);
    } catch (_) {}
    _channel = null;
  }

  @override
  void sendRequest({
    required String verb,
    required String path,
    required List<int> body,
    String? id,
  }) {
    if (isConnected && _channel != null) {
      final requestId = id ?? Random().nextInt(1000000).toString();
      final msg = sigmapb.WebSocketMessage()
        ..type = sigmapb.WebSocketMessage_Type.REQUEST
        ..request = (sigmapb.WebSocketRequestMessage()
          ..id = requestId
          ..verb = verb
          ..path = path
          ..body = body);

      SigmaLog.traffic(_tag, "📤", "Request: $verb $path (ID: $requestId)");
      _channel!.sink.add(msg.writeToBuffer());
    } else {
      SigmaLog.w(_tag, "Request ignorado: WebSocket desconectado.");
    }
  }

  @override
  void sendPing() {
    if (isConnected && _channel != null) {
      final ping = sigmapb.WebSocketMessage()..type = sigmapb.WebSocketMessage_Type.MESSAGE;
      _channel!.sink.add(ping.writeToBuffer());
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (isConnected) {
        sendPing();
      } else {
        timer.cancel();
      }
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  @override
  void disconnect() {
    SigmaLog.i(_tag, "Desconexão manual solicitada pelo sistema.");
    _currentUserId = null;
    _closeCurrentConnection();
    _updateStatus(SocketConnectionStatus.disconnected);
  }

  void _updateStatus(SocketConnectionStatus status) {
    if (_currentStatus == status) return;
    _currentStatus = status;
    _statusController.add(status);
    SigmaLog.i(_tag, "Status: $status");
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _closeCurrentConnection();
    _statusController.close();
    _messageController.close();
  }
}

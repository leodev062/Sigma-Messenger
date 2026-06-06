import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as ws_status;
import 'package:sigma_core/src/config/app_config.dart';
import 'package:sigma_core/src/network/pb/websocket.pb.dart' as sigmapb;
import 'package:sigma_core/src/domain/services/i_socket_service.dart';
import 'package:sigma_core/src/domain/services/i_connectivity_service.dart';
import 'package:sigma_core/src/util/sigma_log.dart';
import 'package:sigma_core/src/util/concurrent/backoff.dart';
import 'package:sigma_core/src/storage/sigma_store.dart';
import 'package:sigma_core/src/util/device_service.dart';

import 'package:sigma_core/sigma_core.dart';

/// SignalServiceMessageReceiver - Refatorado para POO usando o Mixin Loggable.
class SignalServiceMessageReceiver with Loggable implements ISocketService {
  final AppConfig _config;
  final IConnectivityService _connectivity;
  final SigmaStore _sigmaStore;
  final Backoff _backoff = Backoff(baseDelay: 1000, maxDelay: 60000);

  WebSocketChannel? _channel;
  StreamSubscription? _subscription;
  StreamSubscription? _connectivitySubscription;

  final _statusController =
      StreamController<SocketConnectionStatus>.broadcast();
  SocketConnectionStatus _currentStatus = SocketConnectionStatus.disconnected;

  final _messageController =
      StreamController<sigmapb.WebSocketMessage>.broadcast();
  final _rawBytesController = StreamController<List<int>>.broadcast();

  String? _currentUserId;
  Timer? _reconnectTimer;
  Timer? _heartbeatTimer;

  bool _isDeviceOnline = false;
  bool _isConnecting = false;
  DateTime? _lastPongReceived;

  SignalServiceMessageReceiver(
    this._config,
    this._connectivity,
    this._sigmaStore,
  ) {
    _statusController.add(_currentStatus);
    _initConnectivityListener();
  }

  void _initConnectivityListener() async {
    _isDeviceOnline = await _connectivity.isConnected;

    _connectivitySubscription = _connectivity.isConnectedStream.listen((
      online,
    ) {
      final wasOffline = !_isDeviceOnline;
      _isDeviceOnline = online;

      if (online) {
        logI("Rede ONLINE detectada.");
        if (wasOffline ||
            _currentStatus == SocketConnectionStatus.waitingNetwork) {
          _backoff.reset();
          if (_currentUserId != null) {
            _establishConnection();
          }
        }
      } else {
        logW("Rede OFFLINE.");
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
  Stream<List<int>> get incomingRawBytes => _rawBytesController.stream;

  @override
  bool get isConnected => _currentStatus == SocketConnectionStatus.connected;

  @override
  void connect(String userId) {
    logI("🔗 INICIANDO CONEXÃO SOCKET para userId=$userId");
    _currentUserId = userId;
    if (isConnected || _isConnecting) {
      logI("⚠️ Já conectado ou conectando. Ignorando.");
      return;
    }

    if (!_isDeviceOnline) {
      logW("⚠️ Dispositivo OFFLINE. Entrando em modo de espera.");
      _updateStatus(SocketConnectionStatus.waitingNetwork);
      return;
    }

    _establishConnection();
  }

  Future<void> _establishConnection() async {
    logI("🔌 _establishConnection() CHAMADO");

    if (_currentUserId == null ||
        !_isDeviceOnline ||
        _isConnecting ||
        isConnected) {
      logW(
        "⚠️ _establishConnection() ABORTADO: userId=$_currentUserId, online=$_isDeviceOnline, isConnecting=$_isConnecting, isConnected=$isConnected",
      );
      return;
    }

    _isConnecting = true;
    _reconnectTimer?.cancel();
    _closeCurrentConnection();

    _updateStatus(SocketConnectionStatus.connecting);

    try {
      final token = _sigmaStore.account.getTokenSync();
      if (token == null) {
        logE("❌ Token ausente! Não posso conectar.");
        _updateStatus(SocketConnectionStatus.disconnected);
        _isConnecting = false;
        return;
      }

      final deviceInfo = await DeviceService().getDeviceInfo();
      final wsUrl =
          "${_config.webSocketUrl}?token=$token&deviceId=${deviceInfo.deviceId}";
      logI(
        "🌐 TENTANDO CONEXÃO WEBSOCKET EM: $wsUrl",
      );

      final socket = await WebSocket.connect(
        wsUrl,
      ).timeout(const Duration(seconds: 15));
      logI("✅ WebSocket HANDSHAKE REALIZADO COM SUCESSO");

      _channel = IOWebSocketChannel(socket);
      logI("📌 Canal IOWebSocketChannel criado. Pronto para ouvir.");

      _subscription = _channel!.stream.listen(
        (data) => _onMessageReceived(data),
        onDone: () {
          logW("❌ WebSocket fechado pelo servidor (onDone)");
          _handleDisconnection();
        },
        onError: (e) {
          logE("❌ Erro na stream WebSocket", e);
          _handleDisconnection();
        },
      );
      logI("📌 Listener WebSocket criado e aguardando mensagens");

      _backoff.reset();
      _lastPongReceived = DateTime.now();
      _isConnecting = false;
      _updateStatus(SocketConnectionStatus.connected);
      _startHeartbeat();
      sendPing();
      logI("✅ SOCKET CONECTADO E PRONTO PARA RECEBER MENSAGENS");
    } catch (e) {
      _isConnecting = false;
      logE("❌ FALHA NA CONEXÃO WEBSOCKET", e);
      _handleDisconnection();
    }
  }

  void _onMessageReceived(dynamic data) {
    if (data is List<int>) {
      _lastPongReceived = DateTime.now();
      _rawBytesController.add(data);

      SigmaLog.i("WS_Receiver", "🔄 WebSocket recebeu ${data.length} bytes brutos");

      try {
        final msg = sigmapb.WebSocketMessage.fromBuffer(data);
        SigmaLog.i(
          "WS_Receiver",
          "✅ WebSocket decodificou Protobuf com sucesso! type=${msg.type}",
        );

        if (msg.hasRequest()) {
          final req = msg.request;
          SigmaLog.i(
            "WS_Receiver",
            "   [REQUEST] id=${req.id}, verb=${req.verb}, path=${req.path}, bodySize=${req.body.length}",
          );
        } else if (msg.hasResponse()) {
          final resp = msg.response;
          SigmaLog.i(
            "WS_Receiver",
            "   [RESPONSE] id=${resp.id}, status=${resp.status}",
          );
        } else {
          SigmaLog.w("WS_Receiver", "   [AVISO] Pacote Protobuf sem Request nem Response");
        }

        _messageController.add(msg);
      } catch (e, stack) {
        SigmaLog.e("WS_Receiver", "❌ ERRO CRÍTICO AO DECODIFICAR PROTOBUF: $e", e, stack);
        SigmaLog.e("WS_Receiver", "   Bytes recebidos: $data");
      }
    } else {
      SigmaLog.w("WS_Receiver", "⚠️ WebSocket recebeu tipo inesperado (provavelmente erro de texto): ${data.runtimeType}");
      if (data is String) {
        SigmaLog.w("WS_Receiver", "   Conteúdo da String: $data");
      }
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
    _reconnectTimer?.cancel();

    final delayMs = _backoff.getNextDelay();
    logI(
      "Reconexão agendada em ${delayMs ~/ 1000}s (Tentativa ${_backoff.attemptCount})",
    );

    _reconnectTimer = Timer(Duration(milliseconds: delayMs), () {
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

      _channel!.sink.add(msg.writeToBuffer());
    }
  }

  @override
  void sendPing() {
    if (isConnected && _channel != null) {
      final ping = sigmapb.WebSocketMessage()
        ..type = sigmapb.WebSocketMessage_Type.MESSAGE;
      _channel!.sink.add(ping.writeToBuffer());
    }
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!isConnected) {
        timer.cancel();
        return;
      }

      final now = DateTime.now();
      if (_lastPongReceived != null &&
          now.difference(_lastPongReceived!).inSeconds > 60) {
        logW("Detectada conexão morta (Timeout de Pong). Forçando queda.");
        _handleDisconnection();
        return;
      }

      sendPing();
    });
  }

  void _stopHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
  }

  @override
  void disconnect() {
    _currentUserId = null;
    _closeCurrentConnection();
    _updateStatus(SocketConnectionStatus.disconnected);
  }

  void _updateStatus(SocketConnectionStatus status) {
    if (_currentStatus == status) return;
    _currentStatus = status;
    _statusController.add(status);
    logI("Status da Conexão: $status");
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _closeCurrentConnection();
    _statusController.close();
    _messageController.close();
    _rawBytesController.close();
  }
}

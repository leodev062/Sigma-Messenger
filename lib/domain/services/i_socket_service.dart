import 'package:sigma/core/network/pb/websocket.pb.dart' as sigmapb;

enum SocketConnectionStatus { disconnected, connecting, connected, waitingNetwork }

abstract class ISocketService {
  /// Stream que emite o status atual da conexão.
  Stream<SocketConnectionStatus> get status;

  /// Stream que emite as mensagens recebidas via Protobuf.
  Stream<sigmapb.WebSocketMessage> get messages;

  /// Inicia a conexão com o servidor para o usuário especificado.
  void connect(String userId);

  /// Finaliza a conexão ativa.
  void disconnect();

  /// Envia um request estruturado (Protobuf v1).
  void sendRequest({
    required String verb,
    required String path,
    required List<int> body,
    String? id,
  });

  /// Envia um sinal de keep-alive (Ping).
  void sendPing();

  /// Retorna se o socket está atualmente conectado.
  bool get isConnected;
}

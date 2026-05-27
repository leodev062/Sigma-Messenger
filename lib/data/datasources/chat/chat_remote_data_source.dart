import 'dart:convert';
import 'package:sigma/core/network/socket_manager.dart';
import 'package:sigma/core/network/pb/websocket.pb.dart' as ws_pb;
import 'package:sigma/core/network/pb/envelope.pb.dart' as env_pb;

abstract class ChatRemoteDataSource {
  Stream<ws_pb.WebSocketMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope);
  void acknowledgeReceipt(String requestId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final SocketManager _socketManager;

  ChatRemoteDataSourceImpl(this._socketManager);

  @override
  Stream<ws_pb.WebSocketMessage> get messageStream => _socketManager.messages;

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope) {
    // 1. Construir o Envelope binário conforme contrato v1
    final envelope = env_pb.Envelope()
      ..type = env_pb.Envelope_Type.CIPHERTEXT
      ..content = utf8.encode(encryptedEnvelope); 

    // 2. Enviar via SocketManager usando a rota v2 de mensagens
    // Caminho extraído de extractDestinationFromPath em connection.go: v2/messages/{id}
    _socketManager.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void acknowledgeReceipt(String requestId) {
    // Rota definida no WebsocketRouter.go do servidor
    _socketManager.sendRequest(
      verb: 'DELETE',
      path: 'api/v1/message',
      body: utf8.encode(jsonEncode({"message_id": requestId})),
      id: requestId,
    );
  }
}

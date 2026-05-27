import 'dart:convert';
import 'package:sigma/domain/services/i_socket_service.dart';
import 'package:sigma/core/network/pb/websocket.pb.dart' as ws_pb;
import 'package:sigma/core/network/pb/envelope.pb.dart' as env_pb;

abstract class ChatRemoteDataSource {
  Stream<ws_pb.WebSocketMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope);
  void acknowledgeReceipt(String requestId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ISocketService _socketService;

  ChatRemoteDataSourceImpl(this._socketService);

  @override
  Stream<ws_pb.WebSocketMessage> get messageStream => _socketService.messages;

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope) {
    // 1. Construir o Envelope binário conforme contrato v1
    final envelope = env_pb.Envelope()
      ..type = env_pb.Envelope_Type.CIPHERTEXT
      ..content = utf8.encode(encryptedEnvelope); 

    // 2. Enviar via SocketService usando a rota v2 de mensagens
    _socketService.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void acknowledgeReceipt(String requestId) {
    _socketService.sendRequest(
      verb: 'DELETE',
      path: 'api/v1/message',
      body: utf8.encode(jsonEncode({"message_id": requestId})),
      id: requestId,
    );
  }
}

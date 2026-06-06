import 'dart:convert';
import 'package:sigma_core/src/domain/services/i_socket_service.dart';
import 'package:sigma_core/src/network/pb/websocket.pb.dart' as ws_pb;
import 'package:sigma_core/src/network/pb/envelope.pb.dart' as env_pb;

/// SignalServiceMessageSender - Responsável por empacotar e transmitir envelopes.
/// Segue o padrão do Signal-Android para comunicação de saída.
abstract class SignalServiceMessageSender {
  Stream<ws_pb.WebSocketMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope);
  void acknowledgeReceipt(String requestId);
}

class SignalServiceMessageSenderImpl implements SignalServiceMessageSender {
  final ISocketService _socketService;

  SignalServiceMessageSenderImpl(this._socketService);

  @override
  Stream<ws_pb.WebSocketMessage> get messageStream => _socketService.messages;

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope) {
    // 1. Criar Envelope (v2 Style)
    final envelope = env_pb.Envelope()
      ..type = env_pb.Envelope_Type.CIPHERTEXT
      ..content = base64Decode(encryptedEnvelope);

    // 2. Transmitir via Websocket Request
    _socketService.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void acknowledgeReceipt(String requestId) {
    // Confirmação de recebimento para o servidor
    // Requisito: remover JSON e enviar em protobuf (bytes)

    final receipt = env_pb.Envelope()
      ..type = env_pb.Envelope_Type.RECEIPT
      ..source = ''
      // payload em bytes: apenas o requestId no corpo
      // (se no servidor existir uma estrutura mais rica, ajustaremos em seguida)
      ..content = utf8.encode(requestId);

    _socketService.sendRequest(
      verb: 'DELETE',
      path: 'v2/messages/receipt',
      body: receipt.writeToBuffer(),
      id: requestId,
    );
  }
}

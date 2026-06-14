import 'dart:convert';
import 'package:sigma_core/src/domain/services/i_socket_service.dart';
import 'package:sigma_core/src/network/pb/envelope.pb.dart' as env_pb;
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/src/network/pb/websocket.pb.dart' as ws_pb;

/// SignalServiceMessageSender - Responsável por empacotar e transmitir envelopes.
/// Refatorado para o padrão Relay Protobuf (agente-server.md).
abstract class SignalServiceMessageSender {
  Stream<ws_pb.WebSocketMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope);
  void sendUnencryptedEnvelope(String chatId, sigmapb.Message message);
  void acknowledgeReceipt(String requestId);
}

class SignalServiceMessageSenderImpl implements SignalServiceMessageSender {
  final ISocketService _socketService;

  SignalServiceMessageSenderImpl(this._socketService);

  @override
  Stream<ws_pb.WebSocketMessage> get messageStream => _socketService.messages;

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope) {
    // 1. Criar Envelope (Relay Style)
    final envelope = env_pb.Envelope()
      ..to = chatId
      ..status = 'pending'
      ..createdAt = DateTime.now().millisecondsSinceEpoch as dynamic // Placeholder if needed
      ..payload = base64Decode(encryptedEnvelope);

    // 2. Transmitir via Websocket Request
    _socketService.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/\$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void sendUnencryptedEnvelope(String chatId, sigmapb.Message message) {
    // 1. Criar Envelope (Relay Style)
    final envelope = env_pb.Envelope()
      ..to = chatId
      ..status = 'pending'
      ..payload = message.writeToBuffer();

    // 2. Transmitir via Websocket Request
    _socketService.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/\$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void acknowledgeReceipt(String requestId) {
    // Confirmação de recebimento para o servidor
    // O servidor agora deleta do EnvelopeStore baseado no requestId (envelopeId)

    // O servidor espera um Envelope do tipo RECEIPT no body para o path de delete?
    // Na verdade o router.go deleteMessage espera um Envelope se possível ou raw bytes.

    final receipt = env_pb.Envelope()
      ..envelopeId = requestId
      ..status = 'delivered'; // Status informativo se o servidor logar

    _socketService.sendRequest(
      verb: 'DELETE',
      path: 'v2/messages/receipt',
      body: receipt.writeToBuffer(),
      id: requestId,
    );
  }
}

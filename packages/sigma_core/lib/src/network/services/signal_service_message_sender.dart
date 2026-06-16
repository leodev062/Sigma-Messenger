import 'dart:convert';
import 'package:fixnum/fixnum.dart';
import 'package:sigma_core/src/domain/services/i_socket_service.dart';
import 'package:sigma_core/src/network/pb/common.pb.dart' as common_pb;
import 'package:sigma_core/src/network/pb/envelope.pb.dart' as env_pb;
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:sigma_core/src/network/pb/websocket.pb.dart' as ws_pb;
import 'package:sigma_core/src/util/identity.dart';

// Exportando para facilitar uso
export 'package:sigma_core/src/network/pb/common.pb.dart' show EntityType;

/// EnvelopeType - Enum simulado para compatibilidade com o protocolo do servidor.
class EnvelopeType {
  static const int UNKNOWN = 0;
  static const int CIPHERTEXT = 1;
  static const int KEY_EXCHANGE = 2;
  static const int PREKEY_BUNDLE = 3;
  static const int RECEIPT = 4;
  static const int DATA_MESSAGE = 5;
}

/// SignalServiceMessageSender - Responsável por empacotar e transmitir envelopes.
/// Refatorado para o padrão Relay Protobuf (agente-server.md).
abstract class SignalServiceMessageSender {
  Stream<ws_pb.WebSocketMessage> get messageStream;
  void sendEnvelope(String chatId, String encryptedEnvelope, {String destinationType = "USER"});
  void sendUnencryptedEnvelope(String chatId, sigmapb.Message message, {String destinationType = "USER"});
  void acknowledgeReceipt(String requestId);
}

class SignalServiceMessageSenderImpl implements SignalServiceMessageSender {
  final ISocketService _socketService;

  SignalServiceMessageSenderImpl(this._socketService);

  @override
  Stream<ws_pb.WebSocketMessage> get messageStream => _socketService.messages;

  common_pb.EntityType _mapType(String type) {
    switch (type.toUpperCase()) {
      case "BOT": return common_pb.EntityType.BOT;
      case "GROUP": return common_pb.EntityType.GROUP;
      case "CHANNEL": return common_pb.EntityType.CHANNEL;
      case "USER":
      default:
        return common_pb.EntityType.USER;
    }
  }

  @override
  void sendEnvelope(String chatId, String encryptedEnvelope, {String destinationType = "USER"}) {
    // 1. Criar Envelope (Relay Style)
    final envelope = env_pb.Envelope()
      ..type = EnvelopeType.CIPHERTEXT
      ..source = Identity.currentUserId
      ..timestamp = Int64(DateTime.now().millisecondsSinceEpoch)
      ..payload = base64Decode(encryptedEnvelope)
      ..destinationType = _mapType(destinationType)
      ..destinationId = chatId;

    // 2. Transmitir via Websocket Request
    _socketService.sendRequest(
      verb: 'PUT',
      path: 'v2/messages/$chatId',
      body: envelope.writeToBuffer(),
    );
  }

  @override
  void sendUnencryptedEnvelope(String chatId, sigmapb.Message message, {String destinationType = "USER"}) {
    // Garantir que os campos EIRA estejam preenchidos na Message interna
    message.destinationId = chatId;
    message.destinationType = _mapType(destinationType);
    message.senderId = Identity.currentUserId;
    message.senderType = common_pb.EntityType.USER;

    // 1. Criar Envelope (Relay Style)
    final envelope = env_pb.Envelope()
      ..type = EnvelopeType.DATA_MESSAGE
      ..source = Identity.currentUserId
      ..timestamp = Int64(DateTime.now().millisecondsSinceEpoch)
      ..payload = message.writeToBuffer()
      ..destinationType = _mapType(destinationType)
      ..destinationId = chatId;

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
    final receipt = env_pb.Envelope()
      ..type = EnvelopeType.RECEIPT
      ..timestamp = Int64(DateTime.now().millisecondsSinceEpoch)
      ..envelopeId = requestId;

    _socketService.sendRequest(
      verb: 'DELETE',
      path: 'v2/messages/receipt',
      body: receipt.writeToBuffer(),
      id: requestId,
    );
  }
}

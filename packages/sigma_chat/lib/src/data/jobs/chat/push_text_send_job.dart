import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as fixnum;

/// PushTextSendJob - Refatorado para o padrão Relay Protobuf (agente-server.md).
class PushTextSendJob extends core.Job {
  static const String KEY = "PushTextSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final SignalServiceMessageSender? messageSender;

  PushTextSendJob({
    required this.messageId,
    this.chatRepository,
    this.messageSender,
    int? databaseId,
  }) : super(
         databaseId: databaseId,
         factoryKey: KEY,
         queueKey: "msg_$messageId",
         priority: JobPriority.high,
       );

  @override
  Map<String, dynamic> serialize() => {'messageId': messageId};

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushTextSendJob(
      messageId: data['messageId'],
      chatRepository: locator<IChatRepository>(),
      messageSender: locator<SignalServiceMessageSender>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    try {
      debugPrint("DEBUG PushTextSendJob: Starting run for $messageId");

      final message = await chatRepository!.getMessage(messageId);
      if (message == null) {
        SigmaLog.w(KEY, "Mensagem não encontrada no banco: $messageId");
        return;
      }

      if (message.status != MessageStatusEntity.pending) {
        SigmaLog.w(KEY, "Mensagem $messageId já processada. Abortando.");
        return;
      }

      // Criar sigmapb.Message (Protobuf seguindo agente-server.md)
      final relayMessage = sigmapb.Message()
        ..id = message.id
        ..conversationId = message.chatId
        ..senderId = message.senderId
        ..receiverId = message.chatId
        ..type = sigmapb.MessageType.TEXT
        ..timestamp = fixnum.Int64(message.timestamp)
        ..status = sigmapb.MessageStatus.SENT
        ..text = (sigmapb.TextContent()..text = message.textContent);

      SigmaLog.d(KEY, "Transmitindo Message via Relay para ${message.chatId}...");
      
      messageSender!.sendUnencryptedEnvelope(message.chatId, relayMessage);

      await chatRepository!.updateMessageStatus(
        messageId,
        MessageStatusEntity.sent,
      );
      debugPrint("DEBUG PushTextSendJob: Job COMPLETED for $messageId");
    } catch (e, stack) {
      SigmaLog.e(KEY, "Erro crítico no envio da mensagem $messageId", e, stack);
      rethrow;
    }
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio da mensagem $messageId", error);
  }
}

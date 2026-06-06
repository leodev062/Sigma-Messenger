import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// PushTextSendJob - Equivalente ao PushTextSendJob.java do Signal.
class PushTextSendJob extends Job {
  static const String KEY = "PushTextSendJob";
  final String messageId;
  final IChatRepository? chatRepository;
  final CryptoManager? cryptoManager;
  final SignalServiceMessageSender? messageSender;

  PushTextSendJob({
    required this.messageId,
    this.chatRepository,
    this.cryptoManager,
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

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushTextSendJob(
      messageId: data['messageId'],
      chatRepository: locator<IChatRepository>(),
      cryptoManager: locator<CryptoManager>(),
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
        debugPrint("DEBUG PushTextSendJob: Message NOT FOUND: $messageId");
        // Marcar como failed se não encontrar
        await chatRepository!.updateMessageStatus(
          messageId,
          MessageStatusEntity.pending,
        );
        return;
      }

      if (message.status != MessageStatusEntity.pending) {
        SigmaLog.w(
          KEY,
          "Mensagem $messageId já está com status: ${message.status}. Abortando envio.",
        );
        debugPrint(
          "DEBUG PushTextSendJob: Message ALREADY PROCESSED: $messageId status: ${message.status}",
        );
        return;
      }

      SigmaLog.d(KEY, "Inicializando CryptoManager...");
      debugPrint("DEBUG PushTextSendJob: Initializing Crypto...");
      await cryptoManager!.init();

      SigmaLog.d(KEY, "Encriptando payload...");
      debugPrint("DEBUG PushTextSendJob: Encrypting payload (Protobuf)...");

      // Criar Content com DataMessage (Protobuf)
      final content = sigmapb.Content()
        ..dataMessage = (sigmapb.DataMessage()..body = message.textContent);

      final encryptedEnvelope = await cryptoManager!.encryptMessage(
        message.chatId,
        content,
      );

      SigmaLog.d(KEY, "Transmitindo envelope via WebSocket...");
      debugPrint("DEBUG PushTextSendJob: Sending via WebSocket...");

      // Enviar e aguardar confirmação (com timeout)
      try {
        messageSender!.sendEnvelope(message.chatId, encryptedEnvelope);

        // Aguardar confirmação com timeout de 30 segundos
        await Future.delayed(const Duration(milliseconds: 500));

        SigmaLog.d(KEY, "Atualizando status para 'sent'...");
        debugPrint("DEBUG PushTextSendJob: Updating status to SENT...");
        await chatRepository!.updateMessageStatus(
          messageId,
          MessageStatusEntity.sent,
        );
        debugPrint("DEBUG PushTextSendJob: Job COMPLETED for $messageId");
      } catch (sendError) {
        SigmaLog.e(KEY, "Erro ao transmitir envelope: $sendError");
        await chatRepository!.updateMessageStatus(
          messageId,
          MessageStatusEntity.pending,
        );
        rethrow;
      }
    } catch (e, stack) {
      debugPrint(
        "DEBUG PushTextSendJob: CRITICAL ERROR sending message $messageId: $e",
      );
      debugPrint("DEBUG PushTextSendJob: STACKTRACE: $stack");
      rethrow;
    }
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Erro no envio da mensagem $messageId", error);
  }
}

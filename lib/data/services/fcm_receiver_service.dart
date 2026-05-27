import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sigma/app/locator.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/core/notifications/notification_service.dart';
import 'package:sigma/core/storage/sigma_store.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';

/// Serviço que processa mensagens recebidas via FCM (Push Decrypt Job).
/// Funciona tanto em Foreground quanto em Background (Isolate separado).
class FcmReceiverService {
  static const String _tag = "FcmReceiverService";

  /// Processa a mensagem vinda do Firebase.
  /// Se em background, inicializa as dependências críticas sob demanda.
  Future<void> handleMessage(RemoteMessage message, {bool isBackground = false}) async {
    SigmaLog.d(_tag, "Processando mensagem FCM. Background: $isBackground");

    final data = message.data;
    final senderId = data['sender_id'];
    final chatId = data['chat_id'];
    final envelope = data['envelope'];

    if (senderId == null || chatId == null || envelope == null) {
      SigmaLog.w(_tag, "Mensagem FCM inválida ou incompleta. Ignorando.");
      return;
    }

    try {
      // 1. Garantir que dependências críticas estão prontas (especialmente em background)
      if (isBackground) {
        await SigmaStore.instance.init();
        setupLocator(); 
        // Nota: O AppDatabase é inicializado via LazySingleton no setupLocator()
      }

      final cryptoManager = locator<CryptoManager>();
      final chatRepository = locator<IChatRepository>();
      final notificationService = locator<NotificationService>();

      // 2. Desencriptar envelope Signal
      await cryptoManager.init();
      final payload = await cryptoManager.decryptMessage(senderId, envelope);
      final decryptedText = payload.text ?? "";
      final attachment = payload.attachment;

      // 3. Persistir no Banco Blindado (SQLCipher)
      final now = DateTime.now().millisecondsSinceEpoch;
      await chatRepository.saveMessage(
        id: "fcm_$now",
        chatId: chatId,
        senderId: senderId,
        text: decryptedText,
        isFromMe: false,
        status: MessageStatusEntity.read,
        attachmentUrl: attachment?.attachmentId,
        attachmentAesKey: attachment?.aesKey,
        attachmentIv: attachment?.iv,
        attachmentMacKey: attachment?.digest,
      );

      await chatRepository.updateChatMetadata(
        chatId: chatId,
        lastMessage: decryptedText.isEmpty && attachment != null ? "📎 Anexo" : decryptedText,
        timestamp: now,
      );

      // 4. Mostrar Notificação Nativa
      await notificationService.showNewMessageNotification(
        senderName: "Mensagem de $senderId", // Pode ser melhorado buscando o nome real do contato
        decryptedText: decryptedText,
        chatId: chatId,
      );

      SigmaLog.i(_tag, "Mensagem FCM processada, salva e notificada.");
    } catch (e, stack) {
      SigmaLog.e(_tag, "Erro ao processar push message", e, stack);
    }
  }
}

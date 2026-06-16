import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/sigma_chat.dart';

/// FcmReceiverService - Refatorado para POO com Loggable.
class FcmReceiverService with Loggable {

  final IChatRepository _chatRepository;
  final NotificationService _notificationService;

  FcmReceiverService({
    required IChatRepository chatRepository,
    required NotificationService notificationService,
  })  : _chatRepository = chatRepository,
        _notificationService = notificationService;

  Future<void> handleMessage(RemoteMessage message, {bool isBackground = false}) async {
    logD("Processando mensagem FCM. Background: $isBackground");

    if (isBackground) {
      await _initializeBackground();
    }

    final pushData = _IncomingPushData.fromRemoteMessage(message);
    if (!pushData.isValid) {
      logW("Mensagem FCM inválida. Ignorando.");
      return;
    }

    try {
      await _processPush(pushData);
    } catch (e, stack) {
      logE("Erro ao processar push message", e, stack);
    }
  }

  Future<void> _initializeBackground() async {
    await locator<SigmaStore>().init();
  }

  Future<void> _processPush(_IncomingPushData data) async {
    final senderId = data.senderId!;
    final chatId = data.chatId!;
    final envelopeBase64 = data.envelope!;

    final envelopeBytes = base64Decode(envelopeBase64);
    final envelope = Envelope.fromBuffer(envelopeBytes);
    
    // Na nova arquitetura, o envelope contém o payload diretamente (Relay Only)
    final payload = Message.fromBuffer(envelope.payload);
    
    await _chatRepository.getOrCreateThread(chatId);
    final now = DateTime.now().millisecondsSinceEpoch;

    final message = MessageEntity(
      id: payload.messageId.isNotEmpty ? payload.messageId : "fcm_$now",
      conversationId: chatId,
      senderId: senderId,
      textContent: payload.hasText() ? payload.text.text : "",
      type: MessageTypeEntity.text,
      timestamp: now,
      status: MessageStatusEntity.delivered,
    );

    await _chatRepository.saveMessageAndMetadata(message);

    await _notificationService.showNewMessageNotification(
      senderName: "Mensagem de $senderId",
      decryptedText: message.textContent,
      chatId: chatId,
    );

    logI("Mensagem Push processada: ${message.id}");
  }
}

class _IncomingPushData {
  final String? senderId;
  final String? chatId;
  final String? envelope;

  _IncomingPushData({this.senderId, this.chatId, this.envelope});

  factory _IncomingPushData.fromRemoteMessage(RemoteMessage message) {
    return _IncomingPushData(
      senderId: message.data['sender_id']?.toString(),
      chatId: message.data['chat_id']?.toString(),
      envelope: message.data['envelope']?.toString(),
    );
  }

  bool get isValid => senderId != null && chatId != null && envelope != null;
}

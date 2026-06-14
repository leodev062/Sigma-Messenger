import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;
import 'package:fixnum/fixnum.dart' as fixnum;

/// PushMediaSendJob - Gerencia o upload e envio de mídia Relay.
class PushMediaSendJob extends core.Job {
  static const String KEY = "PushMediaSendJob";
  
  final String messageId;
  final String filePath;
  final String chatId;

  final AttachmentManager? attachmentManager;
  final SignalServiceMessageSender? messageSender;
  final IChatRepository? chatRepository;

  PushMediaSendJob({
    required this.messageId,
    required this.filePath,
    required this.chatId,
    this.attachmentManager,
    this.messageSender,
    this.chatRepository,
    int? databaseId,
  })  : super(
          databaseId: databaseId, 
          factoryKey: KEY,
          queueKey: "media_$messageId",
          priority: JobPriority.high, 
        );

  @override
  Map<String, dynamic> serialize() => {
    'messageId': messageId,
    'filePath': filePath,
    'chatId': chatId,
  };

  static core.Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushMediaSendJob(
      messageId: data['messageId'],
      filePath: data['filePath'],
      chatId: data['chatId'],
      attachmentManager: locator<AttachmentManager>(),
      messageSender: locator<SignalServiceMessageSender>(),
      chatRepository: locator<IChatRepository>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception("Arquivo não encontrado.");

    final message = await chatRepository!.getMessage(messageId);
    if (message == null) return;

    final bytes = await file.readAsBytes();
    final requestResponse = await attachmentManager!.requestUpload(bytes.length);
    
    await attachmentManager!.uploadEncryptedBytes(
      requestResponse.uploadUrl,
      bytes,
    );

    final relayMessage = sigmapb.Message()
      ..id = message.id
      ..conversationId = message.chatId
      ..senderId = "me"
      ..receiverId = message.chatId
      ..timestamp = fixnum.Int64(message.timestamp);

    if (message.type == MessageTypeEntity.image) {
      relayMessage.type = sigmapb.MessageType.IMAGE;
      relayMessage.image = (sigmapb.ImageContent()
        ..url = requestResponse.uploadUrl
        ..thumbnail = "");
    } else if (message.type == MessageTypeEntity.video) {
      relayMessage.type = sigmapb.MessageType.VIDEO;
      relayMessage.video = (sigmapb.VideoContent()
        ..url = requestResponse.uploadUrl);
    } else if (message.type == MessageTypeEntity.audio) {
      relayMessage.type = sigmapb.MessageType.AUDIO;
      relayMessage.audio = (sigmapb.AudioContent()
        ..url = requestResponse.uploadUrl);
    }

    messageSender!.sendUnencryptedEnvelope(chatId, relayMessage);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Falha no envio de mídia Relay.", error);
  }
}

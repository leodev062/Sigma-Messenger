import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_chat/src/domain/i_chat_repository.dart';
import 'package:sigma_database/sigma_database.dart';


import 'dart:convert';
import 'package:sigma_core/src/network/pb/message.pb.dart' as sigmapb;

/// PushMediaSendJob - Gerencia o upload e envio de mídia resiliente.
class PushMediaSendJob extends Job {
  static const String KEY = "PushMediaSendJob";
  
  final String messageId;
  final String filePath;
  final String chatId;

  final MediaCryptoService? mediaCrypto;
  final AttachmentManager? attachmentManager;
  final CryptoManager? cryptoManager;
  final SignalServiceMessageSender? messageSender;
  final IChatRepository? chatRepository;
  final AttachmentTable? attachmentTable;

  PushMediaSendJob({
    required this.messageId,
    required this.filePath,
    required this.chatId,
    this.mediaCrypto,
    this.attachmentManager,
    this.cryptoManager,
    this.messageSender,
    this.chatRepository,
    this.attachmentTable,
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

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return PushMediaSendJob(
      messageId: data['messageId'],
      filePath: data['filePath'],
      chatId: data['chatId'],
      mediaCrypto: locator<MediaCryptoService>(),
      attachmentManager: locator<AttachmentManager>(),
      cryptoManager: locator<CryptoManager>(),
      messageSender: locator<SignalServiceMessageSender>(),
      chatRepository: locator<IChatRepository>(),
      attachmentTable: locator<AttachmentTable>(),
      databaseId: databaseId,
    );
  }

  @override
  Future<void> run() async {
    final file = File(filePath);
    if (!await file.exists()) throw Exception("Arquivo não encontrado.");

    final encryptedMedia = await mediaCrypto!.encryptFile(file);
    final requestResponse = await attachmentManager!.requestUpload(encryptedMedia.ciphertext.length);
    
    await attachmentManager!.uploadEncryptedBytes(
      requestResponse.uploadUrl,
      encryptedMedia.ciphertext,
    );

    // TODO: Obter o ID real do anexo para vincular no banco
    await attachmentTable!.updateLocalPath(0, filePath);

    final pointer = sigmapb.AttachmentPointer()
      ..id = requestResponse.attachmentId
      ..key = base64Decode(encryptedMedia.aesKeyBase64)
      ..iv = base64Decode(encryptedMedia.ivBase64)
      ..digest = base64Decode(encryptedMedia.digestBase64)
      ..fileName = file.path.split('/').last
      ..size = encryptedMedia.ciphertext.length;

    await cryptoManager!.init();
    
    final content = sigmapb.Content()
      ..dataMessage = (sigmapb.DataMessage()..attachment = pointer);

    final encryptedEnvelope = await cryptoManager!.encryptMessage(
      chatId,
      content,
    );

    messageSender!.sendEnvelope(chatId, encryptedEnvelope);
    await chatRepository!.updateMessageStatus(messageId, MessageStatusEntity.sent);
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Falha no envio de mídia.", error);
  }
}

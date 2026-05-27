import 'dart:io';
import 'package:sigma/core/crypto/media_crypto_service.dart';
import 'package:sigma/core/network/attachment_manager.dart';
import 'package:sigma/core/crypto/crypto_manager.dart';
import 'package:sigma/data/datasources/chat/chat_remote_data_source.dart';
import 'package:sigma/domain/repositories/i_chat_repository.dart';
import 'package:sigma/data/models/signal_payload.dart';
import 'package:sigma/domain/entities/message_entity.dart';
import 'package:sigma/core/util/sigma_log.dart';
import 'package:path/path.dart' as p;

class SendMediaInteractor {
  final MediaCryptoService _mediaCrypto;
  final AttachmentManager _attachmentManager;
  final CryptoManager _cryptoManager;
  final ChatRemoteDataSource _remoteDataSource;
  final IChatRepository _chatRepository;

  static const String _tag = "SendMediaInteractor";

  SendMediaInteractor(
    this._mediaCrypto,
    this._attachmentManager,
    this._cryptoManager,
    this._remoteDataSource,
    this._chatRepository,
  );

  Future<void> execute({
    required String chatId,
    required String senderId,
    required File file,
  }) async {
    final messageId = DateTime.now().millisecondsSinceEpoch.toString();
    SigmaLog.d(_tag, "Iniciando fluxo de envio de mídia E2EE para $chatId");

    try {
      // 1. Encriptação local do arquivo (AES-GCM)
      final encryptedMedia = await _mediaCrypto.encryptFile(file);
      SigmaLog.d(_tag, "Arquivo encriptado localmente.");

      // 2. Solicitar URL de upload ao servidor Go
      final requestResponse = await _attachmentManager.requestUpload(encryptedMedia.ciphertext.length);
      SigmaLog.d(_tag, "URL de upload obtida: ${requestResponse.attachmentId}");

      // 3. Upload dos bytes encriptados via HTTPS
      await _attachmentManager.uploadEncryptedBytes(
        requestResponse.uploadUrl,
        encryptedMedia.ciphertext,
      );
      SigmaLog.i(_tag, "Upload concluído com sucesso.");

      // 4. Criar o Ponteiro do Anexo (AttachmentPointer)
      final pointer = AttachmentPointer(
        attachmentId: requestResponse.attachmentId,
        aesKey: encryptedMedia.aesKeyBase64,
        iv: encryptedMedia.ivBase64,
        digest: encryptedMedia.digestBase64,
        fileName: p.basename(file.path),
        size: encryptedMedia.ciphertext.length,
      );

      // 5. Salvar mensagem pendente localmente
      await _chatRepository.saveMessage(
        id: messageId,
        chatId: chatId,
        senderId: senderId,
        text: "📷 Foto", // Placeholder para a UI
        isFromMe: true,
        status: MessageStatusEntity.pending,
        attachmentUrl: requestResponse.attachmentId,
        attachmentAesKey: pointer.aesKey,
        attachmentIv: pointer.iv,
        attachmentMacKey: pointer.digest,
      );

      // 6. Encriptar a sinalização via Signal Protocol (A fechadura principal)
      await _cryptoManager.init();
      final signalPayload = SignalPayload(attachment: pointer);
      final encryptedEnvelope = await _cryptoManager.encryptMessage(
        chatId,
        signalPayload,
      );

      // 7. Enviar o envelope via WebSocket
      _remoteDataSource.sendEnvelope(chatId, encryptedEnvelope);

      // 8. Marcar como enviado no banco local
      await _chatRepository.updateMessageStatus(messageId, MessageStatusEntity.sent);
      SigmaLog.i(_tag, "Sinalização de mídia enviada via WebSocket.");

    } catch (e, stack) {
      SigmaLog.e(_tag, "Falha no envio de mídia E2EE", e, stack);
      await _chatRepository.updateMessageStatus(messageId, MessageStatusEntity.pending); // Mantém como pendente para retry
      rethrow;
    }
  }
}

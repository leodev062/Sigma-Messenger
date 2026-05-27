import 'dart:convert';

/// Ponteiro para um anexo encriptado (Baseado na estrutura do Signal).
class AttachmentPointer {
  final String attachmentId;
  final String aesKey;
  final String iv;
  final String digest;
  final String? fileName;
  final int? size;

  AttachmentPointer({
    required this.attachmentId,
    required this.aesKey,
    required this.iv,
    required this.digest,
    this.fileName,
    this.size,
  });

  Map<String, dynamic> toJson() => {
    'attachmentId': attachmentId,
    'aesKey': aesKey,
    'iv': iv,
    'digest': digest,
    if (fileName != null) 'fileName': fileName,
    if (size != null) 'size': size,
  };

  factory AttachmentPointer.fromJson(Map<String, dynamic> json) => AttachmentPointer(
    attachmentId: json['attachmentId'].toString(),
    aesKey: json['aesKey'] as String,
    iv: json['iv'] as String,
    digest: json['digest'] as String,
    fileName: json['fileName'] as String?,
    size: json['size'] as int?,
  );
}

/// Estrutura de dados que vai dentro do envelope encriptado do Signal Protocol.
class SignalPayload {
  final String? text;
  final AttachmentPointer? attachment;

  SignalPayload({
    this.text,
    this.attachment,
  });

  Map<String, dynamic> toJson() => {
    if (text != null) 'text': text,
    if (attachment != null) 'attachment': attachment!.toJson(),
  };

  factory SignalPayload.fromJson(Map<String, dynamic> json) => SignalPayload(
    text: json['text'] as String?,
    attachment: json['attachment'] != null 
        ? AttachmentPointer.fromJson(json['attachment'] as Map<String, dynamic>)
        : null,
  );

  String serialize() => jsonEncode(toJson());

  factory SignalPayload.deserialize(String data) => 
      SignalPayload.fromJson(jsonDecode(data) as Map<String, dynamic>);
}

import 'dart:convert';

/// Ponteiro para um anexo encriptado.
class AttachmentPointer {
  final String url;
  final String aesKeyBase64;
  final String macKeyBase64;
  final String? fileName;
  final int? size;

  AttachmentPointer({
    required this.url,
    required this.aesKeyBase64,
    required this.macKeyBase64,
    this.fileName,
    this.size,
  });

  Map<String, dynamic> toJson() => {
    'url': url,
    'aesKey': aesKeyBase64,
    'macKey': macKeyBase64,
    'fileName': fileName,
    'size': size,
  };

  factory AttachmentPointer.fromJson(Map<String, dynamic> json) => AttachmentPointer(
    url: json['url'] as String,
    aesKeyBase64: json['aesKey'] as String,
    macKeyBase64: json['macKey'] as String,
    fileName: json['fileName'] as String?,
    size: json['size'] as int?,
  );
}

/// Estrutura de dados que vai dentro do envelope encriptado do Signal.
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

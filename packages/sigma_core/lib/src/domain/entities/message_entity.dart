import 'dart:math';
import 'package:sigma_core/src/domain/entities/reaction_entity.dart';

enum MessageTypeEntity { text, image, video, audio, file, location, gif, poll }
enum MessageStatusEntity { pending, sent, delivered, read }

/// MessageEntity - Entidade de domínio representando uma mensagem.
class MessageEntity {
  final String _id;
  final int _threadId;
  final String _chatId;
  final String _senderRecipientId;
  final String _textContent;
  final MessageTypeEntity _type;
  final int _timestamp;
  final MessageStatusEntity _status;
  final bool _isFromMe;
  final List<ReactionEntity> _reactions;

  // Campos de anexo encapsulados
  final String? _attachmentUrl;
  final String? _attachmentAesKey;
  final String? _attachmentIv;
  final String? _attachmentMacKey;

  // Localização
  final double? _latitude;
  final double? _longitude;

  // Enquete
  final String? _pollQuestion;
  final List<String>? _pollOptions;
  final bool? _allowMultipleVotes;

  // Getters públicos
  String get id => _id;
  int get threadId => _threadId;
  String get chatId => _chatId;
  String get senderRecipientId => _senderRecipientId;
  String get textContent => _textContent;
  MessageTypeEntity get type => _type;
  int get timestamp => _timestamp;
  MessageStatusEntity get status => _status;
  bool get isFromMe => _isFromMe;
  List<ReactionEntity> get reactions => _reactions;

  String? get attachmentUrl => _attachmentUrl;
  String? get attachmentAesKey => _attachmentAesKey;
  String? get attachmentIv => _attachmentIv;
  String? get attachmentMacKey => _attachmentMacKey;

  double? get latitude => _latitude;
  double? get longitude => _longitude;

  String? get pollQuestion => _pollQuestion;
  List<String>? get pollOptions => _pollOptions;
  bool? get allowMultipleVotes => _allowMultipleVotes;

  MessageEntity({
    required String id,
    required int threadId,
    required String chatId,
    required String senderRecipientId,
    required String textContent,
    required MessageTypeEntity type,
    required int timestamp,
    required MessageStatusEntity status,
    required bool isFromMe,
    List<ReactionEntity> reactions = const [],
    String? attachmentUrl,
    String? attachmentAesKey,
    String? attachmentIv,
    String? attachmentMacKey,
    double? latitude,
    double? longitude,
    String? pollQuestion,
    List<String>? pollOptions,
    bool? allowMultipleVotes,
  })  : _id = id,
        _threadId = threadId,
        _chatId = chatId,
        _senderRecipientId = senderRecipientId,
        _textContent = textContent,
        _type = type,
        _timestamp = timestamp,
        _status = status,
        _isFromMe = isFromMe,
        _reactions = reactions,
        _attachmentUrl = attachmentUrl,
        _attachmentAesKey = attachmentAesKey,
        _attachmentIv = attachmentIv,
        _attachmentMacKey = attachmentMacKey,
        _latitude = latitude,
        _longitude = longitude,
        _pollQuestion = pollQuestion,
        _pollOptions = pollOptions,
        _allowMultipleVotes = allowMultipleVotes;

  factory MessageEntity.createTextOutgoing({
    required int threadId,
    required String chatId,
    required String senderId,
    required String text,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_${now}_${Random().nextInt(1000)}",
      threadId: threadId,
      chatId: chatId,
      senderRecipientId: senderId,
      textContent: text,
      type: MessageTypeEntity.text,
      timestamp: now,
      status: MessageStatusEntity.pending,
      isFromMe: true,
    );
  }

  factory MessageEntity.createMediaOutgoing({
    required int threadId,
    required String chatId,
    required String senderId,
    required MessageTypeEntity type,
    String textContent = "",
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_media_${now}_${Random().nextInt(1000)}",
      threadId: threadId,
      chatId: chatId,
      senderRecipientId: senderId,
      textContent: textContent,
      type: type,
      timestamp: now,
      status: MessageStatusEntity.pending,
      isFromMe: true,
    );
  }

  factory MessageEntity.createLocationOutgoing({
    required int threadId,
    required String chatId,
    required String senderId,
    required double latitude,
    required double longitude,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_loc_${now}_${Random().nextInt(1000)}",
      threadId: threadId,
      chatId: chatId,
      senderRecipientId: senderId,
      textContent: "📍 Localização",
      type: MessageTypeEntity.location,
      timestamp: now,
      status: MessageStatusEntity.pending,
      isFromMe: true,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory MessageEntity.createPollOutgoing({
    required int threadId,
    required String chatId,
    required String senderId,
    required String question,
    required List<String> options,
    bool allowMultipleVotes = false,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_poll_${now}_${Random().nextInt(1000)}",
      threadId: threadId,
      chatId: chatId,
      senderRecipientId: senderId,
      textContent: "📊 Enquete: $question",
      type: MessageTypeEntity.poll,
      timestamp: now,
      status: MessageStatusEntity.pending,
      isFromMe: true,
      pollQuestion: question,
      pollOptions: options,
      allowMultipleVotes: allowMultipleVotes,
    );
  }

  String get snippet {
    if (_type == MessageTypeEntity.text) return _textContent;
    switch (_type) {
      case MessageTypeEntity.image: return "📷 Foto";
      case MessageTypeEntity.video: return "🎥 Vídeo";
      case MessageTypeEntity.audio: return "🎵 Áudio";
      case MessageTypeEntity.file: return "📎 Arquivo";
      case MessageTypeEntity.location: return "📍 Localização";
      case MessageTypeEntity.gif: return "👾 GIF";
      case MessageTypeEntity.poll: return "📊 Enquete";
      default: return "";
    }
  }

  bool get hasAttachment => _attachmentUrl != null || _type != MessageTypeEntity.text;
}

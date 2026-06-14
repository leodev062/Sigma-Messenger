import 'dart:math';
import 'package:sigma_core/src/domain/entities/reaction_entity.dart';
import 'package:sigma_core/src/util/identity.dart';

enum MessageTypeEntity { text, image, video, audio, poll, reply, reaction, location, file, gif }
enum MessageStatusEntity { pending, sent, delivered, read, failed }

/// MessageEntity - Entidade de domínio representando uma mensagem.
class MessageEntity {
  final String _id;
  final String _conversationId;
  final String _senderId;
  final String _textContent;
  final MessageTypeEntity _type;
  final int _timestamp;
  final int _updatedAt;
  final MessageStatusEntity _status;
  final List<ReactionEntity> _reactions;

  // Conteúdos específicos
  final String? _url;
  final String? _thumbnail;
  final int? _width;
  final int? _height;
  final int? _duration;
  
  // Enquete
  final String? _pollQuestion;
  final List<String>? _pollOptions;
  final bool? _multipleChoice;

  // Resposta/Reação
  final String? _relatedMessageId;
  final String? _emoji;

  // Localização
  final double? _latitude;
  final double? _longitude;

  // Getters públicos
  String get id => _id;
  String get conversationId => _conversationId;
  String get chatId => _conversationId; // Alias for compatibility
  String get senderId => _senderId;
  String get textContent => _textContent;
  MessageTypeEntity get type => _type;
  int get timestamp => _timestamp;
  int get updatedAt => _updatedAt;
  MessageStatusEntity get status => _status;
  bool get isFromMe => _senderId == Identity.currentUserId;
  List<ReactionEntity> get reactions => _reactions;

  String? get url => _url;
  String? get thumbnail => _thumbnail;
  int? get width => _width;
  int? get height => _height;
  int? get duration => _duration;

  String? get pollQuestion => _pollQuestion;
  List<String>? get pollOptions => _pollOptions;
  bool? get multipleChoice => _multipleChoice;

  String? get relatedMessageId => _relatedMessageId;
  String? get emoji => _emoji;

  double? get latitude => _latitude;
  double? get longitude => _longitude;

  MessageEntity({
    required String id,
    required String conversationId,
    required String senderId,
    required String textContent,
    required MessageTypeEntity type,
    required int timestamp,
    int? updatedAt,
    required MessageStatusEntity status,
    List<ReactionEntity> reactions = const [],
    String? url,
    String? thumbnail,
    int? width,
    int? height,
    int? duration,
    String? pollQuestion,
    List<String>? pollOptions,
    bool? multipleChoice,
    String? relatedMessageId,
    String? emoji,
    double? latitude,
    double? longitude,
  })  : _id = id,
        _conversationId = conversationId,
        _senderId = senderId,
        _textContent = textContent,
        _type = type,
        _timestamp = timestamp,
        _updatedAt = updatedAt ?? timestamp,
        _status = status,
        _reactions = reactions,
        _url = url,
        _thumbnail = thumbnail,
        _width = width,
        _height = height,
        _duration = duration,
        _pollQuestion = pollQuestion,
        _pollOptions = pollOptions,
        _multipleChoice = multipleChoice,
        _relatedMessageId = relatedMessageId,
        _emoji = emoji,
        _latitude = latitude,
        _longitude = longitude;

  factory MessageEntity.createTextOutgoing({
    required String conversationId,
    required String senderId,
    required String text,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_${now}_${Random().nextInt(1000)}",
      conversationId: conversationId,
      senderId: senderId,
      textContent: text,
      type: MessageTypeEntity.text,
      timestamp: now,
      status: MessageStatusEntity.pending,
    );
  }

  factory MessageEntity.createLocationOutgoing({
    required String conversationId,
    required String senderId,
    required double latitude,
    required double longitude,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_loc_${now}_${Random().nextInt(1000)}",
      conversationId: conversationId,
      senderId: senderId,
      textContent: "Localização",
      type: MessageTypeEntity.location,
      timestamp: now,
      status: MessageStatusEntity.pending,
      latitude: latitude,
      longitude: longitude,
    );
  }

  factory MessageEntity.createPollOutgoing({
    required String conversationId,
    required String senderId,
    required String question,
    required List<String> options,
    required bool allowMultipleVotes,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return MessageEntity(
      id: "msg_poll_${now}_${Random().nextInt(1000)}",
      conversationId: conversationId,
      senderId: senderId,
      textContent: question,
      type: MessageTypeEntity.poll,
      timestamp: now,
      status: MessageStatusEntity.pending,
      pollQuestion: question,
      pollOptions: options,
      multipleChoice: allowMultipleVotes,
    );
  }

  String get snippet {
    if (_type == MessageTypeEntity.text) return _textContent;
    switch (_type) {
      case MessageTypeEntity.image: return "📷 Foto";
      case MessageTypeEntity.video: return "🎥 Vídeo";
      case MessageTypeEntity.audio: return "🎵 Áudio";
      case MessageTypeEntity.poll: return "📊 Enquete";
      case MessageTypeEntity.reply: return "💬 Resposta";
      case MessageTypeEntity.reaction: return "❤️ Reação";
      case MessageTypeEntity.location: return "📍 Localização";
      case MessageTypeEntity.file: return "📁 Arquivo";
      case MessageTypeEntity.gif: return "👾 GIF";
      default: return "";
    }
  }
}

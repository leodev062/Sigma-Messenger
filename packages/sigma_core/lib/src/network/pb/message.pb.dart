// This is a generated file - do not edit.
//
// Generated from message.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $0;
import 'message.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'message.pbenum.dart';

enum Message_Content {
  text,
  dataMessage,
  receipt,
  typing,
  sync,
  pollVote,
  image,
  video,
  audio,
  poll,
  reaction,
  notSet
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? messageId,
    $core.String? conversationId,
    $core.String? senderId,
    $0.EntityType? senderType,
    $core.String? destinationId,
    $0.EntityType? destinationType,
    $core.int? type,
    $fixnum.Int64? timestamp,
    $fixnum.Int64? updatedAt,
    $core.int? status,
    TextContent? text,
    DataMessage? dataMessage,
    ReceiptMessage? receipt,
    TypingMessage? typing,
    SyncMessage? sync,
    PollVote? pollVote,
    ImageContent? image,
    VideoContent? video,
    AudioContent? audio,
    PollContent? poll,
    ReactionContent? reaction,
  }) {
    final result = create();
    if (messageId != null) result.messageId = messageId;
    if (conversationId != null) result.conversationId = conversationId;
    if (senderId != null) result.senderId = senderId;
    if (senderType != null) result.senderType = senderType;
    if (destinationId != null) result.destinationId = destinationId;
    if (destinationType != null) result.destinationType = destinationType;
    if (type != null) result.type = type;
    if (timestamp != null) result.timestamp = timestamp;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (status != null) result.status = status;
    if (text != null) result.text = text;
    if (dataMessage != null) result.dataMessage = dataMessage;
    if (receipt != null) result.receipt = receipt;
    if (typing != null) result.typing = typing;
    if (sync != null) result.sync = sync;
    if (pollVote != null) result.pollVote = pollVote;
    if (image != null) result.image = image;
    if (video != null) result.video = video;
    if (audio != null) result.audio = audio;
    if (poll != null) result.poll = poll;
    if (reaction != null) result.reaction = reaction;
    return result;
  }

  Message._();

  factory Message.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Message.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Message_Content> _Message_ContentByTag = {
    11: Message_Content.text,
    12: Message_Content.dataMessage,
    13: Message_Content.receipt,
    14: Message_Content.typing,
    15: Message_Content.sync,
    16: Message_Content.pollVote,
    17: Message_Content.image,
    18: Message_Content.video,
    19: Message_Content.audio,
    20: Message_Content.poll,
    21: Message_Content.reaction,
    0: Message_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Message',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..oo(0, [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21])
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'conversationId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId')
    ..aE<$0.EntityType>(4, _omitFieldNames ? '' : 'senderType',
        enumValues: $0.EntityType.values)
    ..aOS(5, _omitFieldNames ? '' : 'destinationId')
    ..aE<$0.EntityType>(6, _omitFieldNames ? '' : 'destinationType',
        enumValues: $0.EntityType.values)
    ..aI(7, _omitFieldNames ? '' : 'type', fieldType: $pb.PbFieldType.OU3)
    ..aInt64(8, _omitFieldNames ? '' : 'timestamp')
    ..aInt64(9, _omitFieldNames ? '' : 'updatedAt')
    ..aI(10, _omitFieldNames ? '' : 'status', fieldType: $pb.PbFieldType.OU3)
    ..aOM<TextContent>(11, _omitFieldNames ? '' : 'text',
        subBuilder: TextContent.create)
    ..aOM<DataMessage>(12, _omitFieldNames ? '' : 'dataMessage',
        subBuilder: DataMessage.create)
    ..aOM<ReceiptMessage>(13, _omitFieldNames ? '' : 'receipt',
        subBuilder: ReceiptMessage.create)
    ..aOM<TypingMessage>(14, _omitFieldNames ? '' : 'typing',
        subBuilder: TypingMessage.create)
    ..aOM<SyncMessage>(15, _omitFieldNames ? '' : 'sync',
        subBuilder: SyncMessage.create)
    ..aOM<PollVote>(16, _omitFieldNames ? '' : 'pollVote',
        subBuilder: PollVote.create)
    ..aOM<ImageContent>(17, _omitFieldNames ? '' : 'image',
        subBuilder: ImageContent.create)
    ..aOM<VideoContent>(18, _omitFieldNames ? '' : 'video',
        subBuilder: VideoContent.create)
    ..aOM<AudioContent>(19, _omitFieldNames ? '' : 'audio',
        subBuilder: AudioContent.create)
    ..aOM<PollContent>(20, _omitFieldNames ? '' : 'poll',
        subBuilder: PollContent.create)
    ..aOM<ReactionContent>(21, _omitFieldNames ? '' : 'reaction',
        subBuilder: ReactionContent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Message create() => Message._();
  @$core.override
  Message createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Message>(create);
  static Message? _defaultInstance;

  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  Message_Content whichContent() => _Message_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasConversationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $0.EntityType get senderType => $_getN(3);
  @$pb.TagNumber(4)
  set senderType($0.EntityType value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSenderType() => $_has(3);
  @$pb.TagNumber(4)
  void clearSenderType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get destinationId => $_getSZ(4);
  @$pb.TagNumber(5)
  set destinationId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDestinationId() => $_has(4);
  @$pb.TagNumber(5)
  void clearDestinationId() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.EntityType get destinationType => $_getN(5);
  @$pb.TagNumber(6)
  set destinationType($0.EntityType value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasDestinationType() => $_has(5);
  @$pb.TagNumber(6)
  void clearDestinationType() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get type => $_getIZ(6);
  @$pb.TagNumber(7)
  set type($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasType() => $_has(6);
  @$pb.TagNumber(7)
  void clearType() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get timestamp => $_getI64(7);
  @$pb.TagNumber(8)
  set timestamp($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasTimestamp() => $_has(7);
  @$pb.TagNumber(8)
  void clearTimestamp() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get updatedAt => $_getI64(8);
  @$pb.TagNumber(9)
  set updatedAt($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasUpdatedAt() => $_has(8);
  @$pb.TagNumber(9)
  void clearUpdatedAt() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get status => $_getIZ(9);
  @$pb.TagNumber(10)
  set status($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(9);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  @$pb.TagNumber(11)
  TextContent get text => $_getN(10);
  @$pb.TagNumber(11)
  set text(TextContent value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasText() => $_has(10);
  @$pb.TagNumber(11)
  void clearText() => $_clearField(11);
  @$pb.TagNumber(11)
  TextContent ensureText() => $_ensure(10);

  @$pb.TagNumber(12)
  DataMessage get dataMessage => $_getN(11);
  @$pb.TagNumber(12)
  set dataMessage(DataMessage value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasDataMessage() => $_has(11);
  @$pb.TagNumber(12)
  void clearDataMessage() => $_clearField(12);
  @$pb.TagNumber(12)
  DataMessage ensureDataMessage() => $_ensure(11);

  @$pb.TagNumber(13)
  ReceiptMessage get receipt => $_getN(12);
  @$pb.TagNumber(13)
  set receipt(ReceiptMessage value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasReceipt() => $_has(12);
  @$pb.TagNumber(13)
  void clearReceipt() => $_clearField(13);
  @$pb.TagNumber(13)
  ReceiptMessage ensureReceipt() => $_ensure(12);

  @$pb.TagNumber(14)
  TypingMessage get typing => $_getN(13);
  @$pb.TagNumber(14)
  set typing(TypingMessage value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasTyping() => $_has(13);
  @$pb.TagNumber(14)
  void clearTyping() => $_clearField(14);
  @$pb.TagNumber(14)
  TypingMessage ensureTyping() => $_ensure(13);

  @$pb.TagNumber(15)
  SyncMessage get sync => $_getN(14);
  @$pb.TagNumber(15)
  set sync(SyncMessage value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasSync() => $_has(14);
  @$pb.TagNumber(15)
  void clearSync() => $_clearField(15);
  @$pb.TagNumber(15)
  SyncMessage ensureSync() => $_ensure(14);

  @$pb.TagNumber(16)
  PollVote get pollVote => $_getN(15);
  @$pb.TagNumber(16)
  set pollVote(PollVote value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasPollVote() => $_has(15);
  @$pb.TagNumber(16)
  void clearPollVote() => $_clearField(16);
  @$pb.TagNumber(16)
  PollVote ensurePollVote() => $_ensure(15);

  /// Legacy/Compatibility fields
  @$pb.TagNumber(17)
  ImageContent get image => $_getN(16);
  @$pb.TagNumber(17)
  set image(ImageContent value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasImage() => $_has(16);
  @$pb.TagNumber(17)
  void clearImage() => $_clearField(17);
  @$pb.TagNumber(17)
  ImageContent ensureImage() => $_ensure(16);

  @$pb.TagNumber(18)
  VideoContent get video => $_getN(17);
  @$pb.TagNumber(18)
  set video(VideoContent value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasVideo() => $_has(17);
  @$pb.TagNumber(18)
  void clearVideo() => $_clearField(18);
  @$pb.TagNumber(18)
  VideoContent ensureVideo() => $_ensure(17);

  @$pb.TagNumber(19)
  AudioContent get audio => $_getN(18);
  @$pb.TagNumber(19)
  set audio(AudioContent value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasAudio() => $_has(18);
  @$pb.TagNumber(19)
  void clearAudio() => $_clearField(19);
  @$pb.TagNumber(19)
  AudioContent ensureAudio() => $_ensure(18);

  @$pb.TagNumber(20)
  PollContent get poll => $_getN(19);
  @$pb.TagNumber(20)
  set poll(PollContent value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasPoll() => $_has(19);
  @$pb.TagNumber(20)
  void clearPoll() => $_clearField(20);
  @$pb.TagNumber(20)
  PollContent ensurePoll() => $_ensure(19);

  @$pb.TagNumber(21)
  ReactionContent get reaction => $_getN(20);
  @$pb.TagNumber(21)
  set reaction(ReactionContent value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasReaction() => $_has(20);
  @$pb.TagNumber(21)
  void clearReaction() => $_clearField(21);
  @$pb.TagNumber(21)
  ReactionContent ensureReaction() => $_ensure(20);
}

class TextContent extends $pb.GeneratedMessage {
  factory TextContent({
    $core.String? text,
  }) {
    final result = create();
    if (text != null) result.text = text;
    return result;
  }

  TextContent._();

  factory TextContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TextContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextContent copyWith(void Function(TextContent) updates) =>
      super.copyWith((message) => updates(message as TextContent))
          as TextContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TextContent create() => TextContent._();
  @$core.override
  TextContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TextContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextContent>(create);
  static TextContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
}

class ImageContent extends $pb.GeneratedMessage {
  factory ImageContent({
    $core.String? url,
    $core.String? thumbnail,
    $core.int? width,
    $core.int? height,
  }) {
    final result = create();
    if (url != null) result.url = url;
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    return result;
  }

  ImageContent._();

  factory ImageContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ImageContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImageContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aOS(2, _omitFieldNames ? '' : 'thumbnail')
    ..aI(3, _omitFieldNames ? '' : 'width')
    ..aI(4, _omitFieldNames ? '' : 'height')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImageContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImageContent copyWith(void Function(ImageContent) updates) =>
      super.copyWith((message) => updates(message as ImageContent))
          as ImageContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ImageContent create() => ImageContent._();
  @$core.override
  ImageContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ImageContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImageContent>(create);
  static ImageContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get thumbnail => $_getSZ(1);
  @$pb.TagNumber(2)
  set thumbnail($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasThumbnail() => $_has(1);
  @$pb.TagNumber(2)
  void clearThumbnail() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get width => $_getIZ(2);
  @$pb.TagNumber(3)
  set width($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasWidth() => $_has(2);
  @$pb.TagNumber(3)
  void clearWidth() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get height => $_getIZ(3);
  @$pb.TagNumber(4)
  set height($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearHeight() => $_clearField(4);
}

class VideoContent extends $pb.GeneratedMessage {
  factory VideoContent({
    $core.String? url,
    $core.String? thumbnail,
    $fixnum.Int64? duration,
  }) {
    final result = create();
    if (url != null) result.url = url;
    if (thumbnail != null) result.thumbnail = thumbnail;
    if (duration != null) result.duration = duration;
    return result;
  }

  VideoContent._();

  factory VideoContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VideoContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aOS(2, _omitFieldNames ? '' : 'thumbnail')
    ..aInt64(3, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoContent copyWith(void Function(VideoContent) updates) =>
      super.copyWith((message) => updates(message as VideoContent))
          as VideoContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VideoContent create() => VideoContent._();
  @$core.override
  VideoContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VideoContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VideoContent>(create);
  static VideoContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get thumbnail => $_getSZ(1);
  @$pb.TagNumber(2)
  set thumbnail($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasThumbnail() => $_has(1);
  @$pb.TagNumber(2)
  void clearThumbnail() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get duration => $_getI64(2);
  @$pb.TagNumber(3)
  set duration($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDuration() => $_has(2);
  @$pb.TagNumber(3)
  void clearDuration() => $_clearField(3);
}

class AudioContent extends $pb.GeneratedMessage {
  factory AudioContent({
    $core.String? url,
    $fixnum.Int64? duration,
  }) {
    final result = create();
    if (url != null) result.url = url;
    if (duration != null) result.duration = duration;
    return result;
  }

  AudioContent._();

  factory AudioContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AudioContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AudioContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aInt64(2, _omitFieldNames ? '' : 'duration')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AudioContent copyWith(void Function(AudioContent) updates) =>
      super.copyWith((message) => updates(message as AudioContent))
          as AudioContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AudioContent create() => AudioContent._();
  @$core.override
  AudioContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AudioContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AudioContent>(create);
  static AudioContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get duration => $_getI64(1);
  @$pb.TagNumber(2)
  set duration($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDuration() => $_has(1);
  @$pb.TagNumber(2)
  void clearDuration() => $_clearField(2);
}

class PollOption extends $pb.GeneratedMessage {
  factory PollOption({
    $core.String? id,
    $core.String? text,
    $core.int? votes,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (text != null) result.text = text;
    if (votes != null) result.votes = votes;
    return result;
  }

  PollOption._();

  factory PollOption.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PollOption.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PollOption',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'text')
    ..aI(3, _omitFieldNames ? '' : 'votes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollOption clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollOption copyWith(void Function(PollOption) updates) =>
      super.copyWith((message) => updates(message as PollOption)) as PollOption;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PollOption create() => PollOption._();
  @$core.override
  PollOption createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PollOption getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PollOption>(create);
  static PollOption? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get text => $_getSZ(1);
  @$pb.TagNumber(2)
  set text($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasText() => $_has(1);
  @$pb.TagNumber(2)
  void clearText() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get votes => $_getIZ(2);
  @$pb.TagNumber(3)
  set votes($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearVotes() => $_clearField(3);
}

class PollContent extends $pb.GeneratedMessage {
  factory PollContent({
    $core.String? question,
    $core.Iterable<PollOption>? options,
    $core.bool? multipleChoice,
  }) {
    final result = create();
    if (question != null) result.question = question;
    if (options != null) result.options.addAll(options);
    if (multipleChoice != null) result.multipleChoice = multipleChoice;
    return result;
  }

  PollContent._();

  factory PollContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PollContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PollContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'question')
    ..pPM<PollOption>(2, _omitFieldNames ? '' : 'options',
        subBuilder: PollOption.create)
    ..aOB(3, _omitFieldNames ? '' : 'multipleChoice')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollContent copyWith(void Function(PollContent) updates) =>
      super.copyWith((message) => updates(message as PollContent))
          as PollContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PollContent create() => PollContent._();
  @$core.override
  PollContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PollContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PollContent>(create);
  static PollContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get question => $_getSZ(0);
  @$pb.TagNumber(1)
  set question($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuestion() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<PollOption> get options => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get multipleChoice => $_getBF(2);
  @$pb.TagNumber(3)
  set multipleChoice($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMultipleChoice() => $_has(2);
  @$pb.TagNumber(3)
  void clearMultipleChoice() => $_clearField(3);
}

class ReactionContent extends $pb.GeneratedMessage {
  factory ReactionContent({
    $core.String? messageId,
    $core.String? emoji,
  }) {
    final result = create();
    if (messageId != null) result.messageId = messageId;
    if (emoji != null) result.emoji = emoji;
    return result;
  }

  ReactionContent._();

  factory ReactionContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReactionContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReactionContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'emoji')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReactionContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReactionContent copyWith(void Function(ReactionContent) updates) =>
      super.copyWith((message) => updates(message as ReactionContent))
          as ReactionContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReactionContent create() => ReactionContent._();
  @$core.override
  ReactionContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReactionContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReactionContent>(create);
  static ReactionContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get emoji => $_getSZ(1);
  @$pb.TagNumber(2)
  set emoji($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEmoji() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmoji() => $_clearField(2);
}

class DataMessage extends $pb.GeneratedMessage {
  factory DataMessage({
    $core.String? body,
    AttachmentPointer? attachment,
    Reaction? reaction,
    Location? location,
    PollCreate? pollCreate,
    PollTerminate? pollTerminate,
  }) {
    final result = create();
    if (body != null) result.body = body;
    if (attachment != null) result.attachment = attachment;
    if (reaction != null) result.reaction = reaction;
    if (location != null) result.location = location;
    if (pollCreate != null) result.pollCreate = pollCreate;
    if (pollTerminate != null) result.pollTerminate = pollTerminate;
    return result;
  }

  DataMessage._();

  factory DataMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory DataMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DataMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'body')
    ..aOM<AttachmentPointer>(2, _omitFieldNames ? '' : 'attachment',
        subBuilder: AttachmentPointer.create)
    ..aOM<Reaction>(3, _omitFieldNames ? '' : 'reaction',
        subBuilder: Reaction.create)
    ..aOM<Location>(4, _omitFieldNames ? '' : 'location',
        subBuilder: Location.create)
    ..aOM<PollCreate>(5, _omitFieldNames ? '' : 'pollCreate',
        subBuilder: PollCreate.create)
    ..aOM<PollTerminate>(6, _omitFieldNames ? '' : 'pollTerminate',
        subBuilder: PollTerminate.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DataMessage copyWith(void Function(DataMessage) updates) =>
      super.copyWith((message) => updates(message as DataMessage))
          as DataMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataMessage create() => DataMessage._();
  @$core.override
  DataMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static DataMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DataMessage>(create);
  static DataMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get body => $_getSZ(0);
  @$pb.TagNumber(1)
  set body($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBody() => $_has(0);
  @$pb.TagNumber(1)
  void clearBody() => $_clearField(1);

  @$pb.TagNumber(2)
  AttachmentPointer get attachment => $_getN(1);
  @$pb.TagNumber(2)
  set attachment(AttachmentPointer value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAttachment() => $_has(1);
  @$pb.TagNumber(2)
  void clearAttachment() => $_clearField(2);
  @$pb.TagNumber(2)
  AttachmentPointer ensureAttachment() => $_ensure(1);

  @$pb.TagNumber(3)
  Reaction get reaction => $_getN(2);
  @$pb.TagNumber(3)
  set reaction(Reaction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasReaction() => $_has(2);
  @$pb.TagNumber(3)
  void clearReaction() => $_clearField(3);
  @$pb.TagNumber(3)
  Reaction ensureReaction() => $_ensure(2);

  @$pb.TagNumber(4)
  Location get location => $_getN(3);
  @$pb.TagNumber(4)
  set location(Location value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLocation() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocation() => $_clearField(4);
  @$pb.TagNumber(4)
  Location ensureLocation() => $_ensure(3);

  @$pb.TagNumber(5)
  PollCreate get pollCreate => $_getN(4);
  @$pb.TagNumber(5)
  set pollCreate(PollCreate value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPollCreate() => $_has(4);
  @$pb.TagNumber(5)
  void clearPollCreate() => $_clearField(5);
  @$pb.TagNumber(5)
  PollCreate ensurePollCreate() => $_ensure(4);

  @$pb.TagNumber(6)
  PollTerminate get pollTerminate => $_getN(5);
  @$pb.TagNumber(6)
  set pollTerminate(PollTerminate value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPollTerminate() => $_has(5);
  @$pb.TagNumber(6)
  void clearPollTerminate() => $_clearField(6);
  @$pb.TagNumber(6)
  PollTerminate ensurePollTerminate() => $_ensure(5);
}

class PollCreate extends $pb.GeneratedMessage {
  factory PollCreate({
    $core.String? id,
    $core.String? question,
    $core.Iterable<PollOption>? options,
    $core.bool? multipleChoice,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (question != null) result.question = question;
    if (options != null) result.options.addAll(options);
    if (multipleChoice != null) result.multipleChoice = multipleChoice;
    return result;
  }

  PollCreate._();

  factory PollCreate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PollCreate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PollCreate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'question')
    ..pPM<PollOption>(3, _omitFieldNames ? '' : 'options',
        subBuilder: PollOption.create)
    ..aOB(4, _omitFieldNames ? '' : 'multipleChoice')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollCreate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollCreate copyWith(void Function(PollCreate) updates) =>
      super.copyWith((message) => updates(message as PollCreate)) as PollCreate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PollCreate create() => PollCreate._();
  @$core.override
  PollCreate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PollCreate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PollCreate>(create);
  static PollCreate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get question => $_getSZ(1);
  @$pb.TagNumber(2)
  set question($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuestion() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuestion() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<PollOption> get options => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get multipleChoice => $_getBF(3);
  @$pb.TagNumber(4)
  set multipleChoice($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMultipleChoice() => $_has(3);
  @$pb.TagNumber(4)
  void clearMultipleChoice() => $_clearField(4);
}

class PollVote extends $pb.GeneratedMessage {
  factory PollVote({
    $core.String? pollId,
    $core.String? optionId,
    $core.String? userId,
    $fixnum.Int64? timestamp,
  }) {
    final result = create();
    if (pollId != null) result.pollId = pollId;
    if (optionId != null) result.optionId = optionId;
    if (userId != null) result.userId = userId;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  PollVote._();

  factory PollVote.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PollVote.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PollVote',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pollId')
    ..aOS(2, _omitFieldNames ? '' : 'optionId')
    ..aOS(3, _omitFieldNames ? '' : 'userId')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollVote clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollVote copyWith(void Function(PollVote) updates) =>
      super.copyWith((message) => updates(message as PollVote)) as PollVote;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PollVote create() => PollVote._();
  @$core.override
  PollVote createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PollVote getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PollVote>(create);
  static PollVote? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pollId => $_getSZ(0);
  @$pb.TagNumber(1)
  set pollId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPollId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPollId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get optionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set optionId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOptionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOptionId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get userId => $_getSZ(2);
  @$pb.TagNumber(3)
  set userId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
}

class PollTerminate extends $pb.GeneratedMessage {
  factory PollTerminate({
    $core.String? pollId,
  }) {
    final result = create();
    if (pollId != null) result.pollId = pollId;
    return result;
  }

  PollTerminate._();

  factory PollTerminate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PollTerminate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PollTerminate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pollId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollTerminate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PollTerminate copyWith(void Function(PollTerminate) updates) =>
      super.copyWith((message) => updates(message as PollTerminate))
          as PollTerminate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PollTerminate create() => PollTerminate._();
  @$core.override
  PollTerminate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PollTerminate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PollTerminate>(create);
  static PollTerminate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get pollId => $_getSZ(0);
  @$pb.TagNumber(1)
  set pollId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPollId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPollId() => $_clearField(1);
}

class AttachmentPointer extends $pb.GeneratedMessage {
  factory AttachmentPointer({
    $core.String? id,
    $core.List<$core.int>? key,
    $core.List<$core.int>? iv,
    $core.List<$core.int>? digest,
    $core.String? fileName,
    $core.int? size,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (key != null) result.key = key;
    if (iv != null) result.iv = iv;
    if (digest != null) result.digest = digest;
    if (fileName != null) result.fileName = fileName;
    if (size != null) result.size = size;
    return result;
  }

  AttachmentPointer._();

  factory AttachmentPointer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AttachmentPointer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AttachmentPointer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'key', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'iv', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'digest', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'fileName', protoName: 'fileName')
    ..aI(6, _omitFieldNames ? '' : 'size', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentPointer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AttachmentPointer copyWith(void Function(AttachmentPointer) updates) =>
      super.copyWith((message) => updates(message as AttachmentPointer))
          as AttachmentPointer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AttachmentPointer create() => AttachmentPointer._();
  @$core.override
  AttachmentPointer createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static AttachmentPointer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AttachmentPointer>(create);
  static AttachmentPointer? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get key => $_getN(1);
  @$pb.TagNumber(2)
  set key($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearKey() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get iv => $_getN(2);
  @$pb.TagNumber(3)
  set iv($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasIv() => $_has(2);
  @$pb.TagNumber(3)
  void clearIv() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get digest => $_getN(3);
  @$pb.TagNumber(4)
  set digest($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearDigest() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileName => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFileName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get size => $_getIZ(5);
  @$pb.TagNumber(6)
  set size($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSize() => $_has(5);
  @$pb.TagNumber(6)
  void clearSize() => $_clearField(6);
}

class Reaction extends $pb.GeneratedMessage {
  factory Reaction({
    $core.String? emoji,
    $core.bool? remove,
    $core.String? targetAuthorAci,
    $fixnum.Int64? targetTimestamp,
  }) {
    final result = create();
    if (emoji != null) result.emoji = emoji;
    if (remove != null) result.remove = remove;
    if (targetAuthorAci != null) result.targetAuthorAci = targetAuthorAci;
    if (targetTimestamp != null) result.targetTimestamp = targetTimestamp;
    return result;
  }

  Reaction._();

  factory Reaction.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Reaction.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Reaction',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'emoji')
    ..aOB(2, _omitFieldNames ? '' : 'remove')
    ..aOS(3, _omitFieldNames ? '' : 'targetAuthorAci')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'targetTimestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reaction clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Reaction copyWith(void Function(Reaction) updates) =>
      super.copyWith((message) => updates(message as Reaction)) as Reaction;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Reaction create() => Reaction._();
  @$core.override
  Reaction createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Reaction getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Reaction>(create);
  static Reaction? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get emoji => $_getSZ(0);
  @$pb.TagNumber(1)
  set emoji($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEmoji() => $_has(0);
  @$pb.TagNumber(1)
  void clearEmoji() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get remove => $_getBF(1);
  @$pb.TagNumber(2)
  set remove($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRemove() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemove() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get targetAuthorAci => $_getSZ(2);
  @$pb.TagNumber(3)
  set targetAuthorAci($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTargetAuthorAci() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetAuthorAci() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get targetTimestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set targetTimestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTargetTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetTimestamp() => $_clearField(4);
}

class Location extends $pb.GeneratedMessage {
  factory Location({
    $core.double? latitude,
    $core.double? longitude,
    $core.String? address,
    $core.double? accuracy,
    $fixnum.Int64? timestamp,
    $core.bool? isLive,
    $core.int? duration,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (address != null) result.address = address;
    if (accuracy != null) result.accuracy = accuracy;
    if (timestamp != null) result.timestamp = timestamp;
    if (isLive != null) result.isLive = isLive;
    if (duration != null) result.duration = duration;
    return result;
  }

  Location._();

  factory Location.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Location.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Location',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'latitude')
    ..aD(2, _omitFieldNames ? '' : 'longitude')
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..aD(4, _omitFieldNames ? '' : 'accuracy')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(6, _omitFieldNames ? '' : 'isLive')
    ..aI(7, _omitFieldNames ? '' : 'duration', fieldType: $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Location clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Location copyWith(void Function(Location) updates) =>
      super.copyWith((message) => updates(message as Location)) as Location;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Location create() => Location._();
  @$core.override
  Location createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Location getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Location>(create);
  static Location? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.double get accuracy => $_getN(3);
  @$pb.TagNumber(4)
  set accuracy($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAccuracy() => $_has(3);
  @$pb.TagNumber(4)
  void clearAccuracy() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isLive => $_getBF(5);
  @$pb.TagNumber(6)
  set isLive($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasIsLive() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsLive() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get duration => $_getIZ(6);
  @$pb.TagNumber(7)
  set duration($core.int value) => $_setUnsignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDuration() => $_has(6);
  @$pb.TagNumber(7)
  void clearDuration() => $_clearField(7);
}

class ReceiptMessage extends $pb.GeneratedMessage {
  factory ReceiptMessage({
    ReceiptMessage_ReceiptType? type,
    $core.String? messageId,
    $core.String? senderId,
    $fixnum.Int64? timestamp,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (messageId != null) result.messageId = messageId;
    if (senderId != null) result.senderId = senderId;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  ReceiptMessage._();

  factory ReceiptMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReceiptMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReceiptMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aE<ReceiptMessage_ReceiptType>(1, _omitFieldNames ? '' : 'type',
        enumValues: ReceiptMessage_ReceiptType.values)
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReceiptMessage copyWith(void Function(ReceiptMessage) updates) =>
      super.copyWith((message) => updates(message as ReceiptMessage))
          as ReceiptMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReceiptMessage create() => ReceiptMessage._();
  @$core.override
  ReceiptMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReceiptMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReceiptMessage>(create);
  static ReceiptMessage? _defaultInstance;

  @$pb.TagNumber(1)
  ReceiptMessage_ReceiptType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ReceiptMessage_ReceiptType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get senderId => $_getSZ(2);
  @$pb.TagNumber(3)
  set senderId($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);
}

class TypingMessage extends $pb.GeneratedMessage {
  factory TypingMessage({
    TypingMessage_TypingState? state,
    $fixnum.Int64? timestamp,
  }) {
    final result = create();
    if (state != null) result.state = state;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  TypingMessage._();

  factory TypingMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TypingMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TypingMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aE<TypingMessage_TypingState>(1, _omitFieldNames ? '' : 'state',
        enumValues: TypingMessage_TypingState.values)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypingMessage copyWith(void Function(TypingMessage) updates) =>
      super.copyWith((message) => updates(message as TypingMessage))
          as TypingMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TypingMessage create() => TypingMessage._();
  @$core.override
  TypingMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TypingMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TypingMessage>(create);
  static TypingMessage? _defaultInstance;

  @$pb.TagNumber(1)
  TypingMessage_TypingState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(TypingMessage_TypingState value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get timestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set timestamp($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimestamp() => $_clearField(2);
}

class SyncMessage extends $pb.GeneratedMessage {
  factory SyncMessage({
    SyncMessage_SyncType? type,
    $core.String? messageId,
    $core.int? status,
    $core.String? error,
    $fixnum.Int64? timestamp,
    $core.Iterable<$core.String>? targetIds,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (messageId != null) result.messageId = messageId;
    if (status != null) result.status = status;
    if (error != null) result.error = error;
    if (timestamp != null) result.timestamp = timestamp;
    if (targetIds != null) result.targetIds.addAll(targetIds);
    return result;
  }

  SyncMessage._();

  factory SyncMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SyncMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SyncMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aE<SyncMessage_SyncType>(1, _omitFieldNames ? '' : 'type',
        enumValues: SyncMessage_SyncType.values)
    ..aOS(2, _omitFieldNames ? '' : 'messageId')
    ..aI(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'error')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(6, _omitFieldNames ? '' : 'targetIds')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SyncMessage copyWith(void Function(SyncMessage) updates) =>
      super.copyWith((message) => updates(message as SyncMessage))
          as SyncMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SyncMessage create() => SyncMessage._();
  @$core.override
  SyncMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static SyncMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SyncMessage>(create);
  static SyncMessage? _defaultInstance;

  @$pb.TagNumber(1)
  SyncMessage_SyncType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(SyncMessage_SyncType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get messageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set messageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get status => $_getIZ(2);
  @$pb.TagNumber(3)
  set status($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearStatus() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get error => $_getSZ(3);
  @$pb.TagNumber(4)
  set error($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasError() => $_has(3);
  @$pb.TagNumber(4)
  void clearError() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<$core.String> get targetIds => $_getList(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

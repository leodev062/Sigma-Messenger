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

import 'message.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'message.pbenum.dart';

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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'question')
    ..pPM<PollOption>(2, _omitFieldNames ? '' : 'options',
        subBuilder: PollOption.create)
    ..aOB(3, _omitFieldNames ? '' : 'multipleChoice',
        protoName: 'multipleChoice')
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

class ReplyContent extends $pb.GeneratedMessage {
  factory ReplyContent({
    $core.String? messageId,
    $core.String? previewText,
  }) {
    final result = create();
    if (messageId != null) result.messageId = messageId;
    if (previewText != null) result.previewText = previewText;
    return result;
  }

  ReplyContent._();

  factory ReplyContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplyContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplyContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId', protoName: 'messageId')
    ..aOS(2, _omitFieldNames ? '' : 'previewText', protoName: 'previewText')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplyContent copyWith(void Function(ReplyContent) updates) =>
      super.copyWith((message) => updates(message as ReplyContent))
          as ReplyContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplyContent create() => ReplyContent._();
  @$core.override
  ReplyContent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReplyContent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplyContent>(create);
  static ReplyContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get messageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set messageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMessageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessageId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get previewText => $_getSZ(1);
  @$pb.TagNumber(2)
  set previewText($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPreviewText() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreviewText() => $_clearField(2);
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
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'messageId', protoName: 'messageId')
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

enum Message_Content {
  text,
  image,
  video,
  audio,
  poll,
  reply,
  reaction,
  notSet
}

class Message extends $pb.GeneratedMessage {
  factory Message({
    $core.String? id,
    $core.String? conversationId,
    $core.String? senderId,
    $core.String? receiverId,
    MessageType? type,
    $fixnum.Int64? timestamp,
    $fixnum.Int64? updatedAt,
    MessageStatus? status,
    TextContent? text,
    ImageContent? image,
    VideoContent? video,
    AudioContent? audio,
    PollContent? poll,
    ReplyContent? reply,
    ReactionContent? reaction,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (conversationId != null) result.conversationId = conversationId;
    if (senderId != null) result.senderId = senderId;
    if (receiverId != null) result.receiverId = receiverId;
    if (type != null) result.type = type;
    if (timestamp != null) result.timestamp = timestamp;
    if (updatedAt != null) result.updatedAt = updatedAt;
    if (status != null) result.status = status;
    if (text != null) result.text = text;
    if (image != null) result.image = image;
    if (video != null) result.video = video;
    if (audio != null) result.audio = audio;
    if (poll != null) result.poll = poll;
    if (reply != null) result.reply = reply;
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
    9: Message_Content.text,
    10: Message_Content.image,
    11: Message_Content.video,
    12: Message_Content.audio,
    13: Message_Content.poll,
    14: Message_Content.reply,
    15: Message_Content.reaction,
    0: Message_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Message',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'messaging'),
      createEmptyInstance: create)
    ..oo(0, [9, 10, 11, 12, 13, 14, 15])
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'conversationId',
        protoName: 'conversationId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId', protoName: 'senderId')
    ..aOS(4, _omitFieldNames ? '' : 'receiverId', protoName: 'receiverId')
    ..aE<MessageType>(5, _omitFieldNames ? '' : 'type',
        enumValues: MessageType.values)
    ..aInt64(6, _omitFieldNames ? '' : 'timestamp')
    ..aInt64(7, _omitFieldNames ? '' : 'updatedAt', protoName: 'updatedAt')
    ..aE<MessageStatus>(8, _omitFieldNames ? '' : 'status',
        enumValues: MessageStatus.values)
    ..aOM<TextContent>(9, _omitFieldNames ? '' : 'text',
        subBuilder: TextContent.create)
    ..aOM<ImageContent>(10, _omitFieldNames ? '' : 'image',
        subBuilder: ImageContent.create)
    ..aOM<VideoContent>(11, _omitFieldNames ? '' : 'video',
        subBuilder: VideoContent.create)
    ..aOM<AudioContent>(12, _omitFieldNames ? '' : 'audio',
        subBuilder: AudioContent.create)
    ..aOM<PollContent>(13, _omitFieldNames ? '' : 'poll',
        subBuilder: PollContent.create)
    ..aOM<ReplyContent>(14, _omitFieldNames ? '' : 'reply',
        subBuilder: ReplyContent.create)
    ..aOM<ReactionContent>(15, _omitFieldNames ? '' : 'reaction',
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

  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  Message_Content whichContent() => _Message_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(9)
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

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
  $core.String get receiverId => $_getSZ(3);
  @$pb.TagNumber(4)
  set receiverId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReceiverId() => $_has(3);
  @$pb.TagNumber(4)
  void clearReceiverId() => $_clearField(4);

  @$pb.TagNumber(5)
  MessageType get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(MessageType value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get timestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set timestamp($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimestamp() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get updatedAt => $_getI64(6);
  @$pb.TagNumber(7)
  set updatedAt($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUpdatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearUpdatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  MessageStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(MessageStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);

  @$pb.TagNumber(9)
  TextContent get text => $_getN(8);
  @$pb.TagNumber(9)
  set text(TextContent value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasText() => $_has(8);
  @$pb.TagNumber(9)
  void clearText() => $_clearField(9);
  @$pb.TagNumber(9)
  TextContent ensureText() => $_ensure(8);

  @$pb.TagNumber(10)
  ImageContent get image => $_getN(9);
  @$pb.TagNumber(10)
  set image(ImageContent value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasImage() => $_has(9);
  @$pb.TagNumber(10)
  void clearImage() => $_clearField(10);
  @$pb.TagNumber(10)
  ImageContent ensureImage() => $_ensure(9);

  @$pb.TagNumber(11)
  VideoContent get video => $_getN(10);
  @$pb.TagNumber(11)
  set video(VideoContent value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasVideo() => $_has(10);
  @$pb.TagNumber(11)
  void clearVideo() => $_clearField(11);
  @$pb.TagNumber(11)
  VideoContent ensureVideo() => $_ensure(10);

  @$pb.TagNumber(12)
  AudioContent get audio => $_getN(11);
  @$pb.TagNumber(12)
  set audio(AudioContent value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAudio() => $_has(11);
  @$pb.TagNumber(12)
  void clearAudio() => $_clearField(12);
  @$pb.TagNumber(12)
  AudioContent ensureAudio() => $_ensure(11);

  @$pb.TagNumber(13)
  PollContent get poll => $_getN(12);
  @$pb.TagNumber(13)
  set poll(PollContent value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasPoll() => $_has(12);
  @$pb.TagNumber(13)
  void clearPoll() => $_clearField(13);
  @$pb.TagNumber(13)
  PollContent ensurePoll() => $_ensure(12);

  @$pb.TagNumber(14)
  ReplyContent get reply => $_getN(13);
  @$pb.TagNumber(14)
  set reply(ReplyContent value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasReply() => $_has(13);
  @$pb.TagNumber(14)
  void clearReply() => $_clearField(14);
  @$pb.TagNumber(14)
  ReplyContent ensureReply() => $_ensure(13);

  @$pb.TagNumber(15)
  ReactionContent get reaction => $_getN(14);
  @$pb.TagNumber(15)
  set reaction(ReactionContent value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasReaction() => $_has(14);
  @$pb.TagNumber(15)
  void clearReaction() => $_clearField(15);
  @$pb.TagNumber(15)
  ReactionContent ensureReaction() => $_ensure(14);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

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

enum Content_Content { dataMessage, receipt, typing, sync, notSet }

class Content extends $pb.GeneratedMessage {
  factory Content({
    DataMessage? dataMessage,
    ReceiptMessage? receipt,
    TypingMessage? typing,
    SyncMessage? sync,
  }) {
    final result = create();
    if (dataMessage != null) result.dataMessage = dataMessage;
    if (receipt != null) result.receipt = receipt;
    if (typing != null) result.typing = typing;
    if (sync != null) result.sync = sync;
    return result;
  }

  Content._();

  factory Content.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Content.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Content_Content> _Content_ContentByTag = {
    1: Content_Content.dataMessage,
    2: Content_Content.receipt,
    3: Content_Content.typing,
    4: Content_Content.sync,
    0: Content_Content.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Content',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<DataMessage>(1, _omitFieldNames ? '' : 'dataMessage',
        protoName: 'dataMessage', subBuilder: DataMessage.create)
    ..aOM<ReceiptMessage>(2, _omitFieldNames ? '' : 'receipt',
        subBuilder: ReceiptMessage.create)
    ..aOM<TypingMessage>(3, _omitFieldNames ? '' : 'typing',
        subBuilder: TypingMessage.create)
    ..aOM<SyncMessage>(4, _omitFieldNames ? '' : 'sync',
        subBuilder: SyncMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Content clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Content copyWith(void Function(Content) updates) =>
      super.copyWith((message) => updates(message as Content)) as Content;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Content create() => Content._();
  @$core.override
  Content createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Content getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Content>(create);
  static Content? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  Content_Content whichContent() => _Content_ContentByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearContent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  DataMessage get dataMessage => $_getN(0);
  @$pb.TagNumber(1)
  set dataMessage(DataMessage value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDataMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearDataMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  DataMessage ensureDataMessage() => $_ensure(0);

  @$pb.TagNumber(2)
  ReceiptMessage get receipt => $_getN(1);
  @$pb.TagNumber(2)
  set receipt(ReceiptMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasReceipt() => $_has(1);
  @$pb.TagNumber(2)
  void clearReceipt() => $_clearField(2);
  @$pb.TagNumber(2)
  ReceiptMessage ensureReceipt() => $_ensure(1);

  @$pb.TagNumber(3)
  TypingMessage get typing => $_getN(2);
  @$pb.TagNumber(3)
  set typing(TypingMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTyping() => $_has(2);
  @$pb.TagNumber(3)
  void clearTyping() => $_clearField(3);
  @$pb.TagNumber(3)
  TypingMessage ensureTyping() => $_ensure(2);

  @$pb.TagNumber(4)
  SyncMessage get sync => $_getN(3);
  @$pb.TagNumber(4)
  set sync(SyncMessage value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSync() => $_has(3);
  @$pb.TagNumber(4)
  void clearSync() => $_clearField(4);
  @$pb.TagNumber(4)
  SyncMessage ensureSync() => $_ensure(3);
}

class DataMessage extends $pb.GeneratedMessage {
  factory DataMessage({
    $core.String? body,
    AttachmentPointer? attachment,
    Reaction? reaction,
    Location? location,
    PollCreate? pollCreate,
    PollVote? pollVote,
    PollTerminate? pollTerminate,
  }) {
    final result = create();
    if (body != null) result.body = body;
    if (attachment != null) result.attachment = attachment;
    if (reaction != null) result.reaction = reaction;
    if (location != null) result.location = location;
    if (pollCreate != null) result.pollCreate = pollCreate;
    if (pollVote != null) result.pollVote = pollVote;
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
        protoName: 'pollCreate', subBuilder: PollCreate.create)
    ..aOM<PollVote>(6, _omitFieldNames ? '' : 'pollVote',
        protoName: 'pollVote', subBuilder: PollVote.create)
    ..aOM<PollTerminate>(7, _omitFieldNames ? '' : 'pollTerminate',
        protoName: 'pollTerminate', subBuilder: PollTerminate.create)
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
  PollVote get pollVote => $_getN(5);
  @$pb.TagNumber(6)
  set pollVote(PollVote value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPollVote() => $_has(5);
  @$pb.TagNumber(6)
  void clearPollVote() => $_clearField(6);
  @$pb.TagNumber(6)
  PollVote ensurePollVote() => $_ensure(5);

  @$pb.TagNumber(7)
  PollTerminate get pollTerminate => $_getN(6);
  @$pb.TagNumber(7)
  set pollTerminate(PollTerminate value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPollTerminate() => $_has(6);
  @$pb.TagNumber(7)
  void clearPollTerminate() => $_clearField(7);
  @$pb.TagNumber(7)
  PollTerminate ensurePollTerminate() => $_ensure(6);
}

class PollCreate extends $pb.GeneratedMessage {
  factory PollCreate({
    $core.String? question,
    $core.Iterable<$core.String>? options,
    $core.bool? allowMultipleVotes,
  }) {
    final result = create();
    if (question != null) result.question = question;
    if (options != null) result.options.addAll(options);
    if (allowMultipleVotes != null)
      result.allowMultipleVotes = allowMultipleVotes;
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
    ..aOS(1, _omitFieldNames ? '' : 'question')
    ..pPS(2, _omitFieldNames ? '' : 'options')
    ..aOB(3, _omitFieldNames ? '' : 'allowMultipleVotes')
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
  $core.String get question => $_getSZ(0);
  @$pb.TagNumber(1)
  set question($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuestion() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuestion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get options => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get allowMultipleVotes => $_getBF(2);
  @$pb.TagNumber(3)
  set allowMultipleVotes($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAllowMultipleVotes() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowMultipleVotes() => $_clearField(3);
}

class PollVote extends $pb.GeneratedMessage {
  factory PollVote({
    $core.String? targetAuthorAci,
    $fixnum.Int64? targetSentTimestamp,
    $core.Iterable<$core.int>? optionIndexes,
    $core.int? voteCount,
  }) {
    final result = create();
    if (targetAuthorAci != null) result.targetAuthorAci = targetAuthorAci;
    if (targetSentTimestamp != null)
      result.targetSentTimestamp = targetSentTimestamp;
    if (optionIndexes != null) result.optionIndexes.addAll(optionIndexes);
    if (voteCount != null) result.voteCount = voteCount;
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
    ..aOS(1, _omitFieldNames ? '' : 'targetAuthorAci')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'targetSentTimestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.int>(
        3, _omitFieldNames ? '' : 'optionIndexes', $pb.PbFieldType.KU3)
    ..aI(4, _omitFieldNames ? '' : 'voteCount', fieldType: $pb.PbFieldType.OU3)
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
  $core.String get targetAuthorAci => $_getSZ(0);
  @$pb.TagNumber(1)
  set targetAuthorAci($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTargetAuthorAci() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetAuthorAci() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get targetSentTimestamp => $_getI64(1);
  @$pb.TagNumber(2)
  set targetSentTimestamp($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTargetSentTimestamp() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetSentTimestamp() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.int> get optionIndexes => $_getList(2);

  @$pb.TagNumber(4)
  $core.int get voteCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set voteCount($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasVoteCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearVoteCount() => $_clearField(4);
}

class PollTerminate extends $pb.GeneratedMessage {
  factory PollTerminate({
    $fixnum.Int64? targetSentTimestamp,
  }) {
    final result = create();
    if (targetSentTimestamp != null)
      result.targetSentTimestamp = targetSentTimestamp;
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
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'targetSentTimestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
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
  $fixnum.Int64 get targetSentTimestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set targetSentTimestamp($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTargetSentTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTargetSentTimestamp() => $_clearField(1);
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
    ..aOS(3, _omitFieldNames ? '' : 'targetAuthorAci',
        protoName: 'targetAuthorAci')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'targetTimestamp', $pb.PbFieldType.OU6,
        protoName: 'targetTimestamp', defaultOrMaker: $fixnum.Int64.ZERO)
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
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (address != null) result.address = address;
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
}

/// ReceiptMessage para confirmações de entrega/leitura
class ReceiptMessage extends $pb.GeneratedMessage {
  factory ReceiptMessage({
    ReceiptMessage_ReceiptType? type,
    $core.String? messageId,
    $core.String? senderId,
    $fixnum.Int64? timestamp,
    $core.int? messageCount,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (messageId != null) result.messageId = messageId;
    if (senderId != null) result.senderId = senderId;
    if (timestamp != null) result.timestamp = timestamp;
    if (messageCount != null) result.messageCount = messageCount;
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
    ..aOS(2, _omitFieldNames ? '' : 'messageId', protoName: 'messageId')
    ..aOS(3, _omitFieldNames ? '' : 'senderId', protoName: 'senderId')
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(5, _omitFieldNames ? '' : 'messageCount',
        protoName: 'messageCount', fieldType: $pb.PbFieldType.OU3)
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

  @$pb.TagNumber(5)
  $core.int get messageCount => $_getIZ(4);
  @$pb.TagNumber(5)
  set messageCount($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMessageCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearMessageCount() => $_clearField(5);
}

/// TypingMessage para indicadores de digitação
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

/// SyncMessage para sincronização de status/eventos
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
    ..aOS(2, _omitFieldNames ? '' : 'messageId', protoName: 'messageId')
    ..aI(3, _omitFieldNames ? '' : 'status')
    ..aOS(4, _omitFieldNames ? '' : 'error')
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(6, _omitFieldNames ? '' : 'targetIds', protoName: 'targetIds')
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

// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'websocket.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'websocket.pbenum.dart';

class WebSocketMessage extends $pb.GeneratedMessage {
  factory WebSocketMessage({
    WebSocketMessage_Type? type,
    WebSocketRequestMessage? request,
    WebSocketResponseMessage? response,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    return result;
  }

  WebSocketMessage._();

  factory WebSocketMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebSocketMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebSocketMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aE<WebSocketMessage_Type>(1, _omitFieldNames ? '' : 'type',
        enumValues: WebSocketMessage_Type.values)
    ..aOM<WebSocketRequestMessage>(2, _omitFieldNames ? '' : 'request',
        subBuilder: WebSocketRequestMessage.create)
    ..aOM<WebSocketResponseMessage>(3, _omitFieldNames ? '' : 'response',
        subBuilder: WebSocketResponseMessage.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketMessage copyWith(void Function(WebSocketMessage) updates) =>
      super.copyWith((message) => updates(message as WebSocketMessage))
          as WebSocketMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebSocketMessage create() => WebSocketMessage._();
  @$core.override
  WebSocketMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WebSocketMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebSocketMessage>(create);
  static WebSocketMessage? _defaultInstance;

  @$pb.TagNumber(1)
  WebSocketMessage_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(WebSocketMessage_Type value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  WebSocketRequestMessage get request => $_getN(1);
  @$pb.TagNumber(2)
  set request(WebSocketRequestMessage value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequest() => $_clearField(2);
  @$pb.TagNumber(2)
  WebSocketRequestMessage ensureRequest() => $_ensure(1);

  @$pb.TagNumber(3)
  WebSocketResponseMessage get response => $_getN(2);
  @$pb.TagNumber(3)
  set response(WebSocketResponseMessage value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasResponse() => $_has(2);
  @$pb.TagNumber(3)
  void clearResponse() => $_clearField(3);
  @$pb.TagNumber(3)
  WebSocketResponseMessage ensureResponse() => $_ensure(2);
}

class WebSocketRequestMessage extends $pb.GeneratedMessage {
  factory WebSocketRequestMessage({
    $core.String? id,
    $core.String? verb,
    $core.String? path,
    $core.List<$core.int>? body,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (verb != null) result.verb = verb;
    if (path != null) result.path = path;
    if (body != null) result.body = body;
    return result;
  }

  WebSocketRequestMessage._();

  factory WebSocketRequestMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebSocketRequestMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebSocketRequestMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'verb')
    ..aOS(3, _omitFieldNames ? '' : 'path')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketRequestMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketRequestMessage copyWith(
          void Function(WebSocketRequestMessage) updates) =>
      super.copyWith((message) => updates(message as WebSocketRequestMessage))
          as WebSocketRequestMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebSocketRequestMessage create() => WebSocketRequestMessage._();
  @$core.override
  WebSocketRequestMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WebSocketRequestMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebSocketRequestMessage>(create);
  static WebSocketRequestMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get verb => $_getSZ(1);
  @$pb.TagNumber(2)
  set verb($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVerb() => $_has(1);
  @$pb.TagNumber(2)
  void clearVerb() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get path => $_getSZ(2);
  @$pb.TagNumber(3)
  set path($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearPath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get body => $_getN(3);
  @$pb.TagNumber(4)
  set body($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBody() => $_has(3);
  @$pb.TagNumber(4)
  void clearBody() => $_clearField(4);
}

class WebSocketResponseMessage extends $pb.GeneratedMessage {
  factory WebSocketResponseMessage({
    $core.String? id,
    $core.int? status,
    $core.String? message,
    $core.List<$core.int>? body,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (status != null) result.status = status;
    if (message != null) result.message = message;
    if (body != null) result.body = body;
    return result;
  }

  WebSocketResponseMessage._();

  factory WebSocketResponseMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory WebSocketResponseMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'WebSocketResponseMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aI(2, _omitFieldNames ? '' : 'status')
    ..aOS(3, _omitFieldNames ? '' : 'message')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'body', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketResponseMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  WebSocketResponseMessage copyWith(
          void Function(WebSocketResponseMessage) updates) =>
      super.copyWith((message) => updates(message as WebSocketResponseMessage))
          as WebSocketResponseMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WebSocketResponseMessage create() => WebSocketResponseMessage._();
  @$core.override
  WebSocketResponseMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static WebSocketResponseMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<WebSocketResponseMessage>(create);
  static WebSocketResponseMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get status => $_getIZ(1);
  @$pb.TagNumber(2)
  set status($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get message => $_getSZ(2);
  @$pb.TagNumber(3)
  set message($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get body => $_getN(3);
  @$pb.TagNumber(4)
  set body($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasBody() => $_has(3);
  @$pb.TagNumber(4)
  void clearBody() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

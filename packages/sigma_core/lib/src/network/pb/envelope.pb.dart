// This is a generated file - do not edit.
//
// Generated from envelope.proto.

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

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Envelope extends $pb.GeneratedMessage {
  factory Envelope({
    $core.String? envelopeId,
    $core.String? from,
    $core.String? to,
    $core.List<$core.int>? payload,
    $core.String? status,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? deliverAt,
    $0.EntityType? destinationType,
    $core.String? destinationId,
    $core.int? type,
    $core.String? source,
    $core.int? sourceDevice,
    $fixnum.Int64? timestamp,
  }) {
    final result = create();
    if (envelopeId != null) result.envelopeId = envelopeId;
    if (from != null) result.from = from;
    if (to != null) result.to = to;
    if (payload != null) result.payload = payload;
    if (status != null) result.status = status;
    if (createdAt != null) result.createdAt = createdAt;
    if (deliverAt != null) result.deliverAt = deliverAt;
    if (destinationType != null) result.destinationType = destinationType;
    if (destinationId != null) result.destinationId = destinationId;
    if (type != null) result.type = type;
    if (source != null) result.source = source;
    if (sourceDevice != null) result.sourceDevice = sourceDevice;
    if (timestamp != null) result.timestamp = timestamp;
    return result;
  }

  Envelope._();

  factory Envelope.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Envelope.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Envelope',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'envelopeId')
    ..aOS(2, _omitFieldNames ? '' : 'from')
    ..aOS(3, _omitFieldNames ? '' : 'to')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'status')
    ..aInt64(6, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(7, _omitFieldNames ? '' : 'deliverAt')
    ..aE<$0.EntityType>(8, _omitFieldNames ? '' : 'destinationType',
        enumValues: $0.EntityType.values)
    ..aOS(9, _omitFieldNames ? '' : 'destinationId')
    ..aI(10, _omitFieldNames ? '' : 'type', fieldType: $pb.PbFieldType.OU3)
    ..aOS(11, _omitFieldNames ? '' : 'source')
    ..aI(12, _omitFieldNames ? '' : 'sourceDevice',
        fieldType: $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(
        13, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Envelope clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Envelope copyWith(void Function(Envelope) updates) =>
      super.copyWith((message) => updates(message as Envelope)) as Envelope;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Envelope create() => Envelope._();
  @$core.override
  Envelope createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Envelope getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Envelope>(create);
  static Envelope? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get envelopeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set envelopeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnvelopeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnvelopeId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get from => $_getSZ(1);
  @$pb.TagNumber(2)
  set from($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFrom() => $_has(1);
  @$pb.TagNumber(2)
  void clearFrom() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get to => $_getSZ(2);
  @$pb.TagNumber(3)
  set to($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTo() => $_has(2);
  @$pb.TagNumber(3)
  void clearTo() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get payload => $_getN(3);
  @$pb.TagNumber(4)
  set payload($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPayload() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayload() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get status => $_getSZ(4);
  @$pb.TagNumber(5)
  set status($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get createdAt => $_getI64(5);
  @$pb.TagNumber(6)
  set createdAt($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCreatedAt() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreatedAt() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get deliverAt => $_getI64(6);
  @$pb.TagNumber(7)
  set deliverAt($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDeliverAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearDeliverAt() => $_clearField(7);

  /// MRDA Fields
  @$pb.TagNumber(8)
  $0.EntityType get destinationType => $_getN(7);
  @$pb.TagNumber(8)
  set destinationType($0.EntityType value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasDestinationType() => $_has(7);
  @$pb.TagNumber(8)
  void clearDestinationType() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get destinationId => $_getSZ(8);
  @$pb.TagNumber(9)
  set destinationId($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDestinationId() => $_has(8);
  @$pb.TagNumber(9)
  void clearDestinationId() => $_clearField(9);

  /// Signal/Extended Fields
  @$pb.TagNumber(10)
  $core.int get type => $_getIZ(9);
  @$pb.TagNumber(10)
  set type($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasType() => $_has(9);
  @$pb.TagNumber(10)
  void clearType() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get source => $_getSZ(10);
  @$pb.TagNumber(11)
  set source($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSource() => $_has(10);
  @$pb.TagNumber(11)
  void clearSource() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.int get sourceDevice => $_getIZ(11);
  @$pb.TagNumber(12)
  set sourceDevice($core.int value) => $_setUnsignedInt32(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSourceDevice() => $_has(11);
  @$pb.TagNumber(12)
  void clearSourceDevice() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get timestamp => $_getI64(12);
  @$pb.TagNumber(13)
  set timestamp($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasTimestamp() => $_has(12);
  @$pb.TagNumber(13)
  void clearTimestamp() => $_clearField(13);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

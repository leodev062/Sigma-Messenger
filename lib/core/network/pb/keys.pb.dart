// This is a generated file - do not edit.
//
// Generated from keys.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class PreKeyRecord extends $pb.GeneratedMessage {
  factory PreKeyRecord({
    $core.int? id,
    $core.List<$core.int>? publicKey,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  PreKeyRecord._();

  factory PreKeyRecord.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PreKeyRecord.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreKeyRecord',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'id')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreKeyRecord clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreKeyRecord copyWith(void Function(PreKeyRecord) updates) =>
      super.copyWith((message) => updates(message as PreKeyRecord))
          as PreKeyRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreKeyRecord create() => PreKeyRecord._();
  @$core.override
  PreKeyRecord createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PreKeyRecord getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreKeyRecord>(create);
  static PreKeyRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get publicKey => $_getN(1);
  @$pb.TagNumber(2)
  set publicKey($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);
}

class PreKeyBundle extends $pb.GeneratedMessage {
  factory PreKeyBundle({
    $core.List<$core.int>? identityKey,
    $core.int? registrationId,
    $core.int? signedPreKeyId,
    $core.List<$core.int>? signedPreKeyPublic,
    $core.List<$core.int>? signedPreKeySignature,
    $core.Iterable<PreKeyRecord>? preKeys,
  }) {
    final result = create();
    if (identityKey != null) result.identityKey = identityKey;
    if (registrationId != null) result.registrationId = registrationId;
    if (signedPreKeyId != null) result.signedPreKeyId = signedPreKeyId;
    if (signedPreKeyPublic != null)
      result.signedPreKeyPublic = signedPreKeyPublic;
    if (signedPreKeySignature != null)
      result.signedPreKeySignature = signedPreKeySignature;
    if (preKeys != null) result.preKeys.addAll(preKeys);
    return result;
  }

  PreKeyBundle._();

  factory PreKeyBundle.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PreKeyBundle.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PreKeyBundle',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sigmapb'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'identityKey', $pb.PbFieldType.OY)
    ..aI(2, _omitFieldNames ? '' : 'registrationId',
        fieldType: $pb.PbFieldType.OU3)
    ..aI(3, _omitFieldNames ? '' : 'signedPreKeyId')
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'signedPreKeyPublic', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'signedPreKeySignature', $pb.PbFieldType.OY)
    ..pPM<PreKeyRecord>(6, _omitFieldNames ? '' : 'preKeys',
        subBuilder: PreKeyRecord.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreKeyBundle clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PreKeyBundle copyWith(void Function(PreKeyBundle) updates) =>
      super.copyWith((message) => updates(message as PreKeyBundle))
          as PreKeyBundle;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreKeyBundle create() => PreKeyBundle._();
  @$core.override
  PreKeyBundle createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PreKeyBundle getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PreKeyBundle>(create);
  static PreKeyBundle? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get identityKey => $_getN(0);
  @$pb.TagNumber(1)
  set identityKey($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIdentityKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentityKey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get registrationId => $_getIZ(1);
  @$pb.TagNumber(2)
  set registrationId($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRegistrationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegistrationId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get signedPreKeyId => $_getIZ(2);
  @$pb.TagNumber(3)
  set signedPreKeyId($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSignedPreKeyId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignedPreKeyId() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get signedPreKeyPublic => $_getN(3);
  @$pb.TagNumber(4)
  set signedPreKeyPublic($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSignedPreKeyPublic() => $_has(3);
  @$pb.TagNumber(4)
  void clearSignedPreKeyPublic() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get signedPreKeySignature => $_getN(4);
  @$pb.TagNumber(5)
  set signedPreKeySignature($core.List<$core.int> value) =>
      $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSignedPreKeySignature() => $_has(4);
  @$pb.TagNumber(5)
  void clearSignedPreKeySignature() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<PreKeyRecord> get preKeys => $_getList(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');

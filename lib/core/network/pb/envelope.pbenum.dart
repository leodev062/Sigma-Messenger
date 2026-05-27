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

import 'package:protobuf/protobuf.dart' as $pb;

class Envelope_Type extends $pb.ProtobufEnum {
  static const Envelope_Type TYPE_UNKNOWN =
      Envelope_Type._(0, _omitEnumNames ? '' : 'TYPE_UNKNOWN');
  static const Envelope_Type CIPHERTEXT =
      Envelope_Type._(1, _omitEnumNames ? '' : 'CIPHERTEXT');
  static const Envelope_Type PREKEY_BUNDLE =
      Envelope_Type._(2, _omitEnumNames ? '' : 'PREKEY_BUNDLE');
  static const Envelope_Type RECEIPT =
      Envelope_Type._(3, _omitEnumNames ? '' : 'RECEIPT');

  static const $core.List<Envelope_Type> values = <Envelope_Type>[
    TYPE_UNKNOWN,
    CIPHERTEXT,
    PREKEY_BUNDLE,
    RECEIPT,
  ];

  static final $core.List<Envelope_Type?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static Envelope_Type? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Envelope_Type._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

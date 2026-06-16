// This is a generated file - do not edit.
//
// Generated from common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class EntityType extends $pb.ProtobufEnum {
  static const EntityType USER = EntityType._(0, _omitEnumNames ? '' : 'USER');
  static const EntityType BOT = EntityType._(1, _omitEnumNames ? '' : 'BOT');
  static const EntityType GROUP =
      EntityType._(2, _omitEnumNames ? '' : 'GROUP');
  static const EntityType CHANNEL =
      EntityType._(3, _omitEnumNames ? '' : 'CHANNEL');

  static const $core.List<EntityType> values = <EntityType>[
    USER,
    BOT,
    GROUP,
    CHANNEL,
  ];

  static final $core.List<EntityType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static EntityType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const EntityType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

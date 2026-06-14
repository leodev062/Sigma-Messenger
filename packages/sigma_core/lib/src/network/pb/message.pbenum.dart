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

import 'package:protobuf/protobuf.dart' as $pb;

class MessageType extends $pb.ProtobufEnum {
  static const MessageType TEXT =
      MessageType._(0, _omitEnumNames ? '' : 'TEXT');
  static const MessageType IMAGE =
      MessageType._(1, _omitEnumNames ? '' : 'IMAGE');
  static const MessageType VIDEO =
      MessageType._(2, _omitEnumNames ? '' : 'VIDEO');
  static const MessageType AUDIO =
      MessageType._(3, _omitEnumNames ? '' : 'AUDIO');
  static const MessageType POLL =
      MessageType._(4, _omitEnumNames ? '' : 'POLL');
  static const MessageType REPLY =
      MessageType._(5, _omitEnumNames ? '' : 'REPLY');
  static const MessageType REACTION =
      MessageType._(6, _omitEnumNames ? '' : 'REACTION');

  static const $core.List<MessageType> values = <MessageType>[
    TEXT,
    IMAGE,
    VIDEO,
    AUDIO,
    POLL,
    REPLY,
    REACTION,
  ];

  static final $core.List<MessageType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MessageType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MessageType._(super.value, super.name);
}

class MessageStatus extends $pb.ProtobufEnum {
  static const MessageStatus PENDING =
      MessageStatus._(0, _omitEnumNames ? '' : 'PENDING');
  static const MessageStatus SENT =
      MessageStatus._(1, _omitEnumNames ? '' : 'SENT');
  static const MessageStatus DELIVERED =
      MessageStatus._(2, _omitEnumNames ? '' : 'DELIVERED');
  static const MessageStatus READ =
      MessageStatus._(3, _omitEnumNames ? '' : 'READ');
  static const MessageStatus FAILED =
      MessageStatus._(4, _omitEnumNames ? '' : 'FAILED');

  static const $core.List<MessageStatus> values = <MessageStatus>[
    PENDING,
    SENT,
    DELIVERED,
    READ,
    FAILED,
  ];

  static final $core.List<MessageStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static MessageStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MessageStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

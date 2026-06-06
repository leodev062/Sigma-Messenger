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

class ReceiptMessage_ReceiptType extends $pb.ProtobufEnum {
  static const ReceiptMessage_ReceiptType UNKNOWN =
      ReceiptMessage_ReceiptType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const ReceiptMessage_ReceiptType DELIVERY =
      ReceiptMessage_ReceiptType._(1, _omitEnumNames ? '' : 'DELIVERY');
  static const ReceiptMessage_ReceiptType READ =
      ReceiptMessage_ReceiptType._(2, _omitEnumNames ? '' : 'READ');

  static const $core.List<ReceiptMessage_ReceiptType> values =
      <ReceiptMessage_ReceiptType>[
    UNKNOWN,
    DELIVERY,
    READ,
  ];

  static final $core.List<ReceiptMessage_ReceiptType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ReceiptMessage_ReceiptType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReceiptMessage_ReceiptType._(super.value, super.name);
}

class TypingMessage_TypingState extends $pb.ProtobufEnum {
  static const TypingMessage_TypingState STARTED =
      TypingMessage_TypingState._(0, _omitEnumNames ? '' : 'STARTED');
  static const TypingMessage_TypingState STOPPED =
      TypingMessage_TypingState._(1, _omitEnumNames ? '' : 'STOPPED');

  static const $core.List<TypingMessage_TypingState> values =
      <TypingMessage_TypingState>[
    STARTED,
    STOPPED,
  ];

  static final $core.List<TypingMessage_TypingState?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static TypingMessage_TypingState? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TypingMessage_TypingState._(super.value, super.name);
}

class SyncMessage_SyncType extends $pb.ProtobufEnum {
  static const SyncMessage_SyncType UNKNOWN =
      SyncMessage_SyncType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const SyncMessage_SyncType MESSAGE_STATUS_UPDATE =
      SyncMessage_SyncType._(1, _omitEnumNames ? '' : 'MESSAGE_STATUS_UPDATE');
  static const SyncMessage_SyncType THREAD_UPDATE =
      SyncMessage_SyncType._(2, _omitEnumNames ? '' : 'THREAD_UPDATE');
  static const SyncMessage_SyncType CONTACT_UPDATE =
      SyncMessage_SyncType._(3, _omitEnumNames ? '' : 'CONTACT_UPDATE');

  static const $core.List<SyncMessage_SyncType> values = <SyncMessage_SyncType>[
    UNKNOWN,
    MESSAGE_STATUS_UPDATE,
    THREAD_UPDATE,
    CONTACT_UPDATE,
  ];

  static final $core.List<SyncMessage_SyncType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static SyncMessage_SyncType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const SyncMessage_SyncType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');

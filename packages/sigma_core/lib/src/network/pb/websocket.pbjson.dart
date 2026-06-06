// This is a generated file - do not edit.
//
// Generated from websocket.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use webSocketMessageDescriptor instead')
const WebSocketMessage$json = {
  '1': 'WebSocketMessage',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.WebSocketMessage.Type',
      '10': 'type'
    },
    {
      '1': 'request',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.WebSocketRequestMessage',
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.WebSocketResponseMessage',
      '10': 'response'
    },
  ],
  '4': [WebSocketMessage_Type$json],
};

@$core.Deprecated('Use webSocketMessageDescriptor instead')
const WebSocketMessage_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'TYPE_UNKNOWN', '2': 0},
    {'1': 'REQUEST', '2': 1},
    {'1': 'RESPONSE', '2': 2},
    {'1': 'MESSAGE', '2': 3},
  ],
};

/// Descriptor for `WebSocketMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webSocketMessageDescriptor = $convert.base64Decode(
    'ChBXZWJTb2NrZXRNZXNzYWdlEjIKBHR5cGUYASABKA4yHi5zaWdtYXBiLldlYlNvY2tldE1lc3'
    'NhZ2UuVHlwZVIEdHlwZRI6CgdyZXF1ZXN0GAIgASgLMiAuc2lnbWFwYi5XZWJTb2NrZXRSZXF1'
    'ZXN0TWVzc2FnZVIHcmVxdWVzdBI9CghyZXNwb25zZRgDIAEoCzIhLnNpZ21hcGIuV2ViU29ja2'
    'V0UmVzcG9uc2VNZXNzYWdlUghyZXNwb25zZSJACgRUeXBlEhAKDFRZUEVfVU5LTk9XThAAEgsK'
    'B1JFUVVFU1QQARIMCghSRVNQT05TRRACEgsKB01FU1NBR0UQAw==');

@$core.Deprecated('Use webSocketRequestMessageDescriptor instead')
const WebSocketRequestMessage$json = {
  '1': 'WebSocketRequestMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'verb', '3': 2, '4': 1, '5': 9, '10': 'verb'},
    {'1': 'path', '3': 3, '4': 1, '5': 9, '10': 'path'},
    {'1': 'body', '3': 4, '4': 1, '5': 12, '10': 'body'},
  ],
};

/// Descriptor for `WebSocketRequestMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webSocketRequestMessageDescriptor =
    $convert.base64Decode(
        'ChdXZWJTb2NrZXRSZXF1ZXN0TWVzc2FnZRIOCgJpZBgBIAEoCVICaWQSEgoEdmVyYhgCIAEoCV'
        'IEdmVyYhISCgRwYXRoGAMgASgJUgRwYXRoEhIKBGJvZHkYBCABKAxSBGJvZHk=');

@$core.Deprecated('Use webSocketResponseMessageDescriptor instead')
const WebSocketResponseMessage$json = {
  '1': 'WebSocketResponseMessage',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'status', '3': 2, '4': 1, '5': 5, '10': 'status'},
    {'1': 'message', '3': 3, '4': 1, '5': 9, '10': 'message'},
    {'1': 'body', '3': 4, '4': 1, '5': 12, '10': 'body'},
  ],
};

/// Descriptor for `WebSocketResponseMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List webSocketResponseMessageDescriptor = $convert.base64Decode(
    'ChhXZWJTb2NrZXRSZXNwb25zZU1lc3NhZ2USDgoCaWQYASABKAlSAmlkEhYKBnN0YXR1cxgCIA'
    'EoBVIGc3RhdHVzEhgKB21lc3NhZ2UYAyABKAlSB21lc3NhZ2USEgoEYm9keRgEIAEoDFIEYm9k'
    'eQ==');

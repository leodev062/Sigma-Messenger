// This is a generated file - do not edit.
//
// Generated from envelope.proto.

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

@$core.Deprecated('Use envelopeDescriptor instead')
const Envelope$json = {
  '1': 'Envelope',
  '2': [
    {'1': 'envelopeId', '3': 1, '4': 1, '5': 9, '10': 'envelopeId'},
    {'1': 'from', '3': 2, '4': 1, '5': 9, '10': 'from'},
    {'1': 'to', '3': 3, '4': 1, '5': 9, '10': 'to'},
    {'1': 'payload', '3': 4, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'createdAt', '3': 6, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'deliverAt', '3': 7, '4': 1, '5': 3, '10': 'deliverAt'},
  ],
};

/// Descriptor for `Envelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeDescriptor = $convert.base64Decode(
    'CghFbnZlbG9wZRIeCgplbnZlbG9wZUlkGAEgASgJUgplbnZlbG9wZUlkEhIKBGZyb20YAiABKA'
    'lSBGZyb20SDgoCdG8YAyABKAlSAnRvEhgKB3BheWxvYWQYBCABKAxSB3BheWxvYWQSFgoGc3Rh'
    'dHVzGAUgASgJUgZzdGF0dXMSHAoJY3JlYXRlZEF0GAYgASgDUgljcmVhdGVkQXQSHAoJZGVsaX'
    'ZlckF0GAcgASgDUglkZWxpdmVyQXQ=');

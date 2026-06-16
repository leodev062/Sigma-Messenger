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
    {'1': 'envelope_id', '3': 1, '4': 1, '5': 9, '10': 'envelopeId'},
    {'1': 'from', '3': 2, '4': 1, '5': 9, '10': 'from'},
    {'1': 'to', '3': 3, '4': 1, '5': 9, '10': 'to'},
    {'1': 'payload', '3': 4, '4': 1, '5': 12, '10': 'payload'},
    {'1': 'status', '3': 5, '4': 1, '5': 9, '10': 'status'},
    {'1': 'created_at', '3': 6, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'deliver_at', '3': 7, '4': 1, '5': 3, '10': 'deliverAt'},
    {
      '1': 'destination_type',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.EntityType',
      '10': 'destinationType'
    },
    {'1': 'destination_id', '3': 9, '4': 1, '5': 9, '10': 'destinationId'},
    {'1': 'type', '3': 10, '4': 1, '5': 13, '10': 'type'},
    {'1': 'source', '3': 11, '4': 1, '5': 9, '10': 'source'},
    {'1': 'source_device', '3': 12, '4': 1, '5': 13, '10': 'sourceDevice'},
    {'1': 'timestamp', '3': 13, '4': 1, '5': 4, '10': 'timestamp'},
  ],
};

/// Descriptor for `Envelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeDescriptor = $convert.base64Decode(
    'CghFbnZlbG9wZRIfCgtlbnZlbG9wZV9pZBgBIAEoCVIKZW52ZWxvcGVJZBISCgRmcm9tGAIgAS'
    'gJUgRmcm9tEg4KAnRvGAMgASgJUgJ0bxIYCgdwYXlsb2FkGAQgASgMUgdwYXlsb2FkEhYKBnN0'
    'YXR1cxgFIAEoCVIGc3RhdHVzEh0KCmNyZWF0ZWRfYXQYBiABKANSCWNyZWF0ZWRBdBIdCgpkZW'
    'xpdmVyX2F0GAcgASgDUglkZWxpdmVyQXQSPgoQZGVzdGluYXRpb25fdHlwZRgIIAEoDjITLnNp'
    'Z21hcGIuRW50aXR5VHlwZVIPZGVzdGluYXRpb25UeXBlEiUKDmRlc3RpbmF0aW9uX2lkGAkgAS'
    'gJUg1kZXN0aW5hdGlvbklkEhIKBHR5cGUYCiABKA1SBHR5cGUSFgoGc291cmNlGAsgASgJUgZz'
    'b3VyY2USIwoNc291cmNlX2RldmljZRgMIAEoDVIMc291cmNlRGV2aWNlEhwKCXRpbWVzdGFtcB'
    'gNIAEoBFIJdGltZXN0YW1w');

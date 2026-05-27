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
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.Envelope.Type',
      '10': 'type'
    },
    {'1': 'source', '3': 2, '4': 1, '5': 9, '10': 'source'},
    {'1': 'source_device', '3': 3, '4': 1, '5': 13, '10': 'sourceDevice'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'content', '3': 5, '4': 1, '5': 12, '10': 'content'},
  ],
  '4': [Envelope_Type$json],
};

@$core.Deprecated('Use envelopeDescriptor instead')
const Envelope_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'TYPE_UNKNOWN', '2': 0},
    {'1': 'CIPHERTEXT', '2': 1},
    {'1': 'PREKEY_BUNDLE', '2': 2},
    {'1': 'RECEIPT', '2': 3},
  ],
};

/// Descriptor for `Envelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List envelopeDescriptor = $convert.base64Decode(
    'CghFbnZlbG9wZRIqCgR0eXBlGAEgASgOMhYuc2lnbWFwYi5FbnZlbG9wZS5UeXBlUgR0eXBlEh'
    'YKBnNvdXJjZRgCIAEoCVIGc291cmNlEiMKDXNvdXJjZV9kZXZpY2UYAyABKA1SDHNvdXJjZURl'
    'dmljZRIcCgl0aW1lc3RhbXAYBCABKARSCXRpbWVzdGFtcBIYCgdjb250ZW50GAUgASgMUgdjb2'
    '50ZW50IkgKBFR5cGUSEAoMVFlQRV9VTktOT1dOEAASDgoKQ0lQSEVSVEVYVBABEhEKDVBSRUtF'
    'WV9CVU5ETEUQAhILCgdSRUNFSVBUEAM=');

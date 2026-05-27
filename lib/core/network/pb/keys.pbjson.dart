// This is a generated file - do not edit.
//
// Generated from keys.proto.

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

@$core.Deprecated('Use preKeyRecordDescriptor instead')
const PreKeyRecord$json = {
  '1': 'PreKeyRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'public_key', '3': 2, '4': 1, '5': 12, '10': 'publicKey'},
  ],
};

/// Descriptor for `PreKeyRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preKeyRecordDescriptor = $convert.base64Decode(
    'CgxQcmVLZXlSZWNvcmQSDgoCaWQYASABKAVSAmlkEh0KCnB1YmxpY19rZXkYAiABKAxSCXB1Ym'
    'xpY0tleQ==');

@$core.Deprecated('Use preKeyBundleDescriptor instead')
const PreKeyBundle$json = {
  '1': 'PreKeyBundle',
  '2': [
    {'1': 'identity_key', '3': 1, '4': 1, '5': 12, '10': 'identityKey'},
    {'1': 'registration_id', '3': 2, '4': 1, '5': 13, '10': 'registrationId'},
    {'1': 'signed_pre_key_id', '3': 3, '4': 1, '5': 5, '10': 'signedPreKeyId'},
    {
      '1': 'signed_pre_key_public',
      '3': 4,
      '4': 1,
      '5': 12,
      '10': 'signedPreKeyPublic'
    },
    {
      '1': 'signed_pre_key_signature',
      '3': 5,
      '4': 1,
      '5': 12,
      '10': 'signedPreKeySignature'
    },
    {
      '1': 'pre_keys',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.sigmapb.PreKeyRecord',
      '10': 'preKeys'
    },
  ],
};

/// Descriptor for `PreKeyBundle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List preKeyBundleDescriptor = $convert.base64Decode(
    'CgxQcmVLZXlCdW5kbGUSIQoMaWRlbnRpdHlfa2V5GAEgASgMUgtpZGVudGl0eUtleRInCg9yZW'
    'dpc3RyYXRpb25faWQYAiABKA1SDnJlZ2lzdHJhdGlvbklkEikKEXNpZ25lZF9wcmVfa2V5X2lk'
    'GAMgASgFUg5zaWduZWRQcmVLZXlJZBIxChVzaWduZWRfcHJlX2tleV9wdWJsaWMYBCABKAxSEn'
    'NpZ25lZFByZUtleVB1YmxpYxI3ChhzaWduZWRfcHJlX2tleV9zaWduYXR1cmUYBSABKAxSFXNp'
    'Z25lZFByZUtleVNpZ25hdHVyZRIwCghwcmVfa2V5cxgGIAMoCzIVLnNpZ21hcGIuUHJlS2V5Um'
    'Vjb3JkUgdwcmVLZXlz');

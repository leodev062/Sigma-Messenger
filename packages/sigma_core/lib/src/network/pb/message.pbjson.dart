// This is a generated file - do not edit.
//
// Generated from message.proto.

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

@$core.Deprecated('Use contentDescriptor instead')
const Content$json = {
  '1': 'Content',
  '2': [
    {
      '1': 'dataMessage',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.DataMessage',
      '9': 0,
      '10': 'dataMessage'
    },
    {
      '1': 'receipt',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.ReceiptMessage',
      '9': 0,
      '10': 'receipt'
    },
    {
      '1': 'typing',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.TypingMessage',
      '9': 0,
      '10': 'typing'
    },
    {
      '1': 'sync',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.SyncMessage',
      '9': 0,
      '10': 'sync'
    },
  ],
  '8': [
    {'1': 'content'},
  ],
};

/// Descriptor for `Content`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contentDescriptor = $convert.base64Decode(
    'CgdDb250ZW50EjgKC2RhdGFNZXNzYWdlGAEgASgLMhQuc2lnbWFwYi5EYXRhTWVzc2FnZUgAUg'
    'tkYXRhTWVzc2FnZRIzCgdyZWNlaXB0GAIgASgLMhcuc2lnbWFwYi5SZWNlaXB0TWVzc2FnZUgA'
    'UgdyZWNlaXB0EjAKBnR5cGluZxgDIAEoCzIWLnNpZ21hcGIuVHlwaW5nTWVzc2FnZUgAUgZ0eX'
    'BpbmcSKgoEc3luYxgEIAEoCzIULnNpZ21hcGIuU3luY01lc3NhZ2VIAFIEc3luY0IJCgdjb250'
    'ZW50');

@$core.Deprecated('Use dataMessageDescriptor instead')
const DataMessage$json = {
  '1': 'DataMessage',
  '2': [
    {'1': 'body', '3': 1, '4': 1, '5': 9, '10': 'body'},
    {
      '1': 'attachment',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.AttachmentPointer',
      '10': 'attachment'
    },
    {
      '1': 'reaction',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.Reaction',
      '10': 'reaction'
    },
    {
      '1': 'location',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.Location',
      '10': 'location'
    },
    {
      '1': 'pollCreate',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollCreate',
      '10': 'pollCreate'
    },
    {
      '1': 'pollVote',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollVote',
      '10': 'pollVote'
    },
    {
      '1': 'pollTerminate',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollTerminate',
      '10': 'pollTerminate'
    },
  ],
};

/// Descriptor for `DataMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataMessageDescriptor = $convert.base64Decode(
    'CgtEYXRhTWVzc2FnZRISCgRib2R5GAEgASgJUgRib2R5EjoKCmF0dGFjaG1lbnQYAiABKAsyGi'
    '5zaWdtYXBiLkF0dGFjaG1lbnRQb2ludGVyUgphdHRhY2htZW50Ei0KCHJlYWN0aW9uGAMgASgL'
    'MhEuc2lnbWFwYi5SZWFjdGlvblIIcmVhY3Rpb24SLQoIbG9jYXRpb24YBCABKAsyES5zaWdtYX'
    'BiLkxvY2F0aW9uUghsb2NhdGlvbhIzCgpwb2xsQ3JlYXRlGAUgASgLMhMuc2lnbWFwYi5Qb2xs'
    'Q3JlYXRlUgpwb2xsQ3JlYXRlEi0KCHBvbGxWb3RlGAYgASgLMhEuc2lnbWFwYi5Qb2xsVm90ZV'
    'IIcG9sbFZvdGUSPAoNcG9sbFRlcm1pbmF0ZRgHIAEoCzIWLnNpZ21hcGIuUG9sbFRlcm1pbmF0'
    'ZVINcG9sbFRlcm1pbmF0ZQ==');

@$core.Deprecated('Use pollCreateDescriptor instead')
const PollCreate$json = {
  '1': 'PollCreate',
  '2': [
    {'1': 'question', '3': 1, '4': 1, '5': 9, '10': 'question'},
    {'1': 'options', '3': 2, '4': 3, '5': 9, '10': 'options'},
    {
      '1': 'allow_multiple_votes',
      '3': 3,
      '4': 1,
      '5': 8,
      '10': 'allowMultipleVotes'
    },
  ],
};

/// Descriptor for `PollCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollCreateDescriptor = $convert.base64Decode(
    'CgpQb2xsQ3JlYXRlEhoKCHF1ZXN0aW9uGAEgASgJUghxdWVzdGlvbhIYCgdvcHRpb25zGAIgAy'
    'gJUgdvcHRpb25zEjAKFGFsbG93X211bHRpcGxlX3ZvdGVzGAMgASgIUhJhbGxvd011bHRpcGxl'
    'Vm90ZXM=');

@$core.Deprecated('Use pollVoteDescriptor instead')
const PollVote$json = {
  '1': 'PollVote',
  '2': [
    {'1': 'target_author_aci', '3': 1, '4': 1, '5': 9, '10': 'targetAuthorAci'},
    {
      '1': 'target_sent_timestamp',
      '3': 2,
      '4': 1,
      '5': 4,
      '10': 'targetSentTimestamp'
    },
    {'1': 'option_indexes', '3': 3, '4': 3, '5': 13, '10': 'optionIndexes'},
    {'1': 'vote_count', '3': 4, '4': 1, '5': 13, '10': 'voteCount'},
  ],
};

/// Descriptor for `PollVote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollVoteDescriptor = $convert.base64Decode(
    'CghQb2xsVm90ZRIqChF0YXJnZXRfYXV0aG9yX2FjaRgBIAEoCVIPdGFyZ2V0QXV0aG9yQWNpEj'
    'IKFXRhcmdldF9zZW50X3RpbWVzdGFtcBgCIAEoBFITdGFyZ2V0U2VudFRpbWVzdGFtcBIlCg5v'
    'cHRpb25faW5kZXhlcxgDIAMoDVINb3B0aW9uSW5kZXhlcxIdCgp2b3RlX2NvdW50GAQgASgNUg'
    'l2b3RlQ291bnQ=');

@$core.Deprecated('Use pollTerminateDescriptor instead')
const PollTerminate$json = {
  '1': 'PollTerminate',
  '2': [
    {
      '1': 'target_sent_timestamp',
      '3': 1,
      '4': 1,
      '5': 4,
      '10': 'targetSentTimestamp'
    },
  ],
};

/// Descriptor for `PollTerminate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollTerminateDescriptor = $convert.base64Decode(
    'Cg1Qb2xsVGVybWluYXRlEjIKFXRhcmdldF9zZW50X3RpbWVzdGFtcBgBIAEoBFITdGFyZ2V0U2'
    'VudFRpbWVzdGFtcA==');

@$core.Deprecated('Use attachmentPointerDescriptor instead')
const AttachmentPointer$json = {
  '1': 'AttachmentPointer',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'key', '3': 2, '4': 1, '5': 12, '10': 'key'},
    {'1': 'iv', '3': 3, '4': 1, '5': 12, '10': 'iv'},
    {'1': 'digest', '3': 4, '4': 1, '5': 12, '10': 'digest'},
    {'1': 'fileName', '3': 5, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'size', '3': 6, '4': 1, '5': 13, '10': 'size'},
  ],
};

/// Descriptor for `AttachmentPointer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List attachmentPointerDescriptor = $convert.base64Decode(
    'ChFBdHRhY2htZW50UG9pbnRlchIOCgJpZBgBIAEoCVICaWQSEAoDa2V5GAIgASgMUgNrZXkSDg'
    'oCaXYYAyABKAxSAml2EhYKBmRpZ2VzdBgEIAEoDFIGZGlnZXN0EhoKCGZpbGVOYW1lGAUgASgJ'
    'UghmaWxlTmFtZRISCgRzaXplGAYgASgNUgRzaXpl');

@$core.Deprecated('Use reactionDescriptor instead')
const Reaction$json = {
  '1': 'Reaction',
  '2': [
    {'1': 'emoji', '3': 1, '4': 1, '5': 9, '10': 'emoji'},
    {'1': 'remove', '3': 2, '4': 1, '5': 8, '10': 'remove'},
    {'1': 'targetAuthorAci', '3': 3, '4': 1, '5': 9, '10': 'targetAuthorAci'},
    {'1': 'targetTimestamp', '3': 4, '4': 1, '5': 4, '10': 'targetTimestamp'},
  ],
};

/// Descriptor for `Reaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reactionDescriptor = $convert.base64Decode(
    'CghSZWFjdGlvbhIUCgVlbW9qaRgBIAEoCVIFZW1vamkSFgoGcmVtb3ZlGAIgASgIUgZyZW1vdm'
    'USKAoPdGFyZ2V0QXV0aG9yQWNpGAMgASgJUg90YXJnZXRBdXRob3JBY2kSKAoPdGFyZ2V0VGlt'
    'ZXN0YW1wGAQgASgEUg90YXJnZXRUaW1lc3RhbXA=');

@$core.Deprecated('Use locationDescriptor instead')
const Location$json = {
  '1': 'Location',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode(
    'CghMb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAS'
    'gBUglsb25naXR1ZGUSGAoHYWRkcmVzcxgDIAEoCVIHYWRkcmVzcw==');

@$core.Deprecated('Use receiptMessageDescriptor instead')
const ReceiptMessage$json = {
  '1': 'ReceiptMessage',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.ReceiptMessage.ReceiptType',
      '10': 'type'
    },
    {'1': 'messageId', '3': 2, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'senderId', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'messageCount', '3': 5, '4': 1, '5': 13, '10': 'messageCount'},
  ],
  '4': [ReceiptMessage_ReceiptType$json],
};

@$core.Deprecated('Use receiptMessageDescriptor instead')
const ReceiptMessage_ReceiptType$json = {
  '1': 'ReceiptType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'DELIVERY', '2': 1},
    {'1': 'READ', '2': 2},
  ],
};

/// Descriptor for `ReceiptMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List receiptMessageDescriptor = $convert.base64Decode(
    'Cg5SZWNlaXB0TWVzc2FnZRI3CgR0eXBlGAEgASgOMiMuc2lnbWFwYi5SZWNlaXB0TWVzc2FnZS'
    '5SZWNlaXB0VHlwZVIEdHlwZRIcCgltZXNzYWdlSWQYAiABKAlSCW1lc3NhZ2VJZBIaCghzZW5k'
    'ZXJJZBgDIAEoCVIIc2VuZGVySWQSHAoJdGltZXN0YW1wGAQgASgEUgl0aW1lc3RhbXASIgoMbW'
    'Vzc2FnZUNvdW50GAUgASgNUgxtZXNzYWdlQ291bnQiMgoLUmVjZWlwdFR5cGUSCwoHVU5LTk9X'
    'ThAAEgwKCERFTElWRVJZEAESCAoEUkVBRBAC');

@$core.Deprecated('Use typingMessageDescriptor instead')
const TypingMessage$json = {
  '1': 'TypingMessage',
  '2': [
    {
      '1': 'state',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.TypingMessage.TypingState',
      '10': 'state'
    },
    {'1': 'timestamp', '3': 2, '4': 1, '5': 4, '10': 'timestamp'},
  ],
  '4': [TypingMessage_TypingState$json],
};

@$core.Deprecated('Use typingMessageDescriptor instead')
const TypingMessage_TypingState$json = {
  '1': 'TypingState',
  '2': [
    {'1': 'STARTED', '2': 0},
    {'1': 'STOPPED', '2': 1},
  ],
};

/// Descriptor for `TypingMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typingMessageDescriptor = $convert.base64Decode(
    'Cg1UeXBpbmdNZXNzYWdlEjgKBXN0YXRlGAEgASgOMiIuc2lnbWFwYi5UeXBpbmdNZXNzYWdlLl'
    'R5cGluZ1N0YXRlUgVzdGF0ZRIcCgl0aW1lc3RhbXAYAiABKARSCXRpbWVzdGFtcCInCgtUeXBp'
    'bmdTdGF0ZRILCgdTVEFSVEVEEAASCwoHU1RPUFBFRBAB');

@$core.Deprecated('Use syncMessageDescriptor instead')
const SyncMessage$json = {
  '1': 'SyncMessage',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.SyncMessage.SyncType',
      '10': 'type'
    },
    {'1': 'messageId', '3': 2, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'status', '3': 3, '4': 1, '5': 5, '10': 'status'},
    {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'targetIds', '3': 6, '4': 3, '5': 9, '10': 'targetIds'},
  ],
  '4': [SyncMessage_SyncType$json],
};

@$core.Deprecated('Use syncMessageDescriptor instead')
const SyncMessage_SyncType$json = {
  '1': 'SyncType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'MESSAGE_STATUS_UPDATE', '2': 1},
    {'1': 'THREAD_UPDATE', '2': 2},
    {'1': 'CONTACT_UPDATE', '2': 3},
  ],
};

/// Descriptor for `SyncMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List syncMessageDescriptor = $convert.base64Decode(
    'CgtTeW5jTWVzc2FnZRIxCgR0eXBlGAEgASgOMh0uc2lnbWFwYi5TeW5jTWVzc2FnZS5TeW5jVH'
    'lwZVIEdHlwZRIcCgltZXNzYWdlSWQYAiABKAlSCW1lc3NhZ2VJZBIWCgZzdGF0dXMYAyABKAVS'
    'BnN0YXR1cxIUCgVlcnJvchgEIAEoCVIFZXJyb3ISHAoJdGltZXN0YW1wGAUgASgEUgl0aW1lc3'
    'RhbXASHAoJdGFyZ2V0SWRzGAYgAygJUgl0YXJnZXRJZHMiWQoIU3luY1R5cGUSCwoHVU5LTk9X'
    'ThAAEhkKFU1FU1NBR0VfU1RBVFVTX1VQREFURRABEhEKDVRIUkVBRF9VUERBVEUQAhISCg5DT0'
    '5UQUNUX1VQREFURRAD');

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

@$core.Deprecated('Use conversationTypeDescriptor instead')
const ConversationType$json = {
  '1': 'ConversationType',
  '2': [
    {'1': 'CONVERSATION_TYPE_DIRECT', '2': 0},
    {'1': 'CONVERSATION_TYPE_GROUP', '2': 1},
    {'1': 'CONVERSATION_TYPE_CHANNEL', '2': 2},
    {'1': 'CONVERSATION_TYPE_BOT', '2': 3},
  ],
};

/// Descriptor for `ConversationType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List conversationTypeDescriptor = $convert.base64Decode(
    'ChBDb252ZXJzYXRpb25UeXBlEhwKGENPTlZFUlNBVElPTl9UWVBFX0RJUkVDVBAAEhsKF0NPTl'
    'ZFUlNBVElPTl9UWVBFX0dST1VQEAESHQoZQ09OVkVSU0FUSU9OX1RZUEVfQ0hBTk5FTBACEhkK'
    'FUNPTlZFUlNBVElPTl9UWVBFX0JPVBAD');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'conversation_id', '3': 2, '4': 1, '5': 9, '10': 'conversationId'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {
      '1': 'sender_type',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.EntityType',
      '10': 'senderType'
    },
    {'1': 'destination_id', '3': 5, '4': 1, '5': 9, '10': 'destinationId'},
    {
      '1': 'destination_type',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.sigmapb.EntityType',
      '10': 'destinationType'
    },
    {'1': 'type', '3': 7, '4': 1, '5': 13, '10': 'type'},
    {'1': 'timestamp', '3': 8, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'updated_at', '3': 9, '4': 1, '5': 3, '10': 'updatedAt'},
    {'1': 'status', '3': 10, '4': 1, '5': 13, '10': 'status'},
    {
      '1': 'text',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.TextContent',
      '9': 0,
      '10': 'text'
    },
    {
      '1': 'data_message',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.DataMessage',
      '9': 0,
      '10': 'dataMessage'
    },
    {
      '1': 'receipt',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.ReceiptMessage',
      '9': 0,
      '10': 'receipt'
    },
    {
      '1': 'typing',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.TypingMessage',
      '9': 0,
      '10': 'typing'
    },
    {
      '1': 'sync',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.SyncMessage',
      '9': 0,
      '10': 'sync'
    },
    {
      '1': 'poll_vote',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollVote',
      '9': 0,
      '10': 'pollVote'
    },
    {
      '1': 'image',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.ImageContent',
      '9': 0,
      '10': 'image'
    },
    {
      '1': 'video',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.VideoContent',
      '9': 0,
      '10': 'video'
    },
    {
      '1': 'audio',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.AudioContent',
      '9': 0,
      '10': 'audio'
    },
    {
      '1': 'poll',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollContent',
      '9': 0,
      '10': 'poll'
    },
    {
      '1': 'reaction',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.ReactionContent',
      '9': 0,
      '10': 'reaction'
    },
  ],
  '8': [
    {'1': 'content'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEh0KCm1lc3NhZ2VfaWQYASABKAlSCW1lc3NhZ2VJZBInCg9jb252ZXJzYXRpb2'
    '5faWQYAiABKAlSDmNvbnZlcnNhdGlvbklkEhsKCXNlbmRlcl9pZBgDIAEoCVIIc2VuZGVySWQS'
    'NAoLc2VuZGVyX3R5cGUYBCABKA4yEy5zaWdtYXBiLkVudGl0eVR5cGVSCnNlbmRlclR5cGUSJQ'
    'oOZGVzdGluYXRpb25faWQYBSABKAlSDWRlc3RpbmF0aW9uSWQSPgoQZGVzdGluYXRpb25fdHlw'
    'ZRgGIAEoDjITLnNpZ21hcGIuRW50aXR5VHlwZVIPZGVzdGluYXRpb25UeXBlEhIKBHR5cGUYBy'
    'ABKA1SBHR5cGUSHAoJdGltZXN0YW1wGAggASgDUgl0aW1lc3RhbXASHQoKdXBkYXRlZF9hdBgJ'
    'IAEoA1IJdXBkYXRlZEF0EhYKBnN0YXR1cxgKIAEoDVIGc3RhdHVzEioKBHRleHQYCyABKAsyFC'
    '5zaWdtYXBiLlRleHRDb250ZW50SABSBHRleHQSOQoMZGF0YV9tZXNzYWdlGAwgASgLMhQuc2ln'
    'bWFwYi5EYXRhTWVzc2FnZUgAUgtkYXRhTWVzc2FnZRIzCgdyZWNlaXB0GA0gASgLMhcuc2lnbW'
    'FwYi5SZWNlaXB0TWVzc2FnZUgAUgdyZWNlaXB0EjAKBnR5cGluZxgOIAEoCzIWLnNpZ21hcGIu'
    'VHlwaW5nTWVzc2FnZUgAUgZ0eXBpbmcSKgoEc3luYxgPIAEoCzIULnNpZ21hcGIuU3luY01lc3'
    'NhZ2VIAFIEc3luYxIwCglwb2xsX3ZvdGUYECABKAsyES5zaWdtYXBiLlBvbGxWb3RlSABSCHBv'
    'bGxWb3RlEi0KBWltYWdlGBEgASgLMhUuc2lnbWFwYi5JbWFnZUNvbnRlbnRIAFIFaW1hZ2USLQ'
    'oFdmlkZW8YEiABKAsyFS5zaWdtYXBiLlZpZGVvQ29udGVudEgAUgV2aWRlbxItCgVhdWRpbxgT'
    'IAEoCzIVLnNpZ21hcGIuQXVkaW9Db250ZW50SABSBWF1ZGlvEioKBHBvbGwYFCABKAsyFC5zaW'
    'dtYXBiLlBvbGxDb250ZW50SABSBHBvbGwSNgoIcmVhY3Rpb24YFSABKAsyGC5zaWdtYXBiLlJl'
    'YWN0aW9uQ29udGVudEgAUghyZWFjdGlvbkIJCgdjb250ZW50');

@$core.Deprecated('Use textContentDescriptor instead')
const TextContent$json = {
  '1': 'TextContent',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
  ],
};

/// Descriptor for `TextContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textContentDescriptor =
    $convert.base64Decode('CgtUZXh0Q29udGVudBISCgR0ZXh0GAEgASgJUgR0ZXh0');

@$core.Deprecated('Use imageContentDescriptor instead')
const ImageContent$json = {
  '1': 'ImageContent',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'thumbnail', '3': 2, '4': 1, '5': 9, '10': 'thumbnail'},
    {'1': 'width', '3': 3, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 4, '4': 1, '5': 5, '10': 'height'},
  ],
};

/// Descriptor for `ImageContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageContentDescriptor = $convert.base64Decode(
    'CgxJbWFnZUNvbnRlbnQSEAoDdXJsGAEgASgJUgN1cmwSHAoJdGh1bWJuYWlsGAIgASgJUgl0aH'
    'VtYm5haWwSFAoFd2lkdGgYAyABKAVSBXdpZHRoEhYKBmhlaWdodBgEIAEoBVIGaGVpZ2h0');

@$core.Deprecated('Use videoContentDescriptor instead')
const VideoContent$json = {
  '1': 'VideoContent',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'thumbnail', '3': 2, '4': 1, '5': 9, '10': 'thumbnail'},
    {'1': 'duration', '3': 3, '4': 1, '5': 3, '10': 'duration'},
  ],
};

/// Descriptor for `VideoContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoContentDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NvbnRlbnQSEAoDdXJsGAEgASgJUgN1cmwSHAoJdGh1bWJuYWlsGAIgASgJUgl0aH'
    'VtYm5haWwSGgoIZHVyYXRpb24YAyABKANSCGR1cmF0aW9u');

@$core.Deprecated('Use audioContentDescriptor instead')
const AudioContent$json = {
  '1': 'AudioContent',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'duration', '3': 2, '4': 1, '5': 3, '10': 'duration'},
  ],
};

/// Descriptor for `AudioContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List audioContentDescriptor = $convert.base64Decode(
    'CgxBdWRpb0NvbnRlbnQSEAoDdXJsGAEgASgJUgN1cmwSGgoIZHVyYXRpb24YAiABKANSCGR1cm'
    'F0aW9u');

@$core.Deprecated('Use pollOptionDescriptor instead')
const PollOption$json = {
  '1': 'PollOption',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'text', '3': 2, '4': 1, '5': 9, '10': 'text'},
    {'1': 'votes', '3': 3, '4': 1, '5': 5, '10': 'votes'},
  ],
};

/// Descriptor for `PollOption`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollOptionDescriptor = $convert.base64Decode(
    'CgpQb2xsT3B0aW9uEg4KAmlkGAEgASgJUgJpZBISCgR0ZXh0GAIgASgJUgR0ZXh0EhQKBXZvdG'
    'VzGAMgASgFUgV2b3Rlcw==');

@$core.Deprecated('Use pollContentDescriptor instead')
const PollContent$json = {
  '1': 'PollContent',
  '2': [
    {'1': 'question', '3': 1, '4': 1, '5': 9, '10': 'question'},
    {
      '1': 'options',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sigmapb.PollOption',
      '10': 'options'
    },
    {'1': 'multiple_choice', '3': 3, '4': 1, '5': 8, '10': 'multipleChoice'},
  ],
};

/// Descriptor for `PollContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollContentDescriptor = $convert.base64Decode(
    'CgtQb2xsQ29udGVudBIaCghxdWVzdGlvbhgBIAEoCVIIcXVlc3Rpb24SLQoHb3B0aW9ucxgCIA'
    'MoCzITLnNpZ21hcGIuUG9sbE9wdGlvblIHb3B0aW9ucxInCg9tdWx0aXBsZV9jaG9pY2UYAyAB'
    'KAhSDm11bHRpcGxlQ2hvaWNl');

@$core.Deprecated('Use reactionContentDescriptor instead')
const ReactionContent$json = {
  '1': 'ReactionContent',
  '2': [
    {'1': 'message_id', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'emoji', '3': 2, '4': 1, '5': 9, '10': 'emoji'},
  ],
};

/// Descriptor for `ReactionContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reactionContentDescriptor = $convert.base64Decode(
    'Cg9SZWFjdGlvbkNvbnRlbnQSHQoKbWVzc2FnZV9pZBgBIAEoCVIJbWVzc2FnZUlkEhQKBWVtb2'
    'ppGAIgASgJUgVlbW9qaQ==');

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
      '1': 'poll_create',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sigmapb.PollCreate',
      '10': 'pollCreate'
    },
    {
      '1': 'poll_terminate',
      '3': 6,
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
    'BiLkxvY2F0aW9uUghsb2NhdGlvbhI0Cgtwb2xsX2NyZWF0ZRgFIAEoCzITLnNpZ21hcGIuUG9s'
    'bENyZWF0ZVIKcG9sbENyZWF0ZRI9Cg5wb2xsX3Rlcm1pbmF0ZRgGIAEoCzIWLnNpZ21hcGIuUG'
    '9sbFRlcm1pbmF0ZVINcG9sbFRlcm1pbmF0ZQ==');

@$core.Deprecated('Use pollCreateDescriptor instead')
const PollCreate$json = {
  '1': 'PollCreate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'question', '3': 2, '4': 1, '5': 9, '10': 'question'},
    {
      '1': 'options',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sigmapb.PollOption',
      '10': 'options'
    },
    {'1': 'multiple_choice', '3': 4, '4': 1, '5': 8, '10': 'multipleChoice'},
  ],
};

/// Descriptor for `PollCreate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollCreateDescriptor = $convert.base64Decode(
    'CgpQb2xsQ3JlYXRlEg4KAmlkGAEgASgJUgJpZBIaCghxdWVzdGlvbhgCIAEoCVIIcXVlc3Rpb2'
    '4SLQoHb3B0aW9ucxgDIAMoCzITLnNpZ21hcGIuUG9sbE9wdGlvblIHb3B0aW9ucxInCg9tdWx0'
    'aXBsZV9jaG9pY2UYBCABKAhSDm11bHRpcGxlQ2hvaWNl');

@$core.Deprecated('Use pollVoteDescriptor instead')
const PollVote$json = {
  '1': 'PollVote',
  '2': [
    {'1': 'poll_id', '3': 1, '4': 1, '5': 9, '10': 'pollId'},
    {'1': 'option_id', '3': 2, '4': 1, '5': 9, '10': 'optionId'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
  ],
};

/// Descriptor for `PollVote`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollVoteDescriptor = $convert.base64Decode(
    'CghQb2xsVm90ZRIXCgdwb2xsX2lkGAEgASgJUgZwb2xsSWQSGwoJb3B0aW9uX2lkGAIgASgJUg'
    'hvcHRpb25JZBIXCgd1c2VyX2lkGAMgASgJUgZ1c2VySWQSHAoJdGltZXN0YW1wGAQgASgEUgl0'
    'aW1lc3RhbXA=');

@$core.Deprecated('Use pollTerminateDescriptor instead')
const PollTerminate$json = {
  '1': 'PollTerminate',
  '2': [
    {'1': 'poll_id', '3': 1, '4': 1, '5': 9, '10': 'pollId'},
  ],
};

/// Descriptor for `PollTerminate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollTerminateDescriptor = $convert
    .base64Decode('Cg1Qb2xsVGVybWluYXRlEhcKB3BvbGxfaWQYASABKAlSBnBvbGxJZA==');

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
    {'1': 'target_author_aci', '3': 3, '4': 1, '5': 9, '10': 'targetAuthorAci'},
    {'1': 'target_timestamp', '3': 4, '4': 1, '5': 4, '10': 'targetTimestamp'},
  ],
};

/// Descriptor for `Reaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reactionDescriptor = $convert.base64Decode(
    'CghSZWFjdGlvbhIUCgVlbW9qaRgBIAEoCVIFZW1vamkSFgoGcmVtb3ZlGAIgASgIUgZyZW1vdm'
    'USKgoRdGFyZ2V0X2F1dGhvcl9hY2kYAyABKAlSD3RhcmdldEF1dGhvckFjaRIpChB0YXJnZXRf'
    'dGltZXN0YW1wGAQgASgEUg90YXJnZXRUaW1lc3RhbXA=');

@$core.Deprecated('Use locationDescriptor instead')
const Location$json = {
  '1': 'Location',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
    {'1': 'accuracy', '3': 4, '4': 1, '5': 1, '10': 'accuracy'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'is_live', '3': 6, '4': 1, '5': 8, '10': 'isLive'},
    {'1': 'duration', '3': 7, '4': 1, '5': 13, '10': 'duration'},
  ],
};

/// Descriptor for `Location`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationDescriptor = $convert.base64Decode(
    'CghMb2NhdGlvbhIaCghsYXRpdHVkZRgBIAEoAVIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAS'
    'gBUglsb25naXR1ZGUSGAoHYWRkcmVzcxgDIAEoCVIHYWRkcmVzcxIaCghhY2N1cmFjeRgEIAEo'
    'AVIIYWNjdXJhY3kSHAoJdGltZXN0YW1wGAUgASgEUgl0aW1lc3RhbXASFwoHaXNfbGl2ZRgGIA'
    'EoCFIGaXNMaXZlEhoKCGR1cmF0aW9uGAcgASgNUghkdXJhdGlvbg==');

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
    {'1': 'message_id', '3': 2, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
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
    '5SZWNlaXB0VHlwZVIEdHlwZRIdCgptZXNzYWdlX2lkGAIgASgJUgltZXNzYWdlSWQSGwoJc2Vu'
    'ZGVyX2lkGAMgASgJUghzZW5kZXJJZBIcCgl0aW1lc3RhbXAYBCABKARSCXRpbWVzdGFtcCIyCg'
    'tSZWNlaXB0VHlwZRILCgdVTktOT1dOEAASDAoIREVMSVZFUlkQARIICgRSRUFEEAI=');

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
    {'1': 'message_id', '3': 2, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'status', '3': 3, '4': 1, '5': 5, '10': 'status'},
    {'1': 'error', '3': 4, '4': 1, '5': 9, '10': 'error'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'target_ids', '3': 6, '4': 3, '5': 9, '10': 'targetIds'},
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
    'lwZVIEdHlwZRIdCgptZXNzYWdlX2lkGAIgASgJUgltZXNzYWdlSWQSFgoGc3RhdHVzGAMgASgF'
    'UgZzdGF0dXMSFAoFZXJyb3IYBCABKAlSBWVycm9yEhwKCXRpbWVzdGFtcBgFIAEoBFIJdGltZX'
    'N0YW1wEh0KCnRhcmdldF9pZHMYBiADKAlSCXRhcmdldElkcyJZCghTeW5jVHlwZRILCgdVTktO'
    'T1dOEAASGQoVTUVTU0FHRV9TVEFUVVNfVVBEQVRFEAESEQoNVEhSRUFEX1VQREFURRACEhIKDk'
    'NPTlRBQ1RfVVBEQVRFEAM=');

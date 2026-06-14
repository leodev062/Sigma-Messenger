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

@$core.Deprecated('Use messageTypeDescriptor instead')
const MessageType$json = {
  '1': 'MessageType',
  '2': [
    {'1': 'TEXT', '2': 0},
    {'1': 'IMAGE', '2': 1},
    {'1': 'VIDEO', '2': 2},
    {'1': 'AUDIO', '2': 3},
    {'1': 'POLL', '2': 4},
    {'1': 'REPLY', '2': 5},
    {'1': 'REACTION', '2': 6},
  ],
};

/// Descriptor for `MessageType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageTypeDescriptor = $convert.base64Decode(
    'CgtNZXNzYWdlVHlwZRIICgRURVhUEAASCQoFSU1BR0UQARIJCgVWSURFTxACEgkKBUFVRElPEA'
    'MSCAoEUE9MTBAEEgkKBVJFUExZEAUSDAoIUkVBQ1RJT04QBg==');

@$core.Deprecated('Use messageStatusDescriptor instead')
const MessageStatus$json = {
  '1': 'MessageStatus',
  '2': [
    {'1': 'PENDING', '2': 0},
    {'1': 'SENT', '2': 1},
    {'1': 'DELIVERED', '2': 2},
    {'1': 'READ', '2': 3},
    {'1': 'FAILED', '2': 4},
  ],
};

/// Descriptor for `MessageStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List messageStatusDescriptor = $convert.base64Decode(
    'Cg1NZXNzYWdlU3RhdHVzEgsKB1BFTkRJTkcQABIICgRTRU5UEAESDQoJREVMSVZFUkVEEAISCA'
    'oEUkVBRBADEgoKBkZBSUxFRBAE');

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
      '6': '.messaging.PollOption',
      '10': 'options'
    },
    {'1': 'multipleChoice', '3': 3, '4': 1, '5': 8, '10': 'multipleChoice'},
  ],
};

/// Descriptor for `PollContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pollContentDescriptor = $convert.base64Decode(
    'CgtQb2xsQ29udGVudBIaCghxdWVzdGlvbhgBIAEoCVIIcXVlc3Rpb24SLwoHb3B0aW9ucxgCIA'
    'MoCzIVLm1lc3NhZ2luZy5Qb2xsT3B0aW9uUgdvcHRpb25zEiYKDm11bHRpcGxlQ2hvaWNlGAMg'
    'ASgIUg5tdWx0aXBsZUNob2ljZQ==');

@$core.Deprecated('Use replyContentDescriptor instead')
const ReplyContent$json = {
  '1': 'ReplyContent',
  '2': [
    {'1': 'messageId', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'previewText', '3': 2, '4': 1, '5': 9, '10': 'previewText'},
  ],
};

/// Descriptor for `ReplyContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List replyContentDescriptor = $convert.base64Decode(
    'CgxSZXBseUNvbnRlbnQSHAoJbWVzc2FnZUlkGAEgASgJUgltZXNzYWdlSWQSIAoLcHJldmlld1'
    'RleHQYAiABKAlSC3ByZXZpZXdUZXh0');

@$core.Deprecated('Use reactionContentDescriptor instead')
const ReactionContent$json = {
  '1': 'ReactionContent',
  '2': [
    {'1': 'messageId', '3': 1, '4': 1, '5': 9, '10': 'messageId'},
    {'1': 'emoji', '3': 2, '4': 1, '5': 9, '10': 'emoji'},
  ],
};

/// Descriptor for `ReactionContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reactionContentDescriptor = $convert.base64Decode(
    'Cg9SZWFjdGlvbkNvbnRlbnQSHAoJbWVzc2FnZUlkGAEgASgJUgltZXNzYWdlSWQSFAoFZW1vam'
    'kYAiABKAlSBWVtb2pp');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'conversationId', '3': 2, '4': 1, '5': 9, '10': 'conversationId'},
    {'1': 'senderId', '3': 3, '4': 1, '5': 9, '10': 'senderId'},
    {'1': 'receiverId', '3': 4, '4': 1, '5': 9, '10': 'receiverId'},
    {
      '1': 'type',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.messaging.MessageType',
      '10': 'type'
    },
    {'1': 'timestamp', '3': 6, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'updatedAt', '3': 7, '4': 1, '5': 3, '10': 'updatedAt'},
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.messaging.MessageStatus',
      '10': 'status'
    },
    {
      '1': 'text',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.messaging.TextContent',
      '9': 0,
      '10': 'text'
    },
    {
      '1': 'image',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.messaging.ImageContent',
      '9': 0,
      '10': 'image'
    },
    {
      '1': 'video',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.messaging.VideoContent',
      '9': 0,
      '10': 'video'
    },
    {
      '1': 'audio',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.messaging.AudioContent',
      '9': 0,
      '10': 'audio'
    },
    {
      '1': 'poll',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.messaging.PollContent',
      '9': 0,
      '10': 'poll'
    },
    {
      '1': 'reply',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.messaging.ReplyContent',
      '9': 0,
      '10': 'reply'
    },
    {
      '1': 'reaction',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.messaging.ReactionContent',
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
    'CgdNZXNzYWdlEg4KAmlkGAEgASgJUgJpZBImCg5jb252ZXJzYXRpb25JZBgCIAEoCVIOY29udm'
    'Vyc2F0aW9uSWQSGgoIc2VuZGVySWQYAyABKAlSCHNlbmRlcklkEh4KCnJlY2VpdmVySWQYBCAB'
    'KAlSCnJlY2VpdmVySWQSKgoEdHlwZRgFIAEoDjIWLm1lc3NhZ2luZy5NZXNzYWdlVHlwZVIEdH'
    'lwZRIcCgl0aW1lc3RhbXAYBiABKANSCXRpbWVzdGFtcBIcCgl1cGRhdGVkQXQYByABKANSCXVw'
    'ZGF0ZWRBdBIwCgZzdGF0dXMYCCABKA4yGC5tZXNzYWdpbmcuTWVzc2FnZVN0YXR1c1IGc3RhdH'
    'VzEiwKBHRleHQYCSABKAsyFi5tZXNzYWdpbmcuVGV4dENvbnRlbnRIAFIEdGV4dBIvCgVpbWFn'
    'ZRgKIAEoCzIXLm1lc3NhZ2luZy5JbWFnZUNvbnRlbnRIAFIFaW1hZ2USLwoFdmlkZW8YCyABKA'
    'syFy5tZXNzYWdpbmcuVmlkZW9Db250ZW50SABSBXZpZGVvEi8KBWF1ZGlvGAwgASgLMhcubWVz'
    'c2FnaW5nLkF1ZGlvQ29udGVudEgAUgVhdWRpbxIsCgRwb2xsGA0gASgLMhYubWVzc2FnaW5nLl'
    'BvbGxDb250ZW50SABSBHBvbGwSLwoFcmVwbHkYDiABKAsyFy5tZXNzYWdpbmcuUmVwbHlDb250'
    'ZW50SABSBXJlcGx5EjgKCHJlYWN0aW9uGA8gASgLMhoubWVzc2FnaW5nLlJlYWN0aW9uQ29udG'
    'VudEgAUghyZWFjdGlvbkIJCgdjb250ZW50');

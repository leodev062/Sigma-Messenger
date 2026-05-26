// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDto _$ChatDtoFromJson(Map<String, dynamic> json) => ChatDto(
  id: json['id'] as String,
  ownerId: json['owner_id'] as String?,
  title: json['name'] as String?,
  type: json['type'] as String,
  createdAt: json['created_at'],
);

Map<String, dynamic> _$ChatDtoToJson(ChatDto instance) => <String, dynamic>{
  'id': instance.id,
  'owner_id': instance.ownerId,
  'name': instance.title,
  'type': instance.type,
  'created_at': instance.createdAt,
};

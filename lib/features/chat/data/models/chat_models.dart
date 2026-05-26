import 'package:json_annotation/json_annotation.dart';

part 'chat_models.g.dart';

@JsonSerializable()
class ChatDto {
  final String id;
  
  @JsonKey(name: 'owner_id')
  final String? ownerId;
  
  @JsonKey(name: 'name') // Mapeia o campo "name" do Go para "title"
  final String? title;
  
  final String type;
  
  @JsonKey(name: 'created_at')
  final dynamic createdAt;

  ChatDto({
    required this.id,
    this.ownerId,
    this.title,
    required this.type,
    this.createdAt,
  });

  factory ChatDto.fromJson(Map<String, dynamic> json) => _$ChatDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);
}

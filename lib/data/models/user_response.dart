import 'package:json_annotation/json_annotation.dart';
import 'package:sigma/domain/entities/user_entity.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final String status;
  final String? message;
  final String? user_id; // UUID
  final String? token;
  final UserDto? user;

  UserResponse({
    required this.status,
    this.message,
    this.user_id,
    this.token,
    this.user,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class UserDto {
  final String id; // UUID
  final String? name;
  final String? username;
  final String phone;
  final String? avatar_url;
  @JsonKey(name: 'is_verified', defaultValue: false)
  final bool isVerified;
  @JsonKey(name: 'user_type', defaultValue: 'USER')
  final String userType;
  @JsonKey(name: 'identity_key')
  final String? identityKey;
  @JsonKey(name: 'signed_pre_key')
  final String? signedPreKey;
  @JsonKey(name: 'registration_id')
  final int? registrationId;
  @JsonKey(name: 'pre_keys')
  final String? preKeys;

  UserDto({
    required this.id,
    this.name,
    this.username,
    required this.phone,
    this.avatar_url,
    required this.isVerified,
    required this.userType,
    this.identityKey,
    this.signedPreKey,
    this.registrationId,
    this.preKeys,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      username: username,
      phone: phone,
      avatarUrl: avatar_url,
      isVerified: isVerified,
    );
  }
}

@JsonSerializable()
class RequestCodeRequest {
  final String phone;

  RequestCodeRequest({required this.phone});

  factory RequestCodeRequest.fromJson(Map<String, dynamic> json) => _$RequestCodeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RequestCodeRequestToJson(this);
}

@JsonSerializable()
class VerifyCodeRequest {
  final String phone;
  final String code;

  VerifyCodeRequest({required this.phone, required this.code});

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) => _$VerifyCodeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyCodeRequestToJson(this);
}

@JsonSerializable()
class PhoneLoginRequest {
  final String phone;
  final String firebaseUid;

  PhoneLoginRequest({
    required this.phone,
    required this.firebaseUid,
  });

  factory PhoneLoginRequest.fromJson(Map<String, dynamic> json) => _$PhoneLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneLoginRequestToJson(this);
}

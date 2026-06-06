import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponseWrapper {
  final String status;
  final String? message;
  final UserDto data;

  UserResponseWrapper({required this.status, this.message, required this.data});

  factory UserResponseWrapper.fromJson(Map<String, dynamic> json) => _$UserResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseWrapperToJson(this);
}

@JsonSerializable()
class UserListResponse {
  final String status;
  final List<UserDto> data;

  UserListResponse({required this.status, required this.data});

  factory UserListResponse.fromJson(Map<String, dynamic> json) => _$UserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}

@JsonSerializable()
class CheckUsernameResponse {
  final String status;
  final CheckUsernameData data;

  CheckUsernameResponse({required this.status, required this.data});

  factory CheckUsernameResponse.fromJson(Map<String, dynamic> json) => _$CheckUsernameResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckUsernameResponseToJson(this);
}

@JsonSerializable()
class CheckUsernameData {
  final bool available;

  CheckUsernameData({required this.available});

  factory CheckUsernameData.fromJson(Map<String, dynamic> json) => _$CheckUsernameDataFromJson(json);
  Map<String, dynamic> toJson() => _$CheckUsernameDataToJson(this);
}

@JsonSerializable()
class UserDeviceSessionDto {
  final int id;
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'device_id')
  final String deviceId;
  @JsonKey(name: 'device_name')
  final String deviceName;
  final String platform;
  @JsonKey(name: 'client_version')
  final String clientVersion;
  @JsonKey(name: 'ip_address')
  final String ipAddress;
  @JsonKey(name: 'last_active_at')
  final String lastActiveAt;
  @JsonKey(name: 'created_at')
  final String createdAt;

  UserDeviceSessionDto({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.clientVersion,
    required this.ipAddress,
    required this.lastActiveAt,
    required this.createdAt,
  });

  factory UserDeviceSessionDto.fromJson(Map<String, dynamic> json) => _$UserDeviceSessionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDeviceSessionDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  final String id; // UUID
  final String? name;
  final String? username;
  final String? bio;
  final String phone;
  final String? email;
  final String? country;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  @JsonKey(name: 'is_verified', defaultValue: false)
  final bool isVerified;

  @JsonKey(name: 'type', defaultValue: 'individual')
  final String type;

  @JsonKey(name: 'relative_name')
  final String? relativeName;

  @JsonKey(name: 'relative_id')
  final String? relativeId;

  @JsonKey(name: 'identity_key')
  final String? identityKey;

  @JsonKey(name: 'signed_pre_key_id')
  final int? signedPreKeyId;

  @JsonKey(name: 'signed_pre_key_public')
  final String? signedPreKeyPublic;

  @JsonKey(name: 'signed_pre_key_signature')
  final String? signedPreKeySignature;

  @JsonKey(name: 'registration_id')
  final int? registrationId;

  @JsonKey(name: 'pre_keys')
  final String? preKeys;

  @JsonKey(name: 'is_private', defaultValue: false)
  final bool isPrivate;

  UserDto({
    required this.id,
    this.name,
    this.username,
    this.bio,
    required this.phone,
    this.email,
    this.country,
    this.avatarUrl,
    required this.isVerified,
    required this.type,
    this.relativeName,
    this.relativeId,
    this.identityKey,
    this.signedPreKeyId,
    this.signedPreKeyPublic,
    this.signedPreKeySignature,
    this.registrationId,
    this.preKeys,
    required this.isPrivate,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}

// Para manter compatibilidade com partes que ainda usam UserResponse
@JsonSerializable()
class UserResponse {
  final String status;
  final String? message;
  @JsonKey(name: 'user_id')
  final String? user_id; 
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponseWrapper _$UserResponseWrapperFromJson(Map<String, dynamic> json) =>
    UserResponseWrapper(
      status: json['status'] as String,
      message: json['message'] as String?,
      data: UserDto.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseWrapperToJson(
  UserResponseWrapper instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

UserListResponse _$UserListResponseFromJson(Map<String, dynamic> json) =>
    UserListResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserListResponseToJson(UserListResponse instance) =>
    <String, dynamic>{'status': instance.status, 'data': instance.data};

CheckUsernameResponse _$CheckUsernameResponseFromJson(
  Map<String, dynamic> json,
) => CheckUsernameResponse(
  status: json['status'] as String,
  data: CheckUsernameData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CheckUsernameResponseToJson(
  CheckUsernameResponse instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

CheckUsernameData _$CheckUsernameDataFromJson(Map<String, dynamic> json) =>
    CheckUsernameData(available: json['available'] as bool);

Map<String, dynamic> _$CheckUsernameDataToJson(CheckUsernameData instance) =>
    <String, dynamic>{'available': instance.available};

UserDeviceSessionDto _$UserDeviceSessionDtoFromJson(
  Map<String, dynamic> json,
) => UserDeviceSessionDto(
  id: (json['id'] as num).toInt(),
  userId: json['user_id'] as String,
  deviceId: json['device_id'] as String,
  deviceName: json['device_name'] as String,
  platform: json['platform'] as String,
  clientVersion: json['client_version'] as String,
  ipAddress: json['ip_address'] as String,
  lastActiveAt: json['last_active_at'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$UserDeviceSessionDtoToJson(
  UserDeviceSessionDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'device_id': instance.deviceId,
  'device_name': instance.deviceName,
  'platform': instance.platform,
  'client_version': instance.clientVersion,
  'ip_address': instance.ipAddress,
  'last_active_at': instance.lastActiveAt,
  'created_at': instance.createdAt,
};

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'] as String,
  name: json['name'] as String?,
  username: json['username'] as String?,
  bio: json['bio'] as String?,
  phone: json['phone'] as String,
  email: json['email'] as String?,
  country: json['country'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
  type: json['type'] as String? ?? 'individual',
  relativeName: json['relative_name'] as String?,
  relativeId: json['relative_id'] as String?,
  identityKey: json['identity_key'] as String?,
  signedPreKeyId: (json['signed_pre_key_id'] as num?)?.toInt(),
  signedPreKeyPublic: json['signed_pre_key_public'] as String?,
  signedPreKeySignature: json['signed_pre_key_signature'] as String?,
  registrationId: (json['registration_id'] as num?)?.toInt(),
  preKeys: json['pre_keys'] as String?,
  isPrivate: json['is_private'] as bool? ?? false,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'bio': instance.bio,
  'phone': instance.phone,
  'email': instance.email,
  'country': instance.country,
  'avatar_url': instance.avatarUrl,
  'is_verified': instance.isVerified,
  'type': instance.type,
  'relative_name': instance.relativeName,
  'relative_id': instance.relativeId,
  'identity_key': instance.identityKey,
  'signed_pre_key_id': instance.signedPreKeyId,
  'signed_pre_key_public': instance.signedPreKeyPublic,
  'signed_pre_key_signature': instance.signedPreKeySignature,
  'registration_id': instance.registrationId,
  'pre_keys': instance.preKeys,
  'is_private': instance.isPrivate,
};

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  status: json['status'] as String,
  message: json['message'] as String?,
  user_id: json['user_id'] as String?,
  token: json['token'] as String?,
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user_id': instance.user_id,
      'token': instance.token,
      'user': instance.user,
    };

RequestCodeRequest _$RequestCodeRequestFromJson(Map<String, dynamic> json) =>
    RequestCodeRequest(phone: json['phone'] as String);

Map<String, dynamic> _$RequestCodeRequestToJson(RequestCodeRequest instance) =>
    <String, dynamic>{'phone': instance.phone};

VerifyCodeRequest _$VerifyCodeRequestFromJson(Map<String, dynamic> json) =>
    VerifyCodeRequest(
      phone: json['phone'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyCodeRequestToJson(VerifyCodeRequest instance) =>
    <String, dynamic>{'phone': instance.phone, 'code': instance.code};

PhoneLoginRequest _$PhoneLoginRequestFromJson(Map<String, dynamic> json) =>
    PhoneLoginRequest(
      phone: json['phone'] as String,
      firebaseUid: json['firebaseUid'] as String,
    );

Map<String, dynamic> _$PhoneLoginRequestToJson(PhoneLoginRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'firebaseUid': instance.firebaseUid,
    };

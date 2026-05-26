// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: json['id'] as String,
  name: json['name'] as String?,
  username: json['username'] as String?,
  phone: json['phone'] as String,
  avatar_url: json['avatar_url'] as String?,
  isVerified: json['is_verified'] as bool? ?? false,
  userType: json['user_type'] as String? ?? 'USER',
  identityKey: json['identity_key'] as String?,
  signedPreKey: json['signed_pre_key'] as String?,
  registrationId: (json['registration_id'] as num?)?.toInt(),
  preKeys: json['pre_keys'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'phone': instance.phone,
  'avatar_url': instance.avatar_url,
  'is_verified': instance.isVerified,
  'user_type': instance.userType,
  'identity_key': instance.identityKey,
  'signed_pre_key': instance.signedPreKey,
  'registration_id': instance.registrationId,
  'pre_keys': instance.preKeys,
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

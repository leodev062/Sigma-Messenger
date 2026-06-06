// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationSessionResponse _$RegistrationSessionResponseFromJson(
  Map<String, dynamic> json,
) => RegistrationSessionResponse(
  session_id: json['session_id'] as String,
  status: json['status'] as String,
  e164: json['e164'] as String,
  allowed_to_request_code: json['allowed_to_request_code'] as bool,
  expires_at: (json['expires_at'] as num).toInt(),
  submittedInfo:
      (json['submitted_info'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  accountExists: json['account_exists'] as bool? ?? false,
  accountData: json['account_data'] as Map<String, dynamic>?,
  token: json['token'] as String?,
);

Map<String, dynamic> _$RegistrationSessionResponseToJson(
  RegistrationSessionResponse instance,
) => <String, dynamic>{
  'session_id': instance.session_id,
  'status': instance.status,
  'e164': instance.e164,
  'allowed_to_request_code': instance.allowed_to_request_code,
  'expires_at': instance.expires_at,
  'submitted_info': instance.submittedInfo,
  'account_exists': instance.accountExists,
  'account_data': instance.accountData,
  'token': instance.token,
};

CreateAccountResponse _$CreateAccountResponseFromJson(
  Map<String, dynamic> json,
) => CreateAccountResponse(
  account_id: json['account_id'] as String,
  number: json['number'] as String,
  token: json['token'] as String?,
);

Map<String, dynamic> _$CreateAccountResponseToJson(
  CreateAccountResponse instance,
) => <String, dynamic>{
  'account_id': instance.account_id,
  'number': instance.number,
  'token': instance.token,
};

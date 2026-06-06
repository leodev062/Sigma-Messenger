import 'package:json_annotation/json_annotation.dart';

part 'registration_response.g.dart';

@JsonSerializable()
class RegistrationSessionResponse {
  @JsonKey(name: 'session_id')
  final String session_id;
  final String status; // pending, verified, expired
  final String e164;
  @JsonKey(name: 'allowed_to_request_code')
  final bool allowed_to_request_code;
  @JsonKey(name: 'expires_at')
  final int expires_at;

  @JsonKey(name: 'submitted_info', defaultValue: [])
  final List<String>? submittedInfo;

  @JsonKey(name: 'account_exists', defaultValue: false)
  final bool accountExists;

  @JsonKey(name: 'account_data')
  final Map<String, dynamic>? accountData;

  final String? token;

  RegistrationSessionResponse({
    required this.session_id,
    required this.status,
    required this.e164,
    required this.allowed_to_request_code,
    required this.expires_at,
    this.submittedInfo,
    this.accountExists = false,
    this.accountData,
    this.token,
  });

  factory RegistrationSessionResponse.fromJson(Map<String, dynamic> json) =>
      _$RegistrationSessionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationSessionResponseToJson(this);
}

@JsonSerializable()
class CreateAccountResponse {
  @JsonKey(name: 'account_id')
  final String account_id;
  final String number;
  final String? token;

  CreateAccountResponse({
    required this.account_id,
    required this.number,
    this.token,
  });

  factory CreateAccountResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAccountResponseToJson(this);
}

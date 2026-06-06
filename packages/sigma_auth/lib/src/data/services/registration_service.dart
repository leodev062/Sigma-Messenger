import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models/registration_response.dart';

part 'registration_service.g.dart';

@JsonSerializable()
class RegistrationResponseWrapper {
  final String status;
  final RegistrationSessionResponse data;

  RegistrationResponseWrapper({required this.status, required this.data});

  factory RegistrationResponseWrapper.fromJson(Map<String, dynamic> json) => _$RegistrationResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$RegistrationResponseWrapperToJson(this);
}

@JsonSerializable()
class CreateAccountResponseWrapper {
  final String status;
  final CreateAccountResponse data;

  CreateAccountResponseWrapper({required this.status, required this.data});

  factory CreateAccountResponseWrapper.fromJson(Map<String, dynamic> json) => _$CreateAccountResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAccountResponseWrapperToJson(this);
}

@RestApi()
abstract class RegistrationService {
  factory RegistrationService(Dio dio, {String baseUrl}) = _RegistrationService;

  @POST("v2/registration/session")
  Future<RegistrationResponseWrapper> createRegistrationSession(@Body() Map<String, dynamic> data);

  @GET("v2/registration/session/{sessionId}")
  Future<RegistrationResponseWrapper> getRegistrationSession(@Path("sessionId") String sessionId);

  @POST("v2/registration/send-code")
  Future<RegistrationResponseWrapper> requestSmsVerificationCode(@Body() Map<String, dynamic> data);

  @POST("v2/registration/check-code")
  Future<RegistrationResponseWrapper> verifyAccount(@Body() Map<String, dynamic> data);

  @POST("v2/registration/create-account")
  Future<CreateAccountResponseWrapper> registerAccount(@Body() Map<String, dynamic> data);
}

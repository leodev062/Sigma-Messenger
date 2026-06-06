import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sigma_core/src/data/models/user_response.dart';

part 'account_service.g.dart';

@RestApi()
abstract class AccountService {
  factory AccountService(Dio dio, {String baseUrl}) = _AccountService;

  @POST("v1/accounts")
  Future<UserResponseWrapper> createAccount(@Body() Map<String, dynamic> data);

  @GET("v1/accounts/me")
  Future<UserResponseWrapper> getMe();

  @DELETE("v1/accounts/me")
  Future<void> deleteAccount();

  @GET("v1/accounts/{id}/keys")
  Future<dynamic> getAccountKeys(@Path("id") String id);

  @PUT("v1/accounts/me/fcm")
  Future<void> updateFCMToken(@Body() Map<String, dynamic> data);

  @GET("v1/devices")
  Future<List<UserDeviceSessionDto>> getDevices();

  @DELETE("v1/devices/{id}")
  Future<void> deleteDevice(@Path("id") String id);
}

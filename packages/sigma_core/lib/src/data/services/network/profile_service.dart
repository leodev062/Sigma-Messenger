import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sigma_core/src/data/models/user_response.dart';

part 'profile_service.g.dart';

@RestApi()
abstract class ProfileService {
  factory ProfileService(Dio dio, {String baseUrl}) = _ProfileService;

  @GET("v1/accounts/{id}")
  Future<UserResponseWrapper> getProfile(@Path("id") String id);

  @PUT("v1/accounts/me")
  Future<UserResponseWrapper> updateProfile(@Body() Map<String, dynamic> data);

  @GET("v1/accounts/check-username/{username}")
  Future<CheckUsernameResponse> checkUsername(@Path("username") String username);

  @GET("v1/accounts/search")
  Future<UserListResponse> searchUsers(@Query("term") String term);
}

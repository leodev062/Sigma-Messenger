import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'keys_api_service.g.dart';

@RestApi()
abstract class KeysApiService {
  factory KeysApiService(Dio dio, {String baseUrl}) = _KeysApiService;

  @GET("v2/keys/{id}")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> getKeys(@Path("id") String id);

  @PUT("v2/keys")
  Future<void> putKeys(@Body() List<int> body);
}

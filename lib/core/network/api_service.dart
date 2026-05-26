import 'package:dio/dio.dart';
import 'package:sigma/features/auth/data/models/user_response.dart';
import 'package:sigma/core/updater/apk_update_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<UserResponse> requestCode(RequestCodeRequest request) async {
    final response = await _dio.post("api/auth/request-code", data: request.toJson());
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> loginWithPhone(VerifyCodeRequest request) async {
    final response = await _dio.post("api/auth/login", data: request.toJson());
    return UserResponse.fromJson(response.data);
  }

  Future<UserResponse> updateFcmToken(Map<String, dynamic> body) async {
    final response = await _dio.put("api/users/update-fcm", data: body);
    return UserResponse.fromJson(response.data);
  }

  Future<Map<String, bool>> checkUsername(String username) async {
    final response = await _dio.get("api/users/check-username/$username");
    return Map<String, bool>.from(response.data);
  }

  /// Padrão Signal: Busca o PreKeyBundle para iniciar uma sessão criptografada
  Future<Map<String, dynamic>> getUserKeys(String userId) async {
    final response = await _dio.get("api/users/$userId/keys");
    return response.data as Map<String, dynamic>;
  }

  /// Verifica se há uma atualização disponível no servidor
  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersionCode = int.parse(packageInfo.buildNumber);

      final response = await _dio.get('api/update');
      if (response.statusCode == 200) {
        final updateInfo = UpdateInfo.fromJson(response.data);
        if (updateInfo.versionCode > currentVersionCode) {
          return updateInfo;
        }
      }
    } catch (e) {
      // Silencioso
    }
    return null;
  }
}

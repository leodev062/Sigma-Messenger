import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/network/dio_client.dart';
import 'package:sigma/features/auth/data/models/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> requestCode(String phone);
  Future<UserResponse?> verifyAndLogin(String phone, String code);
  Future<void> syncFcmToken(String userId);
  Future<bool> checkUsername(String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService = ApiService(DioClient.getDio());

  @override
  Future<UserResponse> requestCode(String phone) async {
    try {
      return await _apiService.requestCode(RequestCodeRequest(phone: phone));
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Erro de conexão com o servidor");
    }
  }

  @override
  Future<UserResponse?> verifyAndLogin(String phone, String code) async {
    try {
      final response = await _apiService.loginWithPhone(
        VerifyCodeRequest(phone: phone, code: code),
      );
      return response;
    } catch (e) {
      return UserResponse(status: "ERROR", message: "Código inválido ou erro no servidor");
    }
  }

  @override
  Future<void> syncFcmToken(String userId) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await _apiService.updateFcmToken({
          "user_id": userId,
          "fcm_token": token,
        });
      }
    } catch (e) {
      // Falha silenciosa no FCM não bloqueia o login
    }
  }
  
  @override
  Future<bool> checkUsername(String username) async {
    try {
      final result = await _apiService.checkUsername(username);
      return result['available'] ?? false;
    } catch (e) {
      return false;
    }
  }
}

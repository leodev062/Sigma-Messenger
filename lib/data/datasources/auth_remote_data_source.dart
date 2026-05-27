import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sigma/core/network/account_manager.dart';
import 'package:sigma/core/network/profile_manager.dart';
import 'package:sigma/core/network/search_manager.dart';
import 'package:sigma/data/models/user_response.dart';
import 'package:sigma/app/locator.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> requestCode(String phone);
  Future<UserResponse?> verifyAndLogin(String phone, String code);
  Future<void> syncFcmToken(String userId);
  Future<bool> checkUsername(String username);
  Future<UserResponse> updateProfile({String? name, String? username, String? avatarUrl});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AccountManager _accountManager = locator<AccountManager>();
  final ProfileManager _profileManager = locator<ProfileManager>();
  final SearchManager _searchManager = locator<SearchManager>();

  @override
  Future<UserResponse> updateProfile({String? name, String? username, String? avatarUrl}) async {
    // Nota: O perfil do Signal-Android geralmente é atualizado no ProfileManager
    return await _profileManager.updateProfile("me", name ?? "", avatarUrl);
  }

  @override
  Future<UserResponse> requestCode(String phone) async {
    return await _accountManager.requestSmsCode(phone);
  }

  @override
  Future<UserResponse?> verifyAndLogin(String phone, String code) async {
    return await _accountManager.verifyCode(phone, code);
  }

  @override
  Future<void> syncFcmToken(String userId) async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        // O ProfileManager ou AccountManager poderia lidar com isso, mas mantemos a lógica aqui chamando o dio diretamente ou estendendo um manager.
        // Para simplificar, assumimos que o token é enviado no updateProfile ou um novo método no ProfileManager.
      }
    } catch (e) {
      // Silencioso
    }
  }
  
  @override
  Future<bool> checkUsername(String username) async {
    final result = await _searchManager.checkUsername(username);
    return result['available'] ?? false;
  }
}

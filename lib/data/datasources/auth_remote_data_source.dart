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
  Future<UserResponse> updateProfile({String? name, String? username, String? bio, String? avatarUrl});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AccountManager _accountManager = locator<AccountManager>();
  final ProfileManager _profileManager = locator<ProfileManager>();
  final SearchManager _searchManager = locator<SearchManager>();

  @override
  Future<UserResponse> updateProfile({String? name, String? username, String? bio, String? avatarUrl}) async {
    return await _profileManager.updateProfile(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
    );
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
        // Implementar no futuro se necessário
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

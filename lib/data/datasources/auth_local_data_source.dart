import 'package:sigma/data/models/user_response.dart';
import 'package:sigma/core/storage/sigma_store.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(UserDto user, String token);
  Future<UserDto?> getUser();
  Future<String?> getToken();
  Future<bool> isLoggedIn();
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> saveSession(UserDto user, String token) async {
    await SigmaStore.instance.account.saveSession(user, token);
  }

  @override
  Future<UserDto?> getUser() async {
    return await SigmaStore.instance.account.getUser();
  }

  @override
  Future<String?> getToken() async {
    return SigmaStore.instance.account.getTokenSync();
  }

  @override
  Future<bool> isLoggedIn() async {
    return SigmaStore.instance.account.getTokenSync() != null;
  }

  @override
  Future<void> logout() async {
    await SigmaStore.instance.account.clear();
  }
}

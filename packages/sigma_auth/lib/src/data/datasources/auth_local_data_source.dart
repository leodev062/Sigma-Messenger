import 'package:sigma_core/sigma_core.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(UserDto user, String token);
  Future<UserDto?> getUser();
  Future<String?> getToken();
  Future<bool> isLoggedIn();
  Future<void> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SigmaStore _sigmaStore;

  AuthLocalDataSourceImpl(this._sigmaStore);

  @override
  Future<void> saveSession(UserDto user, String token) async {
    await _sigmaStore.account.saveSession(user, token);
  }

  @override
  Future<UserDto?> getUser() async {
    return await _sigmaStore.account.getUser();
  }

  @override
  Future<String?> getToken() async {
    return _sigmaStore.account.getTokenSync();
  }

  @override
  Future<bool> isLoggedIn() async {
    return _sigmaStore.account.getTokenSync() != null;
  }

  @override
  Future<void> logout() async {
    await _sigmaStore.account.clear();
  }
}

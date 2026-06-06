import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sigma_core/sigma_core.dart';

abstract class AuthRemoteDataSource {
  Future<UserDto> updateProfile({String? name, String? username, String? bio, String? avatarUrl});
  Future<void> syncFcmToken(String userId);
  Future<bool> checkUsername(String username);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  AuthRemoteDataSourceImpl(this._profileRemoteDataSource);

  @override
  Future<UserDto> updateProfile({String? name, String? username, String? bio, String? avatarUrl}) async {
    final result = await _profileRemoteDataSource.updateProfile(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
    );

    return result.when(
      (userDto) => userDto,
      (failure) => throw Exception(failure.message),
    );
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
    final result = await _profileRemoteDataSource.checkUsername(username);
    return result.when(
      (available) => available,
      (failure) => false,
    );
  }
}

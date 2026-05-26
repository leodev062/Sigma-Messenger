import 'package:sigma/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> requestCode(String phone);
  Future<User?> verifyCode(String phone, String code);
  Future<User?> getCurrentUser();
  Future<void> logout();
}

import 'package:sigma/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<void> requestCode(String phone);
  Future<UserEntity?> verifyCode(String phone, String code);
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
}

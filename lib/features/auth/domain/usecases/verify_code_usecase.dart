import 'package:sigma/features/auth/domain/entities/user.dart';
import 'package:sigma/features/auth/domain/repositories/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  Future<User?> execute(String phone, String code) async {
    return await repository.verifyCode(phone, code);
  }
}

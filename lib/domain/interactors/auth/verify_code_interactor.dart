import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_auth_repository.dart';

class VerifyCodeInteractor {
  final IAuthRepository _repository;

  VerifyCodeInteractor(this._repository);

  Future<UserEntity?> execute(String phone, String code) => _repository.verifyCode(phone, code);
}

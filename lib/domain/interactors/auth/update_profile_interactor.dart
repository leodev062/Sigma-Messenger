import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_auth_repository.dart';

class UpdateProfileInteractor {
  final IAuthRepository _repository;

  UpdateProfileInteractor(this._repository);

  Future<UserEntity> execute({String? name, String? username, String? avatarUrl}) {
    return _repository.updateProfile(
      name: name,
      username: username,
      avatarUrl: avatarUrl,
    );
  }
}

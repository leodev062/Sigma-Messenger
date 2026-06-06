import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_profile/sigma_profile.dart';

/// Interactor para atualização de perfil.
/// Segue o padrão de caso de uso (Use Case) do Clean Architecture usado no Signal.
class UpdateProfileInteractor {
  final IProfileRepository _repository;

  UpdateProfileInteractor(this._repository);

  Future<Recipient> execute({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
    String? email,
    String? country,
    String? relativeName,
    String? relativeId,
    bool? isPrivate,
  }) async {
    return _repository.updateProfile(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
      email: email,
      country: country,
      relativeName: relativeName,
      relativeId: relativeId,
      isPrivate: isPrivate,
    );
  }
}

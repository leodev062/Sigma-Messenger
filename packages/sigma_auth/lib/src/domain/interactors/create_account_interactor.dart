import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

/// Caso de uso para criação de conta e configuração inicial de perfil.
class CreateAccountInteractor {
  final IRegistrationRepository _registrationRepository;
  final UpdateProfileInteractor _updateProfileInteractor;
  final SigmaStore _sigmaStore;

  CreateAccountInteractor(
    this._registrationRepository, 
    this._updateProfileInteractor,
    this._sigmaStore,
  );

  Future<Recipient> execute({
    required String sessionId,
    required String name,
    String? username,
    String? avatarUrl,
  }) async {
    final password = 'ServicePassword${DateTime.now().millisecondsSinceEpoch}';
    
    final accountResponse = await _registrationRepository.registerAccount(
      sessionId: sessionId,
      password: password,
    );
    
    if (accountResponse == null) {
      throw StateError('failed to create account');
    }

    final user = Recipient(
      id: accountResponse.account_id,
      type: RecipientType.individual,
      phone: accountResponse.number,
      profileName: name,
      username: username,
      avatarUrl: avatarUrl,
    );

    // 1. Salva a sessão local (Token JWT)
    await _sigmaStore.account.saveSession(
      UserDto(
        id: user.id,
        phone: user.phone ?? '',
        name: name,
        username: username,
        avatarUrl: avatarUrl,
        bio: user.bio,
        isVerified: true,
        type: 'individual',
        isPrivate: user.isPrivate,
      ),
      accountResponse.token ?? '',
    );

    // 2. Sincroniza o perfil com o servidor via UpdateProfileInteractor (Job-based)
    await _updateProfileInteractor.execute(
      name: name,
      username: username,
      avatarUrl: avatarUrl,
      isPrivate: false,
    );

    return user;
  }
}

import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_profile/sigma_profile.dart';

class VerificationResult {
  final bool success;
  final bool accountExists;
  final String? sessionId;
  final Map<String, dynamic>? accountData;
  final String? token;

  VerificationResult({
    required this.success,
    this.accountExists = false,
    this.sessionId,
    this.accountData,
    this.token,
  });
}

/// Caso de uso para verificar o código SMS e decidir o fluxo do usuário.
class VerifyCodeInteractor {
  final IRegistrationRepository _registrationRepository;
  final IProfileRepository _profileRepository;
  final SigmaStore _sigmaStore;

  VerifyCodeInteractor(
    this._registrationRepository, 
    this._profileRepository,
    this._sigmaStore,
  );

  Future<VerificationResult> execute({
    required String sessionId,
    required String code,
    required String phone,
  }) async {
    final deviceInfo = await DeviceService().getDeviceInfo();
    
    final result = await _registrationRepository.submitVerificationCode(
      sessionId,
      code,
      deviceId: deviceInfo.deviceId,
      deviceName: deviceInfo.deviceName,
      platform: deviceInfo.platform,
      clientVersion: deviceInfo.clientVersion,
    );

    if (result != null && result.status == 'verified') {
      if (result.accountExists) {
        // Usuário Retornando: Salvar sessão e sincronizar perfil
        final user = _recipientFromAccountData(result.accountData ?? {'phone': phone});
        
        await _sigmaStore.account.saveSession(
          UserDto(
            id: user.id,
            phone: user.phone ?? '',
            name: user.profileName,
            username: user.username,
            avatarUrl: user.avatarUrl,
            bio: user.bio,
            isVerified: true,
            type: 'individual',
            isPrivate: user.isPrivate,
          ),
          result.token ?? '',
        );

        // Offline-First: Sync local DB
        await _profileRepository.updateProfile(
          name: user.profileName,
          username: user.username,
          bio: user.bio,
          avatarUrl: user.avatarUrl,
          isPrivate: user.isPrivate,
        );

        return VerificationResult(
          success: true,
          accountExists: true,
          token: result.token,
          accountData: result.accountData,
        );
      } else {
        // Novo Usuário: Requer Setup de Perfil
        return VerificationResult(
          success: true,
          accountExists: false,
          sessionId: sessionId,
        );
      }
    }

    return VerificationResult(success: false);
  }

  Recipient _recipientFromAccountData(Map<String, dynamic> userData) {
    final profileName = userData['profile_name']?.toString() ??
        userData['display_name']?.toString() ??
        userData['name']?.toString();
    return Recipient(
      id: userData['id'].toString(),
      type: RecipientType.individual,
      phone: userData['phone']?.toString() ?? '',
      profileName: profileName,
      username: userData['username']?.toString(),
      avatarUrl: userData['avatar_url']?.toString(),
      bio: userData['bio']?.toString(),
    );
  }
}

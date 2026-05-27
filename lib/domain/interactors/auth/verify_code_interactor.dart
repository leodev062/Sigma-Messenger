import 'package:sigma/core/network/account_manager.dart';
import 'package:sigma/core/network/profile_manager.dart';
import 'package:sigma/data/datasources/auth_local_data_source.dart';
import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/data/models/model_mapper.dart';
import 'package:sigma/core/util/sigma_log.dart';

class VerifyCodeInteractor {
  final AccountManager _accountManager;
  final ProfileManager _profileManager;
  final AuthLocalDataSource _localDataSource;

  VerifyCodeInteractor(
    this._accountManager,
    this._profileManager,
    this._localDataSource,
  );

  Future<UserEntity?> execute(String phone, String code) async {
    SigmaLog.d("VerifyCodeInteractor", "Iniciando verificação para $phone");

    // 1. Chama o AccountManager.verifyCode()
    final response = await _accountManager.verifyCode(phone, code);

    if (response.status == 'SUCCESS' && response.token != null && response.user != null) {
      final userId = response.user!.id;
      final token = response.token!;

      // 2. Faz o login local inicial
      await _localDataSource.saveSession(response.user!, token);

      // 3. Chama o ProfileManager.getProfile(userId) para recuperação
      final profileResponse = await _profileManager.getProfile(userId);

      if (profileResponse.status == 'SUCCESS' && profileResponse.user != null) {
        // Regra de Negócio: Se o servidor devolver os dados do perfil, GUARDAR imediatamente no banco local
        SigmaLog.i("VerifyCodeInteractor", "Perfil recuperado para o usuário $userId. Salvando localmente.");
        await _localDataSource.saveSession(profileResponse.user!, token);
        return ModelMapper.userFromDto(profileResponse.user!);
      }

      return ModelMapper.userFromDto(response.user!);
    } else {
      throw Exception(response.message ?? 'Código inválido ou expirado');
    }
  }
}

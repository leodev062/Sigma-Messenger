import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_auth_repository.dart';
import 'package:sigma/data/datasources/auth_remote_data_source.dart';
import 'package:sigma/data/datasources/auth_local_data_source.dart';
import 'package:sigma/data/models/model_mapper.dart';
import 'package:sigma/core/util/sigma_log.dart';

class AuthRepositoryImpl implements IAuthRepository {
  static const String _tag = "AuthRepository";

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> requestCode(String phone) async {
    SigmaLog.d(_tag, "Solicitando código para $phone");
    final response = await remoteDataSource.requestCode(phone);
    if (response.status != 'SUCCESS') {
      throw Exception(response.message ?? 'Erro ao solicitar código');
    }
  }

  @override
  Future<UserEntity?> verifyCode(String phone, String code) async {
    SigmaLog.d(_tag, "Verificando código para $phone");
    final response = await remoteDataSource.verifyAndLogin(phone, code);
    
    if (response != null && response.status == 'SUCCESS' && response.token != null && response.user != null) {
      await localDataSource.saveSession(response.user!, response.token!);
      await remoteDataSource.syncFcmToken(response.user!.id);
      return ModelMapper.userFromDto(response.user!);
    } else {
      throw Exception(response?.message ?? 'Código inválido ou expirado');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userDto = await localDataSource.getUser();
    return userDto != null ? ModelMapper.userFromDto(userDto) : null;
  }

  @override
  Future<void> logout() async {
    SigmaLog.i(_tag, "Realizando logout");
    await localDataSource.logout();
  }

  @override
  Future<UserEntity> updateProfile({String? name, String? username, String? bio, String? avatarUrl}) async {
    final response = await remoteDataSource.updateProfile(
      name: name,
      username: username,
      bio: bio,
      avatarUrl: avatarUrl,
    );

    if (response.status == 'SUCCESS' && response.user != null) {
      final currentToken = await localDataSource.getToken();
      if (currentToken != null) {
        await localDataSource.saveSession(response.user!, currentToken);
      }
      return ModelMapper.userFromDto(response.user!);
    } else {
      throw Exception(response.message ?? 'Erro ao atualizar perfil');
    }
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    return await remoteDataSource.checkUsername(username);
  }
}

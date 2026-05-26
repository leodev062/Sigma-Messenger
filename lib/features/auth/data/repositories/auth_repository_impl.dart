import 'package:sigma/features/auth/domain/entities/user.dart';
import 'package:sigma/features/auth/domain/repositories/auth_repository.dart';
import 'package:sigma/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sigma/features/auth/data/datasources/auth_local_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> requestCode(String phone) async {
    final response = await remoteDataSource.requestCode(phone);
    if (response.status != 'SUCCESS') {
      throw Exception(response.message ?? 'Erro ao solicitar código');
    }
  }

  @override
  Future<User?> verifyCode(String phone, String code) async {
    final response = await remoteDataSource.verifyAndLogin(phone, code);
    
    if (response != null && response.status == 'SUCCESS' && response.token != null && response.user != null) {
      await localDataSource.saveSession(response.user!, response.token!);
      await remoteDataSource.syncFcmToken(response.user!.id);
      return response.user!.toEntity();
    } else {
      throw Exception(response?.message ?? 'Código inválido ou expirado');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final userDto = await localDataSource.getUser();
    return userDto?.toEntity();
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }
}

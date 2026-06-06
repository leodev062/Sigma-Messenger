import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

/// AuthRepositoryImpl - Gerenciamento de Sessão Pós-Login.
class AuthRepositoryImpl with Loggable implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AccountRemoteDataSource accountRemoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.accountRemoteDataSource,
  });

  @override
  Future<Recipient?> getCurrentUser() async {
    final userDto = await localDataSource.getUser();
    return userDto != null ? ModelMapper.recipientFromDto(userDto) : null;
  }

  @override
  Future<void> logout() async {
    logI("Realizando logout");
    await localDataSource.logout();
  }

  @override
  Future<List<UserDeviceSessionDto>> getActiveDevices() async {
    final result = await accountRemoteDataSource.getDevices();
    return result.when(
      (devices) => devices,
      (failure) => throw Exception(failure.message),
    );
  }

  @override
  Future<void> removeDevice(String id) async {
    final result = await accountRemoteDataSource.deleteDevice(id);
    return result.when(
      (success) => null,
      (failure) => throw Exception(failure.message),
    );
  }
}

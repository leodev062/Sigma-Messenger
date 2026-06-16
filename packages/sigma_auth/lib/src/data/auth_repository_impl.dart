import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_database/sigma_database.dart';

/// AuthRepositoryImpl - Gerenciamento de Sessão Pós-Login.
class AuthRepositoryImpl with Loggable implements IAuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AccountRemoteDataSource accountRemoteDataSource;
  final UserDao? _userDao;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.accountRemoteDataSource,
    UserDao? userDao,
  }) : _userDao = userDao;

  @override
  Future<Recipient?> getCurrentUser() async {
    final userDto = await localDataSource.getUser();
    return userDto != null ? ModelMapper.recipientFromDto(userDto) : null;
  }

  @override
  Future<void> persistCurrentUser(Recipient user) async {
    if (_userDao != null) {
      logI("Persistindo usuário atual no banco de dados local: ${user.id}");
      await _userDao!.upsertUser(user.toCompanion());
    } else {
      logW("UserDao não fornecido em AuthRepositoryImpl, não foi possível persistir o usuário.");
    }
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

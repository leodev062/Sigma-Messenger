import 'package:sigma_core/sigma_core.dart';

abstract class IAuthRepository {
  /// Obter usuário atual
  Future<Recipient?> getCurrentUser();

  /// Persiste o usuário atual no banco de dados local
  Future<void> persistCurrentUser(Recipient user);

  /// Logout
  Future<void> logout();

  /// Listar dispositivos ativos
  Future<List<UserDeviceSessionDto>> getActiveDevices();

  /// Remover um dispositivo
  Future<void> removeDevice(String id);
}

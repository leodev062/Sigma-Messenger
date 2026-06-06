import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_database/sigma_database.dart';

/// Caso de uso para realizar o logout de forma segura e limpar todos os dados.
class LogoutInteractor {
  final IAuthRepository _authRepository;
  final SigmaStore _sigmaStore;
  final SigmaDatabase _database;
  final ISocketService _socketService;

  LogoutInteractor(
    this._authRepository,
    this._sigmaStore,
    this._database,
    this._socketService,
  );

  Future<void> execute() async {
    // 1. Desconecta o Socket imediatamente para evitar novas entradas
    _socketService.disconnect();

    // 2. Limpa os dados de sessão no servidor (se houver API) e repositório
    await _authRepository.logout();

    // 3. Limpa o banco de dados SQLite (todas as tabelas)
    await _database.clearAllData();

    // 4. Limpa o SecureStorage (Chaves Signal, Token, UserID)
    await _sigmaStore.clearAll();
    
    // Futuro: Limpar caches de mídia/arquivos se necessário
  }
}

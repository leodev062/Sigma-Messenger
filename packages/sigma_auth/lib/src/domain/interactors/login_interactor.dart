import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_profile/sigma_profile.dart';
import 'package:sigma_contacts/sigma_contacts.dart';

/// Caso de uso para orquestrar as ações pós-login (Padrão Signal).
class LoginInteractor {
  final ISocketService _socketService;
  final SigmaJobManager _jobManager;

  LoginInteractor(this._socketService, this._jobManager);

  Future<void> execute(String userId, {bool isNewLogin = false}) async {
    // 1. Conecta o WebSocket para mensagens em tempo real
    _socketService.connect(userId);

    if (isNewLogin) {
      // 2. Cria uma cadeia de jobs para garantir o setup completo pós-login
      // Login -> Upload de Chaves -> Fetch Perfil Próprio -> Sincronizar Contatos
      final chain = JobChain(PushKeysUploadJob())
        .then(FetchProfileJob(recipientId: userId))
        .then(SyncContactsJob());

      await _jobManager.addChain(chain);
      SigmaLog.i("LoginInteractor", "Fluxo de NOVO login encadeado e iniciado.");
    } else {
      SigmaLog.i("LoginInteractor", "Reinicialização de sessão: WebSocket conectado.");
    }
  }
}

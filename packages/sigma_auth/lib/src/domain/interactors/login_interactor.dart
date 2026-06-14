import 'package:sigma_core/sigma_core.dart' hide Job;
import 'package:sigma_core/sigma_core.dart' as core show Job;
import 'package:sigma_profile/sigma_profile.dart';
import 'package:sigma_contacts/sigma_contacts.dart';

/// Caso de uso para orquestrar as ações pós-login (Padrão Signal).
class LoginInteractor {
  final ISocketService _socketService;
  final SigmaJobManager _jobManager;

  LoginInteractor(this._socketService, this._jobManager);

  Future<void> execute(String userId, {bool isNewLogin = false}) async {
    _socketService.connect(userId);

    if (isNewLogin) {
      final chain = JobChain(FetchProfileJob(recipientId: userId) as core.Job)
        .then(SyncContactsJob() as core.Job);

      await _jobManager.addChain(chain);
      SigmaLog.i("LoginInteractor", "Fluxo de NOVO login encadeado e iniciado.");
    } else {
      SigmaLog.i("LoginInteractor", "Reinicialização de sessão: WebSocket conectado.");
    }
  }
}

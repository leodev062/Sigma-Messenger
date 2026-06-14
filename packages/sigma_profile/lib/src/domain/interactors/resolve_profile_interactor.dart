import 'package:sigma_core/sigma_core.dart';
import '../../data/jobs/profile/fetch_profile_job.dart';

/// ResolveProfileInteractor - Implementa o Pipeline de Resolução de Usuários.
/// Segue a regra "Cache First" e "Background Sync" do UPRA.
class ResolveProfileInteractor {
  final IRecipientRepository _recipientRepository;
  final SigmaJobManager _jobManager;

  ResolveProfileInteractor(this._recipientRepository, this._jobManager);

  /// Tenta resolver o usuário localmente. Se não existir, inicia fetch em background
  /// e retorna um "Placeholder User" (Recipient.createUnknown).
  Future<Recipient> execute(String userId) async {
    final local = await _recipientRepository.getRecipientByUuid(userId);
    
    if (local != null) {
      // Opcional: Se os dados estiverem muito antigos, poderíamos disparar um sync aqui.
      // Por enquanto, seguimos a regra de Cache First estrito.
      return local;
    }

    // Caso 2: Usuário NÃO existe localmente.
    // Dispara Job Persistente para buscar dados no servidor.
    // O JobManager garante que não haverá requests duplicados via queueKey.
    final queueKey = "profile_$userId";
    if (!await _jobManager.hasJob(queueKey)) {
      _jobManager.add(FetchProfileJob(recipientId: userId));
    }

    // Retorna placeholder imediato para não bloquear a UI.
    return Recipient.createUnknown(userId);
  }

  /// Versão reativa do Pipeline de Resolução.
  /// Retorna um Stream que emite o placeholder imediatamente e o perfil real quando chegar.
  Stream<Recipient> watch(String userId) {
    // Dispara a lógica de resolução (Cache First + Background Fetch)
    execute(userId);
    
    return _recipientRepository
        .watchRecipient(userId)
        .map((r) => r ?? Recipient.createUnknown(userId));
  }
}

import 'package:get_it/get_it.dart';
import 'package:sigma_core/sigma_core.dart';

/// SyncContactsJob - Sincroniza a agenda de contatos com o servidor.
class SyncContactsJob extends Job {
  static const String KEY = "SyncContactsJob";

  SyncContactsJob({int? databaseId}) : super(
    databaseId: databaseId,
    factoryKey: KEY,
    queueKey: "contacts_sync",
    priority: JobPriority.medium,
  );

  @override
  Map<String, dynamic> serialize() => {};

  static Job create(Map<String, dynamic> data, int databaseId, GetIt locator) {
    return SyncContactsJob(databaseId: databaseId);
  }

  @override
  Future<void> run() async {
    // No Signal, a sincronização de contatos é feita em background.
    // Aqui seria a chamada ao repositório de contatos para subir hashes dos números.
    SigmaLog.i(KEY, "Sincronizando contatos com o servidor...");
    
    // Simulação de delay
    await Future.delayed(const Duration(seconds: 1));
    
    SigmaLog.i(KEY, "Contatos sincronizados com sucesso.");
  }

  @override
  void onRunError(Object error, StackTrace stackTrace) {
    SigmaLog.e(KEY, "Falha na sincronização de contatos.", error);
  }
}

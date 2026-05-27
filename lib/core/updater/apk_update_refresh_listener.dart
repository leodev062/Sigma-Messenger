import 'package:workmanager/workmanager.dart';
import 'package:sigma/core/network/api_service.dart';
import 'package:sigma/core/storage/sigma_store.dart';
import 'package:sigma/app/locator.dart';
import 'apk_update_download_manager_receiver.dart';

class ApkUpdateRefreshListener {
  static const taskName = "org.sigma.messenger.UPDATE_CHECK";

  void schedulePeriodicChecks() {
    Workmanager().initialize(callbackDispatcher);
    Workmanager().registerPeriodicTask(
      "1",
      taskName,
      frequency: const Duration(hours: 24),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Inicialização essencial para Background Isolate
    await SigmaStore.instance.init();
    setupLocator();

    if (task == ApkUpdateRefreshListener.taskName) {
      final api = locator<ApiService>();
      final update = await api.checkForUpdate();
      
      if (update != null) {
        await locator<ApkUpdateDownloadManagerReceiver>().startDownload(update.url, update.sha256);
      }
    }
    return true;
  });
}

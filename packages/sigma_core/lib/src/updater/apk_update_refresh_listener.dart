import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:sigma_core/sigma_core.dart';

class ApkUpdateRefreshListener {
  static const String taskName = "apk_update_check_task";

  void schedulePeriodicChecks() {
    Workmanager().initialize(_callbackDispatcher);
    Workmanager().registerPeriodicTask(
      "1",
      taskName,
      frequency: const Duration(hours: 12),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  static void _callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == taskName) {
        // setupLocator() deve ser providenciado de alguma forma se necessário em background
        final manager = locator<UpdateViewModel>();
        await manager.check();
      }
      return Future.value(true);
    });
  }
}

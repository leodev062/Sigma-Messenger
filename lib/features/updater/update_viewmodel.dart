import 'package:flutter/material.dart';
import '../../core/updater/apk_update_manager.dart';

class UpdateViewModel extends ChangeNotifier {
  final ApkUpdateManager _manager;

  UpdateViewModel(this._manager);

  bool _isChecking = false;
  bool get isChecking => _isChecking;

  UpdateInfo? _updateInfo;
  UpdateInfo? get updateInfo => _updateInfo;

  bool get updateAvailable => _updateInfo != null;

  bool _isDownloading = false;
  bool get isDownloading => _isDownloading;

  double _downloadProgress = 0.0;
  double get downloadProgress => _downloadProgress;

  String? _error;
  String? get error => _error;

  Future<void> check() async {
    _isChecking = true;
    _error = null;
    notifyListeners();

    try {
      _updateInfo = await _manager.checkForUpdate();
    } catch (e) {
      _error = 'Erro ao verificar atualizações';
    } finally {
      _isChecking = false;
      notifyListeners();
    }
  }

  Future<void> performUpdate() async {
    if (_updateInfo == null) return;

    _isDownloading = true;
    _downloadProgress = 0.0;
    _error = null;
    notifyListeners();

    try {
      final path = await _manager.downloadAndVerifyApk(
        _updateInfo!.url,
        _updateInfo!.sha256,
        onProgress: (count, total) {
          if (total > 0) {
            _downloadProgress = count / total;
            notifyListeners();
          }
        },
      );

      await _manager.installApk(path);
    } catch (e) {
      _error = e.toString();
      _isDownloading = false;
    } finally {
      notifyListeners();
    }
  }

  void dismissBanner() {
    _updateInfo = null;
    notifyListeners();
  }
}

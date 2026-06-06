import 'package:flutter/material.dart';
import 'package:sigma_core/src/util/sigma_log.dart';
import 'package:sigma_core/src/updater/apk_update_manager.dart';

/// UpdateState - Estado imutável para o sistema de atualização.
class UpdateState {
  final bool isChecking;
  final UpdateInfo? updateInfo;
  final bool isDownloading;
  final double downloadProgress;
  final String? error;

  UpdateState({
    this.isChecking = false,
    this.updateInfo,
    this.isDownloading = false,
    this.downloadProgress = 0.0,
    this.error,
  });

  bool get updateAvailable => updateInfo != null;

  UpdateState copyWith({
    bool? isChecking,
    UpdateInfo? updateInfo,
    bool? isDownloading,
    double? downloadProgress,
    String? error,
  }) {
    return UpdateState(
      isChecking: isChecking ?? this.isChecking,
      updateInfo: updateInfo ?? this.updateInfo,
      isDownloading: isDownloading ?? this.isDownloading,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      error: error ?? this.error,
    );
  }
}

/// UpdateViewModel - Refatorado para POO com State Pattern e Loggable.
class UpdateViewModel extends ChangeNotifier with Loggable {
  final ApkUpdateManager _manager;

  UpdateState _state = UpdateState();
  UpdateState get state => _state;

  // Getters de conveniência para manter compatibilidade e facilitar acesso na UI
  bool get updateAvailable => _state.updateAvailable;
  UpdateInfo? get updateInfo => _state.updateInfo;
  bool get isDownloading => _state.isDownloading;
  double get downloadProgress => _state.downloadProgress;
  String? get error => _state.error;
  bool get isChecking => _state.isChecking;

  UpdateViewModel(this._manager);

  Future<void> check() async {
    _updateState(_state.copyWith(isChecking: true, error: null));

    try {
      final info = await _manager.checkForUpdate();
      _updateState(_state.copyWith(updateInfo: info, isChecking: false));
    } catch (e) {
      logE("Falha ao verificar atualização", e);
      _updateState(_state.copyWith(isChecking: false, error: 'Erro ao verificar atualizações'));
    }
  }

  Future<void> performUpdate() async {
    final info = _state.updateInfo;
    if (info == null) return;

    _updateState(_state.copyWith(isDownloading: true, downloadProgress: 0.0, error: null));

    try {
      final path = await _manager.downloadAndVerifyApk(
        info.url,
        info.sha256,
        onProgress: (count, total) {
          if (total > 0) {
            _updateState(_state.copyWith(downloadProgress: count / total));
          }
        },
      );

      await _manager.installApk(path);
    } catch (e) {
      logE("Falha no download ou instalação do APK", e);
      _updateState(_state.copyWith(error: e.toString(), isDownloading: false));
    }
  }

  void dismissBanner() {
    _updateState(_state.copyWith(updateInfo: null));
  }

  void _updateState(UpdateState newState) {
    _state = newState;
    notifyListeners();
  }
}

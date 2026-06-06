import 'package:flutter/material.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';
import 'state/devices_state.dart';

class DevicesViewModel extends ChangeNotifier {
  final IAuthRepository _authRepository;
  
  DevicesState _state = const DevicesState();
  DevicesState get state => _state;

  List<UserDeviceSessionDto> get devices => _state.devices;
  bool get isLoading => _state.isLoading;
  String? get error => _state.error;

  DevicesViewModel(this._authRepository);

  Future<void> loadDevices() async {
    _state = _state.copyWith(isLoading: true, error: null);
    notifyListeners();

    try {
      final devices = await _authRepository.getActiveDevices();
      _state = _state.copyWith(devices: devices);
    } catch (e) {
      _state = _state.copyWith(error: e.toString());
    } finally {
      _state = _state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> removeDevice(String id) async {
    try {
      await _authRepository.removeDevice(id);
      await loadDevices();
    } catch (e) {
      _state = _state.copyWith(error: e.toString());
      notifyListeners();
      rethrow;
    }
  }
}

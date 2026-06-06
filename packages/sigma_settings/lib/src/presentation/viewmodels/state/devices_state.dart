import 'package:sigma_core/sigma_core.dart';

class DevicesState {
  final List<UserDeviceSessionDto> devices;
  final bool isLoading;
  final String? error;

  const DevicesState({
    this.devices = const [],
    this.isLoading = false,
    this.error,
  });

  DevicesState copyWith({
    List<UserDeviceSessionDto>? devices,
    bool? isLoading,
    String? error,
  }) {
    return DevicesState(
      devices: devices ?? this.devices,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

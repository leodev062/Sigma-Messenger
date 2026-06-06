import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceInfo {
  final String deviceId;
  final String deviceName;
  final String platform;
  final String clientVersion;

  DeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.platform,
    required this.clientVersion,
  });

  Map<String, dynamic> toJson() => {
    'device_id': deviceId,
    'device_name': deviceName,
    'platform': platform,
    'client_version': clientVersion,
  };
}

class DeviceService {
  static final DeviceService _instance = DeviceService._internal();
  factory DeviceService() => _instance;
  DeviceService._internal();

  DeviceInfo? _cachedInfo;

  Future<DeviceInfo> getDeviceInfo() async {
    if (_cachedInfo != null) return _cachedInfo!;

    final deviceInfoPlugin = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();
    
    String deviceId = 'unknown';
    String deviceName = 'Unknown Device';
    String platform = 'unknown';

    if (kIsWeb) {
      final webInfo = await deviceInfoPlugin.webBrowserInfo;
      deviceId = webInfo.userAgent ?? 'web-user-agent';
      deviceName = webInfo.browserName.name;
      platform = 'Web';
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      deviceId = androidInfo.id; // GERALMENTE o ID de hardware/build
      deviceName = '${androidInfo.manufacturer} ${androidInfo.model}';
      platform = 'Android ${androidInfo.version.release}';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? 'ios-id';
      deviceName = iosInfo.name;
      platform = 'iOS ${iosInfo.systemVersion}';
    } else if (Platform.isLinux) {
      final linuxInfo = await deviceInfoPlugin.linuxInfo;
      deviceId = linuxInfo.machineId ?? 'linux-id';
      deviceName = linuxInfo.name;
      platform = 'Linux';
    } else if (Platform.isWindows) {
      final windowsInfo = await deviceInfoPlugin.windowsInfo;
      deviceId = windowsInfo.deviceId;
      deviceName = windowsInfo.computerName;
      platform = 'Windows';
    }

    _cachedInfo = DeviceInfo(
      deviceId: deviceId,
      deviceName: deviceName,
      platform: platform,
      clientVersion: '${packageInfo.version}+${packageInfo.buildNumber}',
    );

    return _cachedInfo!;
  }
}

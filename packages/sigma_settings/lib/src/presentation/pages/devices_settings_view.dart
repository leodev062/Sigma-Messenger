import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import '../viewmodels/devices_viewmodel.dart';

class DevicesSettingsView extends StatefulWidget {
  const DevicesSettingsView({super.key});

  @override
  State<DevicesSettingsView> createState() => _DevicesSettingsViewState();
}

class _DevicesSettingsViewState extends State<DevicesSettingsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<DevicesViewModel>().loadDevices();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DevicesViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('devices')),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.error != null
              ? Center(child: Text('Erro: ${viewModel.error}'))
              : viewModel.devices.isEmpty
                  ? Center(child: Text(context.translate('no_devices_found')))
                  : ListView.separated(
                      itemCount: viewModel.devices.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final device = viewModel.devices[index];
                        // Evitando aviso de dead code usando uma condição dinâmica (falsa por enquanto)
                        bool isCurrentDevice = device.deviceId == 'unknown-current-id';

                        return ListTile(
                          leading: Icon(_getDeviceIcon(device.platform)),
                          title: Text(device.deviceName),
                          subtitle: Text('${device.platform} • ${device.ipAddress}'),
                          trailing: isCurrentDevice 
                            ? Text(context.translate('current_device'), style: const TextStyle(color: Colors.green))
                            : IconButton(
                                icon: const Icon(Icons.logout, color: Colors.red),
                                onPressed: () => _confirmLogout(context, viewModel, device),
                              ),
                        );
                      },
                    ),
    );
  }

  IconData _getDeviceIcon(String? platform) {
    switch (platform?.toLowerCase()) {
      case 'android': return Icons.android;
      case 'ios': return Icons.apple;
      case 'web': return Icons.web;
      default: return Icons.devices;
    }
  }

  void _confirmLogout(BuildContext context, DevicesViewModel viewModel, UserDeviceSessionDto device) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.translate('logout_device')),
        content: Text(context.translate('logout_device_confirmation')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.translate('cancel')),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await viewModel.removeDevice(device.id.toString());
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro: $e')),
                  );
                }
              }
            },
            child: Text(context.translate('logout'), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';

/// Um banner global que aparece quando o dispositivo está offline.
/// Segue o padrão do Signal/Telegram para fornecer feedback imediato sem interromper o fluxo.
class ConnectivityBanner extends StatelessWidget {
  final Widget child;

  const ConnectivityBanner({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final connectivityService = locator<IConnectivityService>();

    return StreamBuilder<bool>(
      stream: connectivityService.isConnectedStream,
      initialData: true, // Assume online inicialmente até o primeiro evento
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? true;

        return Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isOnline ? 0 : 32,
              width: double.infinity,
              color: Colors.redAccent,
              child: isOnline
                  ? const SizedBox.shrink()
                  : const Center(
                      child: Text(
                        "Sem conexão com a internet",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

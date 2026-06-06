import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'gallery_preview_widget.dart';
import '../pages/create_poll_screen.dart';

class AttachmentBottomSheet extends StatelessWidget {
  final Function(AssetEntity) onMediaSelected;
  final VoidCallback onLocationRequested;
  final Function(String question, List<String> options, bool allowMultiple) onPollCreated;
  final VoidCallback onFileRequested;

  const AttachmentBottomSheet({
    super.key,
    required this.onMediaSelected,
    required this.onLocationRequested,
    required this.onPollCreated,
    required this.onFileRequested,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Barra Horizontal de Ações
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildActionItem(context, Icons.photo_library_outlined, "Galeria", colorScheme.primary, () {}),
                  _buildActionItem(context, Icons.insert_drive_file_outlined, "Arquivo", Colors.orange, onFileRequested),
                  _buildActionItem(context, Icons.location_on_outlined, "Localização", Colors.green, onLocationRequested),
                  _buildActionItem(context, Icons.person_outline, "Contato", Colors.blue, () {}),
                  _buildActionItem(context, Icons.poll_outlined, "Enquete", Colors.purple, () => _showCreatePoll(context)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // 2. Galeria Rápida
            GalleryPreviewWidget(onAssetSelected: (asset) {
              Navigator.pop(context);
              onMediaSelected(asset);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: color.withValues(alpha: 0.1),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void _showCreatePoll(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pop(); // Fecha BottomSheet
    navigator.push(
      MaterialPageRoute(
        builder: (context) => CreatePollScreen(
          onSend: (question, allowMultiple, options) {
            onPollCreated(question, options, allowMultiple);
          },
        ),
      ),
    );
  }
}

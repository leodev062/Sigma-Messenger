import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

class AvatarImageView extends StatelessWidget {
  final Recipient recipient;
  final double size;

  const AvatarImageView({
    super.key,
    required this.recipient,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    // Nota: O sigma_core deve exportar o Recipient e as classes de ContactPhoto
    final photo = recipient.contactPhoto;
    final provider = photo.getImageProvider();

    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      clipBehavior: Clip.antiAlias,
      child: provider != null
          ? Image(
              image: provider,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _buildFallback(context),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: SizedBox(
                    width: size * 0.5,
                    height: size * 0.5,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: recipient.fallbackColor.withOpacity(0.5),
                    ),
                  ),
                );
              },
            )
          : _buildFallback(context),
    );
  }

  Widget _buildFallback(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: recipient.fallbackColor,
      child: Text(
        recipient.initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size * 0.45,
        ),
      ),
    );
  }
}

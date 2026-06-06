import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_ui/sigma_ui.dart';

class RecipientProfileView extends StatelessWidget {
  final Recipient recipient;

  const RecipientProfileView({super.key, required this.recipient});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('profile')),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            Center(
              child: AvatarImageView(
                recipient: recipient,
                size: 100,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              recipient.computedDisplayName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (recipient.phone?.isNotEmpty == true)
              Text(
                recipient.phone!,
                style: TextStyle(fontSize: 16, color: colorScheme.onSurface.withOpacity(0.6)),
              ),
            const SizedBox(height: 32),
            if (recipient.bio?.isNotEmpty == true)
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(recipient.bio!),
                subtitle: Text(context.translate('about')),
              ),
            if (recipient.username?.isNotEmpty == true)
              ListTile(
                leading: const Icon(Icons.alternate_email),
                title: Text('@${recipient.username}'),
                subtitle: Text(context.translate('username')),
              ),
          ],
        ),
      ),
    );
  }
}

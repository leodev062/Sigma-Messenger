import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sigma/core/i18n/strings.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  Future<void> _requestPermissions(BuildContext context) async {
    await [
      Permission.contacts,
      Permission.notification,
    ].request();
    
    if (context.mounted) {
      context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onBackground),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.privacy_tip_outlined,
              size: 80,
              color: colorScheme.onBackground.withOpacity(0.05),
            ),
            const SizedBox(height: 48),
            Text(
              context.translate('permissions_title'),
              style: textTheme.headlineLarge?.copyWith(color: colorScheme.onBackground),
            ),
            const SizedBox(height: 24),
            Text(
              context.translate('permissions_subtitle'),
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.38)),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => _requestPermissions(context),
                style: TextButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.translate('btn_give_permission'),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => context.push('/login'),
                child: Text(
                  context.translate('btn_not_now'),
                  style: TextStyle(
                    color: colorScheme.onBackground.withOpacity(0.26),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

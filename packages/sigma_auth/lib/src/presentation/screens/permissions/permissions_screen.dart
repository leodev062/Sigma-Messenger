import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  Future<void> _requestPermissions(BuildContext context) async {
    await [
      Permission.contacts,
      Permission.notification,
      Permission.storage,
      Permission.phone,
    ].request();
    
    if (context.mounted) {
      context.push('/registration/phone_number');
    }
  }

  @override
  Widget build(BuildContext context) {
    final layoutParams = RegistrationScaffold.rememberLayoutParams(context);

    if (layoutParams is OnePaneParams) {
      return _OnePaneLayout(params: layoutParams, onProceed: () => _requestPermissions(context));
    } else if (layoutParams is TwoPaneParams) {
      return _TwoPaneLayout(params: layoutParams, onProceed: () => _requestPermissions(context));
    }
    return const SizedBox.shrink();
  }
}

class _OnePaneLayout extends StatelessWidget {
  final OnePaneParams params;
  final VoidCallback onProceed;

  const _OnePaneLayout({required this.params, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return OnePaneRegistrationScaffold(
      params: params,
      contentBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('GrantPermissionsFragment__allow_permissions'),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                context.translate('GrantPermissionsFragment__to_help_you_message_people_you_know'),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(height: 40),
              const _PermissionList(),
            ],
          ),
        ),
      ),
      footer: _PermissionButtons(params: params, onProceed: onProceed),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  final TwoPaneParams params;
  final VoidCallback onProceed;

  const _TwoPaneLayout({required this.params, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return TwoPaneRegistrationScaffold(
      params: params,
      firstPaneBuilder: (context, padding) => Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate('GrantPermissionsFragment__allow_permissions'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              context.translate('GrantPermissionsFragment__to_help_you_message_people_you_know'),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
      secondPaneBuilder: (context, padding) => SingleChildScrollView(
        padding: padding,
        child: const _PermissionList(),
      ),
      footer: _PermissionButtons(params: params, onProceed: onProceed),
    );
  }
}

class _PermissionList extends StatelessWidget {
  const _PermissionList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PermissionRow(
          icon: Icons.notifications_none,
          title: context.translate('GrantPermissionsFragment__notifications'),
          subtitle: context.translate('GrantPermissionsFragment__get_notified_when'),
        ),
        _PermissionRow(
          icon: Icons.contacts_outlined,
          title: context.translate('GrantPermissionsFragment__contacts'),
          subtitle: context.translate('GrantPermissionsFragment__find_people_you_know'),
        ),
        _PermissionRow(
          icon: Icons.folder_open,
          title: context.translate('GrantPermissionsFragment__storage'),
          subtitle: context.translate('GrantPermissionsFragment__send_photos_videos_and_files'),
        ),
        _PermissionRow(
          icon: Icons.phone_outlined,
          title: context.translate('GrantPermissionsFragment__phone_calls'),
          subtitle: context.translate('GrantPermissionsFragment__make_registering_easier'),
        ),
      ],
    );
  }
}

class _PermissionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PermissionRow({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionButtons extends StatelessWidget {
  final RegistrationScaffoldParams params;
  final VoidCallback onProceed;

  const _PermissionButtons({required this.params, required this.onProceed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: params.footerPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onProceed,
            child: Text(context.translate('GrantPermissionsFragment__not_now')),
          ),
          const SizedBox(width: 24),
          SizedBox(
            height: 56,
            child: FilledButton.tonal(
              onPressed: onProceed,
              child: Text(context.translate('GrantPermissionsFragment__next')),
            ),
          ),
        ],
      ),
    );
  }
}

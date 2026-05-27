import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.state.user;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('account')),
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: Text(context.translate('phone_number')),
            subtitle: Text(user?.phone ?? '---'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const Divider(),
          _buildAccountOption(Icons.security, context.translate('security_notifications')),
          _buildAccountOption(Icons.phonelink_setup, context.translate('two_step_verification')),
          _buildAccountOption(Icons.email_outlined, context.translate('email_address')),
          _buildAccountOption(Icons.delete_outline, context.translate('delete_account'), isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, {bool isDestructive = false}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : null),
      title: Text(
        title, 
        style: TextStyle(color: isDestructive ? Colors.red : null),
      ),
      onTap: () {},
    );
  }
}

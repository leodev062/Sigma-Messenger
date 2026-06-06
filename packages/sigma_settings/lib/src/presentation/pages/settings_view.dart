import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/settings_viewmodel.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_settings/sigma_settings.dart';
import 'account_settings_view.dart';
import 'chat_settings_view.dart';
import 'devices_settings_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            context.translate('app_settings'), 
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        
        // 1. Idioma
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(context.translate('language')),
          subtitle: Text(viewModel.locale.languageCode == 'pt' ? 'Português' : 'English'),
          onTap: () => _showLanguageDialog(context, viewModel),
        ),

        // 2. Tema
        ListTile(
          leading: const Icon(Icons.brightness_6),
          title: Text(context.translate('theme')),
          subtitle: Text(_getThemeName(context, viewModel.themeMode)),
          onTap: () => _showThemeDialog(context, viewModel),
        ),

        const Divider(),

        // 3. Account
        ListTile(
          leading: const Icon(Icons.key),
          title: Text(context.translate('account')),
          subtitle: Text(context.translate('account_subtitle')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountSettingsView()),
          ),
        ),

        // 4. Chats
        ListTile(
          leading: const Icon(Icons.chat_outlined),
          title: Text(context.translate('chats')),
          subtitle: Text(context.translate('chats_subtitle')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatSettingsView()),
          ),
        ),

        // 5. Devices
        ListTile(
          leading: const Icon(Icons.devices),
          title: Text(context.translate('devices')),
          subtitle: Text(context.translate('devices_subtitle')),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider<DevicesViewModel>(
                create: (_) => locator<DevicesViewModel>(),
                child: const DevicesSettingsView(),
              ),
            ),
          ),
        ),

        _buildSettingItem(Icons.lock_outline, context.translate('privacy'), ''),
        _buildSettingItem(Icons.notifications_none, context.translate('notifications'), ''),
        _buildSettingItem(Icons.help_outline, context.translate('help'), ''),
      ],
    );
  }

  String _getThemeName(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return context.translate('theme_system');
      case ThemeMode.light:
        return context.translate('theme_light');
      case ThemeMode.dark:
        return context.translate('theme_dark');
    }
  }

  void _showLanguageDialog(BuildContext context, SettingsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.translate('select_language')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Português'),
              value: 'pt',
              groupValue: viewModel.locale.languageCode,
              onChanged: (code) {
                if (code != null) viewModel.setLocale(Locale(code));
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: viewModel.locale.languageCode,
              onChanged: (code) {
                if (code != null) viewModel.setLocale(Locale(code));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context, SettingsViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.translate('theme')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(context.translate('theme_system')),
              value: ThemeMode.system,
              groupValue: viewModel.themeMode,
              onChanged: (mode) {
                if (mode != null) viewModel.setThemeMode(mode);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(context.translate('theme_light')),
              value: ThemeMode.light,
              groupValue: viewModel.themeMode,
              onChanged: (mode) {
                if (mode != null) viewModel.setThemeMode(mode);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(context.translate('theme_dark')),
              value: ThemeMode.dark,
              groupValue: viewModel.themeMode,
              onChanged: (mode) {
                if (mode != null) viewModel.setThemeMode(mode);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      onTap: () {},
    );
  }
}

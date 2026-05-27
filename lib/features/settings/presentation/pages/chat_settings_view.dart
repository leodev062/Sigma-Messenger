import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/features/settings/presentation/viewmodels/settings_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';

class ChatSettingsView extends StatelessWidget {
  const ChatSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('chats')),
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(context.translate('display_header'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.filter_list),
            title: Text(context.translate('show_filters')),
            value: viewModel.showChatFilters,
            activeColor: colorScheme.primary,
            onChanged: (value) => viewModel.toggleChatFilters(value),
          ),
          const Divider(),
          _buildChatOption(Icons.wallpaper, context.translate('wallpaper')),
          _buildChatOption(Icons.history, context.translate('chat_history')),
          _buildChatOption(Icons.backup_outlined, context.translate('chat_backup')),
        ],
      ),
    );
  }

  Widget _buildChatOption(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {},
    );
  }
}

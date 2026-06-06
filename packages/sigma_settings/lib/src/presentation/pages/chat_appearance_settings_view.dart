import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma_settings/src/presentation/viewmodels/settings_viewmodel.dart';
import 'package:sigma_core/sigma_core.dart';

class ChatAppearanceSettingsView extends StatelessWidget {
  const ChatAppearanceSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.translate('chat_appearance')),
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Preview Section
          Expanded(
            child: Container(
              color: colorScheme.surfaceContainerLow,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        context.translate('preview'),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  _buildPreviewBubble(
                    context,
                    "Olá! Como estão as configurações?",
                    isMe: false,
                    fontSize: viewModel.messageFontSize,
                    borderRadius: viewModel.messageBorderRadius,
                  ),
                  const SizedBox(height: 8),
                  _buildPreviewBubble(
                    context,
                    "Estão ficando ótimas! O que acha deste tamanho?",
                    isMe: true,
                    fontSize: viewModel.messageFontSize,
                    borderRadius: viewModel.messageBorderRadius,
                  ),
                ],
              ),
            ),
          ),
          
          // Controls Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.translate('text_size'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: viewModel.messageFontSize,
                  min: 12,
                  max: 24,
                  divisions: 12,
                  label: viewModel.messageFontSize.toInt().toString(),
                  onChanged: (value) => viewModel.setMessageFontSize(value),
                ),
                const SizedBox(height: 16),
                Text(
                  context.translate('border_radius'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: viewModel.messageBorderRadius,
                  min: 0,
                  max: 30,
                  divisions: 30,
                  label: viewModel.messageBorderRadius.toInt().toString(),
                  onChanged: (value) => viewModel.setMessageBorderRadius(value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviewBubble(
    BuildContext context,
    String text, {
    required bool isMe,
    required double fontSize,
    required double borderRadius,
  }) {
    final theme = Theme.of(context);
    final bubbleColor = isMe ? theme.colorScheme.primary : theme.colorScheme.surfaceContainerHighest;
    final textColor = isMe ? theme.colorScheme.onPrimary : theme.colorScheme.onSurfaceVariant;

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
                bottomLeft: Radius.circular(isMe ? borderRadius : 4),
                bottomRight: Radius.circular(isMe ? 4 : borderRadius),
              ),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

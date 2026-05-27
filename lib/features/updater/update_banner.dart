import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigma/core/i18n/strings.dart';
import 'update_viewmodel.dart';

class UpdateBanner extends StatelessWidget {
  const UpdateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UpdateViewModel>(
      builder: (context, viewModel, child) {
        if (!viewModel.updateAvailable) return const SizedBox.shrink();
        final colorScheme = Theme.of(context).colorScheme;

        return Container(
          width: double.infinity,
          color: colorScheme.primaryContainer,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.system_update, color: colorScheme.onPrimaryContainer),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.translate('update_available', args: {'version': viewModel.updateInfo?.versionName ?? ''}),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                        if (viewModel.updateInfo?.releaseNotes.isNotEmpty ?? false)
                          Text(
                            viewModel.updateInfo!.releaseNotes,
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (viewModel.isDownloading)
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        value: viewModel.downloadProgress,
                        strokeWidth: 3,
                      ),
                    )
                  else ...[
                    TextButton(
                      onPressed: viewModel.dismissBanner,
                      child: Text(context.translate('btn_ignore')),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: viewModel.performUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                      child: Text(context.translate('btn_update')),
                    ),
                  ],
                ],
              ),
              if (viewModel.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    viewModel.error!,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

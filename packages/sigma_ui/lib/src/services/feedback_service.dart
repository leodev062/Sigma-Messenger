import 'package:flutter/material.dart';
import 'package:sigma_core/sigma_core.dart';

/// Serviço centralizado para fornecer feedback visual (SnackBar, Dialogs) ao usuário.
/// Garante consistência visual e evita duplicação de código em todo o app.
class FeedbackService {
  /// Exibe uma SnackBar de erro com estilo padronizado.
  void showError(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Theme.of(context).colorScheme.error,
      textColor: Theme.of(context).colorScheme.onError,
    );
  }

  /// Exibe uma SnackBar de sucesso com estilo padronizado.
  void showSuccess(BuildContext context, String message) {
    _showSnackBar(
      context,
      message,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// Exibe uma SnackBar informativa.
  void showInfo(BuildContext context, String message) {
    _showSnackBar(context, message);
  }

  /// Atalho para exibir erro de rede padrão.
  void showNetworkError(BuildContext context) {
    showError(context, context.translate('VerificationCodeScreen__network_error'));
  }

  void _showSnackBar(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    // Cancela SnackBars anteriores para evitar sobreposição
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textColor != null ? TextStyle(color: textColor) : null,
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

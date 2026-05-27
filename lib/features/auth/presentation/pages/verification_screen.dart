import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:sigma/core/i18n/strings.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const VerificationScreen({super.key, required this.phoneNumber});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final state = authViewModel.state;
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                context.translate('verification_title'),
                style: textTheme.headlineLarge?.copyWith(color: colorScheme.onBackground),
              ),
              const SizedBox(height: 24),
              Text(
                context.translate('verification_subtitle', args: {'phone': widget.phoneNumber}),
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.38)),
              ),
              const SizedBox(height: 48),
              
              // Campo de Código
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 6,
                    autofocus: true,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                      letterSpacing: 12,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: '000000',
                      hintStyle: TextStyle(
                        color: colorScheme.onPrimaryContainer.withOpacity(0.4),
                        letterSpacing: 12,
                      ),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.length == 6) {
                        authViewModel.verifyCode(widget.phoneNumber, value);
                      }
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              if (state.status == AuthStatus.loading)
                Center(child: CircularProgressIndicator(color: colorScheme.primary))
              else ...[
                if (state.status == AuthStatus.error)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Text(
                        state.error ?? context.translate('invalid_code'),
                        style: TextStyle(color: colorScheme.error, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                
                Center(
                  child: TextButton(
                    onPressed: state.status == AuthStatus.loading
                        ? null 
                        : () {
                          // authViewModel.requestCode(widget.phoneNumber);
                        },
                    child: Text(
                      context.translate('resend_sms'),
                      style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.26),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

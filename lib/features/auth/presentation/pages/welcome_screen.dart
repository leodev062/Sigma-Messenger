import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma/core/widgets/reactive_text.dart';
import 'package:sigma/core/i18n/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Icon
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.onBackground,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Σ',
                      style: TextStyle(
                        color: colorScheme.background,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(Icons.waves, color: colorScheme.onBackground.withOpacity(0.12), size: 28),
                ],
              ),
              
              const Spacer(),
              
              // Central Phone Illustration
              Center(
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.phone_android_rounded,
                      size: 100,
                      color: colorScheme.onBackground.withOpacity(0.05),
                    ),
                  ),
                ),
              ),
              
              const Spacer(),
              
              ReactiveText(
                text: context.translate('welcome_title'),
                style: textTheme.headlineLarge?.copyWith(fontSize: 42, color: colorScheme.onBackground),
              ),
              
              const SizedBox(height: 24),
              
              ReactiveText(
                text: context.translate('welcome_subtitle'),
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground.withOpacity(0.54)),
              ),
              
              const SizedBox(height: 48),
              
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    context.push('/permissions');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    context.translate('btn_start'),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimary,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

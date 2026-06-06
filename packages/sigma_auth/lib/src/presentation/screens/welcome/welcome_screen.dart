import 'package:flutter/material.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_core/sigma_core.dart';

class WelcomeScreen extends StatefulWidget {
  final Function(WelcomeScreenEvents) onEvent;

  const WelcomeScreen({
    super.key,
    required this.onEvent,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  void _onRestoreOrTransferClick() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _RestoreOrTransferBottomSheet(onEvent: widget.onEvent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final params = RegistrationScaffold.rememberLayoutParams(context);

    return _WelcomeLayout(
      onEvent: widget.onEvent,
      onRestoreOrTransferClick: _onRestoreOrTransferClick,
      params: params,
    );
  }
}

class _WelcomeLayout extends StatelessWidget {
  final Function(WelcomeScreenEvents) onEvent;
  final VoidCallback onRestoreOrTransferClick;
  final RegistrationScaffoldParams params;

  const _WelcomeLayout({
    required this.onEvent,
    required this.onRestoreOrTransferClick,
    required this.params,
  });

  @override
  Widget build(BuildContext context) {
    final params = this.params;
    if (params is OnePaneParams) {
      return OnePaneRegistrationScaffold(
        params: params,
        contentBuilder: (context, padding) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(child: _HeroImage(padding: EdgeInsets.all(16))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: _Headline(
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _TermsAndPrivacy(
                        onPressed: () => onEvent(const ViewTermsAndPrivacy()),
                      ),
                      const SizedBox(height: 24),
                      _PrimaryDeviceCallToActionButtons(
                        onEvent: onEvent,
                        onRestoreOrTransferClick: onRestoreOrTransferClick,
                        maxButtonWidth: params.maxButtonWidth,
                      ),
                      SizedBox(height: params.bottomInset),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (params is TwoPaneParams) {
      return TwoPaneRegistrationScaffold(
        params: params,
        firstPaneBuilder: (context, padding) => const Center(child: _HeroImage(padding: EdgeInsets.zero)),
        secondPaneBuilder: (context, padding) => Padding(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Headline(textAlign: TextAlign.start, style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 77),
              Center(
                child: _TermsAndPrivacy(
                  onPressed: () => onEvent(const ViewTermsAndPrivacy()),
                ),
              ),
              const SizedBox(height: 8),
              _PrimaryDeviceCallToActionButtons(
                onEvent: onEvent,
                onRestoreOrTransferClick: onRestoreOrTransferClick,
                maxButtonWidth: params.maxButtonWidth,
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}

class _HeroImage extends StatelessWidget {
  final EdgeInsets padding;
  const _HeroImage({required this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: const Icon(Icons.security, size: 200, color: Colors.blue),
    );
  }
}

class _Headline extends StatelessWidget {
  final TextAlign textAlign;
  final TextStyle? style;

  const _Headline({required this.textAlign, this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.translate('RegistrationActivity_take_privacy_with_you_be_yourself_in_every_message'),
      textAlign: textAlign,
      style: style?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _TermsAndPrivacy extends StatelessWidget {
  final VoidCallback onPressed;

  const _TermsAndPrivacy({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      child: Text(
        context.translate('RegistrationActivity_terms_and_privacy'),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _PrimaryDeviceCallToActionButtons extends StatelessWidget {
  final Function(WelcomeScreenEvents) onEvent;
  final VoidCallback onRestoreOrTransferClick;
  final double maxButtonWidth;

  const _PrimaryDeviceCallToActionButtons({
    required this.onEvent,
    required this.onRestoreOrTransferClick,
    required this.maxButtonWidth,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxButtonWidth),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton.tonal(
              onPressed: () => onEvent(const Continue()),
              child: Text(context.translate('RegistrationActivity_continue')),
            ),
          ),
          const SizedBox(height: 17),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton.tonal(
              onPressed: onRestoreOrTransferClick,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.surfaceContainerHighest,
              ),
              child: Text(context.translate('registration_activity__restore_or_transfer')),
            ),
          ),
        ],
      ),
    );
  }
}

class _RestoreOrTransferBottomSheet extends StatelessWidget {
  final Function(WelcomeScreenEvents) onEvent;

  const _RestoreOrTransferBottomSheet({required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.only(bottom: 54, top: 26),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _RestoreActionRow(
            icon: Icons.qr_code,
            title: context.translate('WelcomeFragment_restore_action_i_have_my_old_phone'),
            subtitle: context.translate('WelcomeFragment_restore_action_scan_qr'),
            onTap: () {
              Navigator.pop(context);
              onEvent(const HasOldPhone());
            },
          ),
          _RestoreActionRow(
            icon: Icons.phonelink_erase,
            title: context.translate('WelcomeFragment_restore_action_i_dont_have_my_old_phone'),
            subtitle: context.translate('WelcomeFragment_restore_action_reinstalling'),
            onTap: () {
              Navigator.pop(context);
              onEvent(const DoesNotHaveOldPhone());
            },
          ),
        ],
      ),
    );
  }
}

class _RestoreActionRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RestoreActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.background,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 44),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyLarge),
                    Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

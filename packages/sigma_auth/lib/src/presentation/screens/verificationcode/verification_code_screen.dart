import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_ui/sigma_ui.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  StreamSubscription? _effectSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
      final viewModel = context.read<VerificationCodeViewModel>();
      _effectSubscription = viewModel.effectStream.listen((effect) {
        if (!mounted) return;
        _handleOneTimeEvent(context, viewModel, effect);
      });
    });
  }

  @override
  void didUpdateWidget(VerificationCodeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final viewModel = context.read<VerificationCodeViewModel>();
    if (viewModel.state.isSubmittingCode) {
      locator<SigmaDialogService>().showLoading(context, message: context.translate('RegistrationActivity_please_wait'));
    } else {
      locator<SigmaDialogService>().hide(context);
    }
  }

  @override
  void dispose() {
    _effectSubscription?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length > 1) {
      // Handles paste or fast typing
      _controllers[index].text = value.substring(0, 1);
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
        _onDigitChanged(index + 1, value.substring(1));
      }
      return;
    }

    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
    _checkAndSubmit();
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  void _checkAndSubmit() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == 6) {
      context.read<VerificationCodeViewModel>().onEvent(CodeEntered(code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<VerificationCodeViewModel>();
    final state = viewModel.state;
    final layoutParams = RegistrationScaffold.rememberLayoutParams(context);

    return Scaffold(
      body: _buildLayout(context, layoutParams, state, viewModel.onEvent),
    );
  }

  Widget _buildLayout(BuildContext context, RegistrationScaffoldParams layoutParams, VerificationCodeState state, Function(VerificationCodeScreenEvents) onEvent) {
    if (layoutParams is OnePaneParams) {
      return _OnePaneLayout(
        params: layoutParams,
        state: state,
        onEvent: onEvent,
        controllers: _controllers,
        focusNodes: _focusNodes,
        onDigitChanged: _onDigitChanged,
        onBackspace: _onBackspace,
      );
    } else if (layoutParams is TwoPaneParams) {
      return _TwoPaneLayout(
        params: layoutParams,
        state: state,
        onEvent: onEvent,
        controllers: _controllers,
        focusNodes: _focusNodes,
        onDigitChanged: _onDigitChanged,
        onBackspace: _onBackspace,
      );
    }
    return const SizedBox.shrink();
  }

  void _handleOneTimeEvent(BuildContext context, VerificationCodeViewModel viewModel, VerificationCodeOneTimeEvent event) {
    final feedbackService = locator<FeedbackService>();
    String? message;

    if (event is IncorrectVerificationCode) {
      message = context.translate('VerificationCodeScreen__incorrect_code');
      for (var c in _controllers) {
        c.clear();
      }
      _focusNodes[0].requestFocus();
    } else if (event is VerificationUnableToSendSms) {
      message = context.translate('VerificationCodeScreen__unable_to_send_sms');
    } else if (event is VerificationRateLimited) {
      message = context.translate('VerificationCodeScreen__too_many_attempts_try_again_in_s', args: {'s': event.retryAfter.toString()});
    } else if (event is VerificationNetworkError) {
      return feedbackService.showNetworkError(context);
    } else if (event is VerificationUnknownError) {
      message = context.translate('VerificationCodeScreen__an_unexpected_error_occurred');
    } else if (event is VerificationCouldNotRequestCodeWithSelectedTransport) {
      message = context.translate('VerificationCodeScreen__could_not_send_code_via_selected_method');
    } else if (event is RegistrationError) {
      message = context.translate('VerificationCodeScreen__registration_error');
    }

    if (message != null) {
      feedbackService.showError(context, message);
    }
  }
}

class _OnePaneLayout extends StatelessWidget {
  final OnePaneParams params;
  final VerificationCodeState state;
  final Function(VerificationCodeScreenEvents) onEvent;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int, String) onDigitChanged;
  final Function(int) onBackspace;

  const _OnePaneLayout({
    required this.params,
    required this.state,
    required this.onEvent,
    required this.controllers,
    required this.focusNodes,
    required this.onDigitChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return OnePaneRegistrationScaffold(
      params: params,
      contentBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              _Description(state: state, onEvent: onEvent),
              const SizedBox(height: 32),
              _CodeField(
                state: state,
                controllers: controllers,
                focusNodes: focusNodes,
                onDigitChanged: onDigitChanged,
                onBackspace: onBackspace,
              ),
              const SizedBox(height: 32),
              if (state.incorrectCodeAttempts >= 3)
                _TroubleButton(onEvent: onEvent),
            ],
          ),
        ),
      ),
      footer: _AlternateCodeOptions(state: state, onEvent: onEvent),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  final TwoPaneParams params;
  final VerificationCodeState state;
  final Function(VerificationCodeScreenEvents) onEvent;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int, String) onDigitChanged;
  final Function(int) onBackspace;

  const _TwoPaneLayout({
    required this.params,
    required this.state,
    required this.onEvent,
    required this.controllers,
    required this.focusNodes,
    required this.onDigitChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return TwoPaneRegistrationScaffold(
      params: params,
      firstPaneBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: _Description(state: state, onEvent: onEvent),
        ),
      ),
      secondPaneBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              _CodeField(
                state: state,
                controllers: controllers,
                focusNodes: focusNodes,
                onDigitChanged: onDigitChanged,
                onBackspace: onBackspace,
              ),
              const SizedBox(height: 32),
              if (state.incorrectCodeAttempts >= 3)
                _TroubleButton(onEvent: onEvent),
            ],
          ),
        ),
      ),
      footer: _AlternateCodeOptions(state: state, onEvent: onEvent),
    );
  }
}

class _Description extends StatelessWidget {
  final VerificationCodeState state;
  final Function(VerificationCodeScreenEvents) onEvent;

  const _Description({required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate('VerificationCodeScreen__verification_code'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          context.translate('VerificationCodeScreen__enter_the_code_we_sent_to_s', args: {'phone': state.e164}),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => onEvent(const WrongNumber()),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: Theme.of(context).colorScheme.primary,
            minimumSize: const Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(context.translate('VerificationCodeScreen__wrong_number')),
        ),
      ],
    );
  }
}

class _CodeField extends StatelessWidget {
  final VerificationCodeState state;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(int, String) onDigitChanged;
  final Function(int) onBackspace;

  const _CodeField({
    required this.state,
    required this.controllers,
    required this.focusNodes,
    required this.onDigitChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 3; i++) ...[
          _DigitBox(
            controller: controllers[i],
            focusNode: focusNodes[i],
            onChanged: (v) => onDigitChanged(i, v),
            enabled: !state.isSubmittingCode,
            onBackspace: () => onBackspace(i),
          ),
          if (i < 2) const SizedBox(width: 4),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "-",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: state.isSubmittingCode ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.38) : null,
                ),
          ),
        ),
        for (int i = 3; i < 6; i++) ...[
          if (i > 3) const SizedBox(width: 4),
          _DigitBox(
            controller: controllers[i],
            focusNode: focusNodes[i],
            onChanged: (v) => onDigitChanged(i, v),
            enabled: !state.isSubmittingCode,
            onBackspace: () => onBackspace(i),
          ),
        ],
      ],
    );
  }
}

class _DigitBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final bool enabled;
  final VoidCallback onBackspace;

  const _DigitBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.enabled,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      child: RawKeyboardListener(
        focusNode: FocusNode(), // Temporary focus node for listener
        onKey: (event) {
          if (event is RawKeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
            onBackspace();
          }
        },
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          onChanged: (v) {
            if (v.length > 1) {
              controller.text = v.substring(v.length - 1);
              controller.selection = TextSelection.collapsed(offset: 1);
            }
            onChanged(controller.text);
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
          decoration: InputDecoration(
            counterText: "",
            border: const OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12))),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
    );
  }
}

class _TroubleButton extends StatelessWidget {
  final Function(VerificationCodeScreenEvents) onEvent;
  const _TroubleButton({required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onEvent(const HavingTrouble()),
      child: Text(
        context.translate('VerificationCodeScreen__having_trouble'),
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _AlternateCodeOptions extends StatelessWidget {
  final VerificationCodeState state;
  final Function(VerificationCodeScreenEvents) onEvent;

  const _AlternateCodeOptions({required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    final canResend = state.smsResendTimeRemaining <= 0;
    final canCall = state.callRequestTimeRemaining <= 0;
    final colorScheme = Theme.of(context).colorScheme;
    final disabledColor = colorScheme.onSurface.withOpacity(0.38);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: canResend ? () => onEvent(const ResendSms()) : null,
            child: Text(
              canResend 
                ? context.translate('VerificationCodeScreen__resend_code')
                : "${context.translate('VerificationCodeScreen__resend_code')} ${context.translate('VerificationCodeScreen__countdown_format', args: {
                    'm': (state.smsResendTimeRemaining ~/ 60).toString(),
                    's': (state.smsResendTimeRemaining % 60).toString().padLeft(2, '0')
                  })}",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: canResend ? colorScheme.primary : disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: canCall ? () => onEvent(const CallMe()) : null,
            child: Text(
              canCall 
                ? context.translate('VerificationCodeScreen__call_me_instead')
                : context.translate('VerificationCodeScreen__call_me_available_in', args: {
                    'm': (state.callRequestTimeRemaining ~/ 60).toString(),
                    's': (state.callRequestTimeRemaining % 60).toString().padLeft(2, '0')
                  }),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: canCall ? colorScheme.primary : disabledColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';
import 'package:sigma_ui/sigma_ui.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneNumberEntryScreen extends StatefulWidget {
  const PhoneNumberEntryScreen({super.key});

  @override
  State<PhoneNumberEntryScreen> createState() => _PhoneNumberEntryScreenState();
}

class _PhoneNumberEntryScreenState extends State<PhoneNumberEntryScreen> with CodeAutoFill {
  bool _isDialogShowing = false;
  StreamSubscription? _effectSubscription;

  @override
  void codeUpdated() {
    // Não necessário para sugestão de número, mas obrigatório pelo mixin
  }

  @override
  void initState() {
    super.initState();
    listenForCode(); // Inicializa o preenchimento automático
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<PhoneNumberEntryViewModel>();
      _effectSubscription = viewModel.effectStream.listen((effect) {
        if (!mounted) return;
        _handleOneTimeEvent(context, viewModel, effect);
      });
    });
  }

  @override
  void didUpdateWidget(PhoneNumberEntryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final viewModel = context.read<PhoneNumberEntryViewModel>();
    if (viewModel.state.showSpinner) {
      locator<SigmaDialogService>().showLoading(context, message: context.translate('RegistrationActivity_please_wait'));
    } else {
      locator<SigmaDialogService>().hide(context);
    }
  }

  @override
  void dispose() {
    _effectSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PhoneNumberEntryViewModel>();
    final state = viewModel.state;
    final layoutParams = RegistrationScaffold.rememberLayoutParams(context);

    // Controle rigoroso do diálogo para evitar o bug do fundo preto
    if (state.showDialog && !_isDialogShowing) {
      _isDialogShowing = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _showConfirmationDialog(context, viewModel));
    }

    return Scaffold(
      body: _buildLayout(context, layoutParams, state, viewModel.onEvent),
    );
  }

  Widget _buildLayout(BuildContext context, RegistrationScaffoldParams layoutParams, PhoneNumberEntryState state, Function(PhoneNumberEntryScreenEvents) onEvent) {
    if (layoutParams is OnePaneParams) {
      return _OnePaneLayout(params: layoutParams, state: state, onEvent: onEvent);
    } else if (layoutParams is TwoPaneParams) {
      return _TwoPaneLayout(params: layoutParams, state: state, onEvent: onEvent);
    }
    return const SizedBox.shrink();
  }

  void _showConfirmationDialog(BuildContext context, PhoneNumberEntryViewModel viewModel) {
    final state = viewModel.state;
    final fullNumber = '+${state.countryCode} ${state.formattedNumber}';

    locator<SigmaDialogService>()
        .showPhoneConfirmation(
      context: context,
      fullPhoneNumber: fullNumber,
      title: context.translate('RegistrationActivity_is_the_phone_number'),
      description: context.translate('RegistrationActivity_a_verification_code'),
      confirmLabel: context.translate('btn_ok'),
      editLabel: context.translate('RegistrationActivity_edit_number'),
    )
        .then((confirmed) {
      _isDialogShowing = false;
      if (confirmed) {
        viewModel.onEvent(const PhoneNumberSubmitted());
      } else {
        viewModel.onEvent(const PhoneNumberCancelled());
      }
    });
  }

  void _handleOneTimeEvent(BuildContext context, PhoneNumberEntryViewModel viewModel, PhoneNumberEntryOneTimeEvent event) {
    final feedbackService = locator<FeedbackService>();
    String? message;

    if (event is PhoneNumberRateLimited) {
      message = context.translate('VerificationCodeScreen__too_many_attempts_try_again_in_s', args: {'s': event.retryAfter.toString()});
    } else if (event is PhoneNumberNetworkError) {
      return feedbackService.showNetworkError(context);
    } else if (event is PhoneNumberUnknownError) {
      message = context.translate('VerificationCodeScreen__an_unexpected_error_occurred');
    } else if (event is CouldNotRequestCodeWithSelectedTransport) {
      message = context.translate('VerificationCodeScreen__could_not_send_code_via_selected_method');
    } else if (event is UnableToSendSms) {
      message = context.translate('VerificationCodeScreen__unable_to_send_sms');
    }

    if (message != null) {
      feedbackService.showError(context, message);
    }
  }
}

class _OnePaneLayout extends StatelessWidget {
  final OnePaneParams params;
  final PhoneNumberEntryState state;
  final Function(PhoneNumberEntryScreenEvents) onEvent;

  const _OnePaneLayout({required this.params, required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return OnePaneRegistrationScaffold(
      params: params,
      topBar: const _TopbarMenu(),
      contentBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Description(),
              const SizedBox(height: 36),
              _CountryPicker(
                emoji: state.countryEmoji,
                country: state.countryName,
                onTap: () async {
                  final result = await context.push('/registration/country_picker');
                  if (result is Country) {
                    onEvent(EntryCountrySelected(result));
                  }
                },
              ),
              const SizedBox(height: 16),
              _PhoneNumberInputFields(
                hasValidCountry: state.countryName.isNotEmpty,
                countryCode: state.countryCode,
                formattedNumber: state.formattedNumber,
                onCountryCodeChanged: (v) => onEvent(CountryCodeChanged(v)),
                onPhoneNumberChanged: (v) => onEvent(PhoneNumberChanged(v)),
                onPhoneNumberEntered: () => onEvent(const PhoneNumberEntered()),
              ),
            ],
          ),
        ),
      ),
      footer: _NextButton(params: params, state: state, onEvent: onEvent),
    );
  }
}

class _TwoPaneLayout extends StatelessWidget {
  final TwoPaneParams params;
  final PhoneNumberEntryState state;
  final Function(PhoneNumberEntryScreenEvents) onEvent;

  const _TwoPaneLayout({required this.params, required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return TwoPaneRegistrationScaffold(
      params: params,
      topBar: const _TopbarMenu(),
      firstPaneBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: const _Description(),
        ),
      ),
      secondPaneBuilder: (context, padding) => SingleChildScrollView(
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              _CountryPicker(
                emoji: state.countryEmoji,
                country: state.countryName,
                onTap: () async {
                  final result = await context.push('/registration/country_picker');
                  if (result is Country) {
                    onEvent(EntryCountrySelected(result));
                  }
                },
              ),
              const SizedBox(height: 16),
              _PhoneNumberInputFields(
                hasValidCountry: state.countryName.isNotEmpty,
                countryCode: state.countryCode,
                formattedNumber: state.formattedNumber,
                onCountryCodeChanged: (v) => onEvent(CountryCodeChanged(v)),
                onPhoneNumberChanged: (v) => onEvent(PhoneNumberChanged(v)),
                onPhoneNumberEntered: () => onEvent(const PhoneNumberEntered()),
              ),
            ],
          ),
        ),
      ),
      footer: _NextButton(params: params, state: state, onEvent: onEvent),
    );
  }
}

class _TopbarMenu extends StatelessWidget {
  const _TopbarMenu();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          tooltip: context.translate('RegistrationActivity_open_menu'),
          onSelected: (value) {
            // Implement proxy or link device
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'proxy',
              child: Text(context.translate('RegistrationActivity_use_proxy')),
            ),
            PopupMenuItem(
              value: 'link',
              child: Text(context.translate('RegistrationActivity_link_device')),
            ),
          ],
        ),
      ],
    );
  }
}

class _Description extends StatelessWidget {
  const _Description();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate('RegistrationActivity_phone_number'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          context.translate('RegistrationActivity_you_will_receive_a_verification_code'),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}

class _CountryPicker extends StatelessWidget {
  final String emoji;
  final String country;
  final VoidCallback onTap;

  const _CountryPicker({required this.emoji, required this.country, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: colorScheme.outline,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        ),
        padding: const EdgeInsets.only(bottom: 1),
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (emoji.isNotEmpty) ...[
                Text(emoji, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 16),
              ],
              Expanded(
                child: Text(
                  country.isNotEmpty ? country : context.translate('RegistrationActivity_select_a_country'),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              Icon(Icons.arrow_drop_down, color: colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberInputFields extends StatefulWidget {
  final bool hasValidCountry;
  final String countryCode;
  final String formattedNumber;
  final Function(String) onCountryCodeChanged;
  final Function(String) onPhoneNumberChanged;
  final VoidCallback onPhoneNumberEntered;

  const _PhoneNumberInputFields({
    required this.hasValidCountry,
    required this.countryCode,
    required this.formattedNumber,
    required this.onCountryCodeChanged,
    required this.onPhoneNumberChanged,
    required this.onPhoneNumberEntered,
  });

  @override
  State<_PhoneNumberInputFields> createState() => _PhoneNumberInputFieldsState();
}

class _PhoneNumberInputFieldsState extends State<_PhoneNumberInputFields> {
  late TextEditingController _codeController;
  late TextEditingController _phoneController;
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController(text: widget.countryCode);
    _phoneController = TextEditingController(text: widget.formattedNumber);
    if (widget.hasValidCountry) {
      Future.microtask(() => _phoneFocusNode.requestFocus());
    } else if (widget.countryCode.isEmpty) {
      Future.microtask(() => _codeFocusNode.requestFocus());
    }
  }

  @override
  void didUpdateWidget(_PhoneNumberInputFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.countryCode != _codeController.text) {
      _codeController.text = widget.countryCode;
    }
    if (widget.formattedNumber != _phoneController.text) {
      final oldSelection = _phoneController.selection;
      _phoneController.text = widget.formattedNumber;
      if (oldSelection.isValid) {
        _phoneController.selection = TextSelection.collapsed(
          offset: oldSelection.end.clamp(0, widget.formattedNumber.length),
        );
      }
    }
    if (widget.hasValidCountry && !oldWidget.hasValidCountry) {
      _phoneFocusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start, // Alinha pelo topo para consistência
      children: [
        SizedBox(
          width: 80, // Leve aumento para caber o prefixo e 3 dígitos
          child: TextField(
            controller: _codeController,
            focusNode: _codeFocusNode,
            onChanged: (v) {
              widget.onCountryCodeChanged(v);
              if (v.length >= 3) {
                _phoneFocusNode.requestFocus();
              }
            },
            keyboardType: TextInputType.number,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
            decoration: InputDecoration(
              labelText: " ", // Label vazia para forçar a mesma altura do campo ao lado
              prefixText: '+',
              prefixStyle: TextStyle(color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6)),
              filled: true,
              fillColor: colorScheme.surfaceContainerHighest,
              border: const UnderlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            onChanged: widget.onPhoneNumberChanged,
            onSubmitted: (_) => widget.onPhoneNumberEntered(),
            keyboardType: TextInputType.phone,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
            decoration: InputDecoration(
              labelText: context.translate('RegistrationActivity_phone_number_description'),
              filled: true,
              fillColor: colorScheme.surfaceContainerHighest,
              border: const UnderlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  final RegistrationScaffoldParams params;
  final PhoneNumberEntryState state;
  final Function(PhoneNumberEntryScreenEvents) onEvent;

  const _NextButton({required this.params, required this.state, required this.onEvent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 56,
            child: FilledButton.tonal(
              onPressed: state.isNumberPossible && !state.showSpinner ? () => onEvent(const PhoneNumberEntered()) : null,
              child: Text(context.translate('RegistrationActivity_next')),
            ),
          ),
        ],
      ),
    );
  }
}

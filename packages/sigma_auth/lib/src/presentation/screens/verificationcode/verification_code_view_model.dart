import 'dart:async';
import 'package:sigma_auth/sigma_auth.dart';

class VerificationCodeViewModel extends EventDrivenViewModel<VerificationCodeScreenEvents, VerificationCodeOneTimeEvent> {
  final IRegistrationRepository repository;
  final VerifyCodeInteractor verifyCodeInteractor;
  final AuthViewModel authViewModel;
  final String sessionId;
  final String initialE164;
  final Function() onNavigateToPhoneNumber;
  final Function() onVerificationSuccess;

  VerificationCodeState _state;
  VerificationCodeState get state => _state;

  Timer? _countdownTimer;

  VerificationCodeViewModel({
    required this.repository,
    required this.verifyCodeInteractor,
    required this.authViewModel,
    required this.sessionId,
    required this.initialE164,
    required this.onNavigateToPhoneNumber,
    required this.onVerificationSuccess,
  }) : _state = VerificationCodeState(e164: initialE164),
       super("VerificationCodeViewModel") {
    _startCountdown();
  }

  void _startCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      onEvent(const CountdownTick());
    });
  }

  @override
  Future<void> processEvent(VerificationCodeScreenEvents event) async {
    if (event is CodeEntered) {
      _applyCodeEntered(event.code);
    } else if (event is WrongNumber) {
      onNavigateToPhoneNumber();
    } else if (event is ResendSms) {
      _applyResendSms();
    } else if (event is CallMe) {
      _applyCallMe();
    } else if (event is CountdownTick) {
      _applyCountdownTick();
    }
    notifyListeners();
  }

  void _applyCountdownTick() {
    _state = _state.copyWith(
      smsResendTimeRemaining: (_state.smsResendTimeRemaining - 1).clamp(0, 999),
      callRequestTimeRemaining: (_state.callRequestTimeRemaining - 1).clamp(0, 999),
    );
  }

  Future<void> _applyCodeEntered(String code) async {
    _state = _state.copyWith(isSubmittingCode: true);
    notifyListeners();

    final result = await verifyCodeInteractor.execute(
      sessionId: sessionId,
      code: code,
      phone: initialE164,
    );

    _state = _state.copyWith(isSubmittingCode: false);
    if (result.success) {
      if (result.accountExists) {
        // O VerifyCodeInteractor já salvou a sessão e o perfil.
        // Apenas notificamos o AuthViewModel para atualizar seu status.
        await authViewModel.onVerificationSuccessReturningUser(
          result.accountData!['id'].toString(),
        );
      } else {
        await authViewModel.onVerificationSuccessNewUser(
          sessionId: sessionId,
          phone: initialE164,
        );
      }
      onVerificationSuccess();
    } else {
      emitEffect(IncorrectVerificationCode());
    }
    notifyListeners();
  }

  Future<void> _applyResendSms() async {
    final result = await repository.requestVerificationCode(sessionId, transport: 'SMS');
    if (result != null) {
      _state = _state.copyWith(smsResendTimeRemaining: 60);
    } else {
      emitEffect(VerificationUnableToSendSms());
    }
  }

  Future<void> _applyCallMe() async {
    final result = await repository.requestVerificationCode(sessionId, transport: 'VOICE');
    if (result != null) {
      _state = _state.copyWith(callRequestTimeRemaining: 60);
    } else {
      emitEffect(VerificationCouldNotRequestCodeWithSelectedTransport());
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }
}

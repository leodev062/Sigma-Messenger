class VerificationCodeState {
  final String e164;
  final int smsResendTimeRemaining;
  final int callRequestTimeRemaining;
  final bool isSubmittingCode;
  final int incorrectCodeAttempts;
  final VerificationCodeOneTimeEvent? oneTimeEvent;

  VerificationCodeState({
    this.e164 = "",
    this.smsResendTimeRemaining = 0,
    this.callRequestTimeRemaining = 0,
    this.isSubmittingCode = false,
    this.incorrectCodeAttempts = 0,
    this.oneTimeEvent,
  });

  VerificationCodeState copyWith({
    String? e164,
    int? smsResendTimeRemaining,
    int? callRequestTimeRemaining,
    bool? isSubmittingCode,
    int? incorrectCodeAttempts,
    VerificationCodeOneTimeEvent? oneTimeEvent,
  }) {
    return VerificationCodeState(
      e164: e164 ?? this.e164,
      smsResendTimeRemaining: smsResendTimeRemaining ?? this.smsResendTimeRemaining,
      callRequestTimeRemaining: callRequestTimeRemaining ?? this.callRequestTimeRemaining,
      isSubmittingCode: isSubmittingCode ?? this.isSubmittingCode,
      incorrectCodeAttempts: incorrectCodeAttempts ?? this.incorrectCodeAttempts,
      oneTimeEvent: oneTimeEvent ?? this.oneTimeEvent,
    );
  }
}

abstract class VerificationCodeOneTimeEvent {}
class IncorrectVerificationCode extends VerificationCodeOneTimeEvent {}
class VerificationNetworkError extends VerificationCodeOneTimeEvent {}
class VerificationUnknownError extends VerificationCodeOneTimeEvent {}
class VerificationUnableToSendSms extends VerificationCodeOneTimeEvent {}
class VerificationCouldNotRequestCodeWithSelectedTransport extends VerificationCodeOneTimeEvent {}
class RegistrationError extends VerificationCodeOneTimeEvent {}

class VerificationRateLimited extends VerificationCodeOneTimeEvent {
  final int retryAfter;
  VerificationRateLimited(this.retryAfter);
}

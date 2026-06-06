abstract class VerificationCodeScreenEvents {
  const VerificationCodeScreenEvents();
}

class CodeEntered extends VerificationCodeScreenEvents {
  final String code;
  const CodeEntered(this.code);
}

class WrongNumber extends VerificationCodeScreenEvents {
  const WrongNumber();
}

class ResendSms extends VerificationCodeScreenEvents {
  const ResendSms();
}

class CallMe extends VerificationCodeScreenEvents {
  const CallMe();
}

class HavingTrouble extends VerificationCodeScreenEvents {
  const HavingTrouble();
}

class ConsumeInnerOneTimeEvent extends VerificationCodeScreenEvents {
  const ConsumeInnerOneTimeEvent();
}

class CountdownTick extends VerificationCodeScreenEvents {
  const CountdownTick();
}

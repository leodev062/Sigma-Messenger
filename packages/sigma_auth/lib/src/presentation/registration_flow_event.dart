abstract class RegistrationFlowEvent {
  const RegistrationFlowEvent();
}

class ResetState extends RegistrationFlowEvent {
  const ResetState();
}

class SessionUpdated extends RegistrationFlowEvent {
  final String sessionId;
  final String e164;
  const SessionUpdated(this.sessionId, this.e164);
}

class E164Chosen extends RegistrationFlowEvent {
  final String e164;
  const E164Chosen(this.e164);
}

class CodeVerified extends RegistrationFlowEvent {
  const CodeVerified();
}

class Registered extends RegistrationFlowEvent {
  final String accountId;
  const Registered(this.accountId);
}

class NavigateToScreen extends RegistrationFlowEvent {
  final String route;
  const NavigateToScreen(this.route);
}

class NavigateBack extends RegistrationFlowEvent {
  const NavigateBack();
}

class RegistrationComplete extends RegistrationFlowEvent {
  const RegistrationComplete();
}

class RegistrationFlowState {
  final String? sessionId;
  final String? sessionE164;
  final bool isRestoringNavigationState;
  final bool isRegistered;
  final bool isVerified;

  const RegistrationFlowState({
    this.sessionId,
    this.sessionE164,
    this.isRestoringNavigationState = false,
    this.isRegistered = false,
    this.isVerified = false,
  });

  RegistrationFlowState copyWith({
    String? sessionId,
    String? sessionE164,
    bool? isRestoringNavigationState,
    bool? isRegistered,
    bool? isVerified,
  }) {
    return RegistrationFlowState(
      sessionId: sessionId ?? this.sessionId,
      sessionE164: sessionE164 ?? this.sessionE164,
      isRestoringNavigationState: isRestoringNavigationState ?? this.isRestoringNavigationState,
      isRegistered: isRegistered ?? this.isRegistered,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}

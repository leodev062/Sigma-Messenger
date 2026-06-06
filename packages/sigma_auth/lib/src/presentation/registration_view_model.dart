import 'package:sigma_auth/sigma_auth.dart';

class RegistrationViewModel extends EventDrivenViewModel<RegistrationFlowEvent, void> {
  final IRegistrationRepository repository;

  RegistrationFlowState _state = const RegistrationFlowState();
  RegistrationFlowState get state => _state;

  RegistrationViewModel({required this.repository}) : super("RegistrationViewModel") {
    _init();
  }

  Future<void> _init() async {
    _state = _state.copyWith(isRestoringNavigationState: true);
    notifyListeners();

    final restored = await repository.restoreFlowState();
    if (restored != null) {
      // Aqui poderíamos reconstruir o estado a partir do mapa persistido
      // _state = ...
    }
    
    _state = _state.copyWith(isRestoringNavigationState: false);
    notifyListeners();
  }

  @override
  Future<void> processEvent(RegistrationFlowEvent event) async {
    if (event is ResetState) {
      _state = const RegistrationFlowState();
    } else if (event is SessionUpdated) {
      _state = _state.copyWith(
        sessionId: event.sessionId,
        sessionE164: event.e164,
      );
    } else if (event is E164Chosen) {
      _state = _state.copyWith(sessionE164: event.e164);
    } else if (event is CodeVerified) {
      _state = _state.copyWith(isVerified: true);
    } else if (event is Registered) {
      _state = _state.copyWith(isRegistered: true);
    } else if (event is RegistrationComplete) {
      await repository.commitFinalRegistrationData({'account_id': _state.sessionId}); // Exemplo
      _state = _state.copyWith(isRegistered: true);
    }
    
    // Persistência como no Signal
    await _persistState();
    notifyListeners();
  }

  Future<void> _persistState() async {
    await repository.saveFlowState({
      'sessionId': _state.sessionId,
      'sessionE164': _state.sessionE164,
      'isRegistered': _state.isRegistered,
      'isVerified': _state.isVerified,
    });
  }
}

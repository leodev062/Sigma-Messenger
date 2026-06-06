import 'package:sigma_auth/sigma_auth.dart';

class RequestVerificationResult {
  final bool success;
  final String? sessionId;

  RequestVerificationResult({required this.success, this.sessionId});
}

/// Caso de uso para iniciar o fluxo de registro (Sessão + SMS).
class RequestVerificationInteractor {
  final IRegistrationRepository _repository;

  RequestVerificationInteractor(this._repository);

  Future<RequestVerificationResult> execute(String e164) async {
    // 1. Cria a sessão de registro
    final session = await _repository.createSession(e164);
    if (session == null) return RequestVerificationResult(success: false);

    final sessionId = session.session_id;

    // 2. Solicita o código via SMS
    final codeResponse = await _repository.requestVerificationCode(sessionId);
    if (codeResponse == null) return RequestVerificationResult(success: false);

    return RequestVerificationResult(success: true, sessionId: sessionId);
  }
}

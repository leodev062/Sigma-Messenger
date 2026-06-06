import 'package:sigma_auth/sigma_auth.dart';

/// Interface para o repositório de registro, seguindo os princípios da Clean Architecture.
abstract class IRegistrationRepository {
  /// Cria uma nova sessão de registro para o número de telefone fornecido.
  Future<RegistrationSessionResponse?> createSession(String e164);

  /// Solicita o envio de um código de verificação para a sessão atual.
  Future<RegistrationSessionResponse?> requestVerificationCode(
    String sessionId, {
    String transport = 'SMS',
  });

  /// Envia o código de verificação recebido pelo usuário.
  Future<RegistrationSessionResponse?> submitVerificationCode(
    String sessionId,
    String verificationCode, {
    String? deviceId,
    String? deviceName,
    String? platform,
    String? clientVersion,
  });

  /// Finaliza o registro da conta com as credenciais fornecidas.
  Future<CreateAccountResponse?> registerAccount({
    required String sessionId,
    required String password,
    String deviceName = 'Mobile App',
  });

  /// Verifica se o dispositivo atual já possui uma conta registrada localmente.
  Future<bool> isRegistered();

  /// Salva o estado atual do fluxo de registro para persistência.
  Future<void> saveFlowState(Map<String, dynamic> state);

  /// Restaura o estado anterior do fluxo de registro, se existir.
  Future<Map<String, dynamic>?> restoreFlowState();

  /// Confirma os dados finais de registro e salva o account_id.
  Future<void> commitFinalRegistrationData(Map<String, dynamic> registrationResponse);
}

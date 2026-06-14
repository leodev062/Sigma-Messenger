import 'dart:convert';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

/// Implementação do IRegistrationRepository na camada de Data.
/// Absorve a lógica que anteriormente estava em NetworkController e StorageController.
class RegistrationRepositoryImpl implements IRegistrationRepository {
  final RegistrationRemoteDataSource _remoteDataSource;
  final SigmaStore _store;

  static const String _flowStateKey = 'registration_flow_state';

  RegistrationRepositoryImpl({
    required RegistrationRemoteDataSource remoteDataSource,
    required SigmaStore store,
  })  : _remoteDataSource = remoteDataSource,
        _store = store;

  @override
  Future<RegistrationSessionResponse?> createSession(String e164) async {
    final result = await _remoteDataSource.createRegistrationSession(e164);
    return result.when((res) => res, (failure) => null);
  }

  @override
  Future<RegistrationSessionResponse?> requestVerificationCode(
    String sessionId, {
    String transport = 'SMS',
  }) async {
    final result = await _remoteDataSource.requestSmsVerificationCode(sessionId, transport: transport);
    return result.when((res) => res, (failure) => null);
  }

  @override
  Future<RegistrationSessionResponse?> submitVerificationCode(
    String sessionId,
    String verificationCode, {
    String? deviceId,
    String? deviceName,
    String? platform,
    String? clientVersion,
  }) async {
    final result = await _remoteDataSource.verifyAccount(
      sessionId,
      verificationCode,
      deviceId: deviceId,
      deviceName: deviceName,
      platform: platform,
      clientVersion: clientVersion,
    );
    return result.when((res) => res, (failure) => null);
  }

  @override
  Future<CreateAccountResponse?> registerAccount({
    required String sessionId,
    required String password,
    String deviceName = 'Mobile App',
  }) async {
    final result = await _remoteDataSource.registerAccount(
      sessionId: sessionId,
      password: password,
      deviceName: deviceName,
    );

    final response = result.when((res) => res, (failure) => null);

    if (response != null) {
      await _store.keys.write('account_id', response.account_id);
    }

    return response;
  }

  @override
  Future<bool> isRegistered() async {
    final state = await restoreFlowState();
    return state != null && state['is_registered'] == true;
  }

  @override
  Future<void> saveFlowState(Map<String, dynamic> state) async {
    await _store.keys.write(_flowStateKey, jsonEncode(state));
  }

  @override
  Future<Map<String, dynamic>?> restoreFlowState() async {
    final data = await _store.keys.read(_flowStateKey);
    if (data != null && data.isNotEmpty) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  @override
  Future<void> commitFinalRegistrationData(Map<String, dynamic> registrationResponse) async {
    final accountId = registrationResponse['account_id']?.toString() ?? 
                     registrationResponse['id']?.toString();
    
    if (accountId != null) {
      await _store.keys.write('account_id', accountId);
    }
  }
}

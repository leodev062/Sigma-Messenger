import 'package:multiple_result/multiple_result.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

abstract class RegistrationRemoteDataSource {
  Future<Result<RegistrationSessionResponse, Failure>> createRegistrationSession(String phone, {String clientType = 'android'});
  Future<Result<RegistrationSessionResponse, Failure>> getRegistrationSession(String sessionId);
  Future<Result<RegistrationSessionResponse, Failure>> requestSmsVerificationCode(String sessionId, {String transport = 'SMS'});
  Future<Result<RegistrationSessionResponse, Failure>> verifyAccount(
    String sessionId,
    String code, {
    String? deviceId,
    String? deviceName,
    String? platform,
    String? clientVersion,
  });
  Future<Result<CreateAccountResponse, Failure>> registerAccount({
    required String sessionId,
    required String password,
    required String deviceName,
  });
}

class RegistrationRemoteDataSourceImpl with NetworkErrorHandler implements RegistrationRemoteDataSource {
  final RegistrationService _service;

  RegistrationRemoteDataSourceImpl(this._service);

  @override
  Future<Result<RegistrationSessionResponse, Failure>> createRegistrationSession(String phone, {String clientType = 'android'}) {
    return safeCall(() => _service.createRegistrationSession({
      'number': phone,
      'client_type': clientType,
    }).then((res) => res.data));
  }

  @override
  Future<Result<RegistrationSessionResponse, Failure>> getRegistrationSession(String sessionId) {
    return safeCall(() => _service.getRegistrationSession(sessionId).then((res) => res.data));
  }

  @override
  Future<Result<RegistrationSessionResponse, Failure>> requestSmsVerificationCode(String sessionId, {String transport = 'SMS'}) {
    return safeCall(() => _service.requestSmsVerificationCode({
      'session_id': sessionId,
      'transport': transport,
    }).then((res) => res.data));
  }

  @override
  Future<Result<RegistrationSessionResponse, Failure>> verifyAccount(
    String sessionId,
    String code, {
    String? deviceId,
    String? deviceName,
    String? platform,
    String? clientVersion,
  }) {
    return safeCall(() => _service.verifyAccount({
      'session_id': sessionId,
      'verification_code': code,
      'device_id': deviceId,
      'device_name': deviceName,
      'platform': platform,
      'client_version': clientVersion,
    }).then((res) => res.data));
  }

  @override
  Future<Result<CreateAccountResponse, Failure>> registerAccount({
    required String sessionId,
    required String password,
    required String deviceName,
  }) {
    return safeCall(() => _service.registerAccount({
      'session_id': sessionId,
      'password': password,
      'device_name': deviceName,
    }).then((res) => res.data));
  }
}

import 'package:multiple_result/multiple_result.dart';
import 'package:sigma_core/src/network/error/failure.dart';
import 'package:sigma_core/src/network/error/network_error_handler.dart';
import 'package:sigma_core/src/data/models/user_response.dart';
import 'package:sigma_core/sigma_core.dart';

abstract class AccountRemoteDataSource {
  Future<Result<UserDto, Failure>> createAccount(Map<String, dynamic> data);
  Future<Result<UserDto, Failure>> getMe();
  Future<Result<void, Failure>> deleteAccount();
  Future<Result<void, Failure>> updateFCMToken(String token);
  Future<Result<List<UserDeviceSessionDto>, Failure>> getDevices();
  Future<Result<void, Failure>> deleteDevice(String id);
}

class AccountRemoteDataSourceImpl with NetworkErrorHandler implements AccountRemoteDataSource {
  final AccountService _service;

  AccountRemoteDataSourceImpl(this._service);

  @override
  Future<Result<UserDto, Failure>> createAccount(Map<String, dynamic> data) {
    return safeCall(() => _service.createAccount(data).then((res) => res.data));
  }

  @override
  Future<Result<UserDto, Failure>> getMe() {
    return safeCall(() => _service.getMe().then((res) => res.data));
  }

  @override
  Future<Result<void, Failure>> deleteAccount() {
    return safeCall(() => _service.deleteAccount());
  }

  @override
  Future<Result<void, Failure>> updateFCMToken(String token) {
    return safeCall(() => _service.updateFCMToken({'token': token}));
  }

  @override
  Future<Result<List<UserDeviceSessionDto>, Failure>> getDevices() {
    return safeCall(() => _service.getDevices());
  }

  @override
  Future<Result<void, Failure>> deleteDevice(String id) {
    return safeCall(() => _service.deleteDevice(id));
  }
}

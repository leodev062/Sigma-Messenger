import 'package:multiple_result/multiple_result.dart';
import 'package:sigma_core/src/network/error/failure.dart';
import 'package:sigma_core/src/network/error/network_error_handler.dart';
import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/network/pb/keys.pb.dart' as sigmapb;

abstract class KeysRemoteDataSource {
  Future<Result<sigmapb.PreKeyBundle, Failure>> getUserKeys(String id);
  Future<Result<void, Failure>> putKeys(sigmapb.PreKeyBundle bundle);
}

class KeysRemoteDataSourceImpl with NetworkErrorHandler implements KeysRemoteDataSource {
  final KeysApiService _service;

  KeysRemoteDataSourceImpl(this._service);

  @override
  Future<Result<sigmapb.PreKeyBundle, Failure>> getUserKeys(String id) {
    return safeCall(() => _service.getKeys(id).then((bytes) => sigmapb.PreKeyBundle.fromBuffer(bytes)));
  }

  @override
  Future<Result<void, Failure>> putKeys(sigmapb.PreKeyBundle bundle) {
    return safeCall(() => _service.putKeys(bundle.writeToBuffer()));
  }
}

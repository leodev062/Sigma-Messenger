import 'package:sigma/domain/repositories/i_auth_repository.dart';

class RequestCodeInteractor {
  final IAuthRepository _repository;

  RequestCodeInteractor(this._repository);

  Future<void> execute(String phone) => _repository.requestCode(phone);
}

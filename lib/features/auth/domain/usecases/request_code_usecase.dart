import 'package:sigma/features/auth/domain/repositories/auth_repository.dart';

class RequestCodeUseCase {
  final AuthRepository repository;

  RequestCodeUseCase(this.repository);

  Future<void> execute(String phone) async {
    return await repository.requestCode(phone);
  }
}

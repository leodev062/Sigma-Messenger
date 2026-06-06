import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_auth/sigma_auth.dart';

class SignalServiceAccountManager {
  final RegistrationRemoteDataSource registrationRemoteDataSource;
  final AccountRemoteDataSource accountRemoteDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;

  SignalServiceAccountManager({
    required this.registrationRemoteDataSource,
    required this.accountRemoteDataSource,
    required this.profileRemoteDataSource,
  });

  // Métodos de alto nível que combinam chamadas se necessário
}

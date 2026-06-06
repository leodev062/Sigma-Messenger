/// Representação de falhas de domínio para a camada de rede.
abstract class Failure {
  final String message;
  final int? statusCode;

  Failure(this.message, {this.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message, {super.statusCode});
}

class ServerFailure extends Failure {
  ServerFailure(super.message, {super.statusCode});
}

class AuthFailure extends Failure {
  AuthFailure(super.message, {super.statusCode});
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message, {super.statusCode});
}

class CryptoFailure extends Failure {
  CryptoFailure(super.message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(super.message);
}

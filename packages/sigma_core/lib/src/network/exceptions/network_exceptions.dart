abstract class SignalServiceException implements Exception {
  final String? message;
  SignalServiceException([this.message]);

  @override
  String toString() => message ?? runtimeType.toString();
}

class RateLimitException extends SignalServiceException {
  final Duration? retryAfter;
  RateLimitException({this.retryAfter, String? message}) : super(message);
}

class IncorrectCodeException extends SignalServiceException {
  IncorrectCodeException([super.message]);
}

class NoSuchSessionException extends SignalServiceException {
  NoSuchSessionException([super.message]);
}

class AlreadyVerifiedException extends SignalServiceException {
  AlreadyVerifiedException([super.message]);
}

class UsernameTakenException extends SignalServiceException {
  UsernameTakenException([super.message]);
}

class AuthorizationFailedException extends SignalServiceException {
  AuthorizationFailedException([super.message]);
}

class UnregisteredUserException extends SignalServiceException {
  UnregisteredUserException([super.message]);
}

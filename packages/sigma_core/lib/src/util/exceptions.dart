class SigmaException implements Exception {
  final String message;
  SigmaException(this.message);

  @override
  String toString() => message;
}

class DecryptionException extends SigmaException {
  DecryptionException(super.message);
}

class SessionNotFoundException extends SigmaException {
  SessionNotFoundException(super.message);
}

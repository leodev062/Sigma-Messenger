import 'package:sigma/core/storage/database.dart';

abstract class IRecipientRepository {
  Stream<User?> getRecipient(String id);
  Stream<List<User>> getAllRecipients();
  Future<void> refreshRecipient(String id);
}

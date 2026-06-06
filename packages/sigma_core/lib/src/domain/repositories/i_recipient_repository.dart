import 'package:sigma_core/src/domain/entities/recipient.dart';

abstract class IRecipientRepository {
  Stream<Recipient?> watchRecipient(String id);
  Future<void> saveRecipient(Recipient recipient);
  Future<Recipient?> getRecipientByUuid(String uuid);
  Stream<List<Recipient>> watchAllRecipients();
  Future<List<Recipient>> getAllRecipients();
  Future<List<Recipient>> search(String term);
  Future<List<Recipient>> searchRemote(String term);
}

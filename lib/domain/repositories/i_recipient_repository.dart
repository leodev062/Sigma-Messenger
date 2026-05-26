import 'package:sigma/domain/entities/user_entity.dart';

abstract class IRecipientRepository {
  Stream<UserEntity?> getRecipient(String id);
  Stream<List<UserEntity>> getAllRecipients();
  Future<void> refreshRecipient(String id);
}

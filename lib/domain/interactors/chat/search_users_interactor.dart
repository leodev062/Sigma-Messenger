import 'package:sigma/domain/entities/user_entity.dart';
import 'package:sigma/domain/repositories/i_recipient_repository.dart';

class SearchUsersInteractor {
  final IRecipientRepository _repository;

  SearchUsersInteractor(this._repository);

  Future<List<UserEntity>> execute(String term) async {
    if (term.isEmpty) return [];
    return _repository.searchRemote(term);
  }
}

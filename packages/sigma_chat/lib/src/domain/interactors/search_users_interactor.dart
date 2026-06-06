import 'package:sigma_core/sigma_core.dart';

class SearchUsersInteractor {
  final IRecipientRepository _repository;

  SearchUsersInteractor(this._repository);

  Future<List<Recipient>> execute(String term) async {
    if (term.isEmpty) return [];
    return _repository.search(term);
  }
}

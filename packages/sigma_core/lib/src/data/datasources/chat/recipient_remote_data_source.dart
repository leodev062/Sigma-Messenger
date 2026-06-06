import 'package:sigma_core/sigma_core.dart';
import 'package:sigma_core/src/data/models/user_response.dart';

abstract class RecipientRemoteDataSource {
  Future<List<UserDto>> searchUsers(String term);
}

class RecipientRemoteDataSourceImpl implements RecipientRemoteDataSource {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  RecipientRemoteDataSourceImpl(this._profileRemoteDataSource);

  @override
  Future<List<UserDto>> searchUsers(String term) async {
    final result = await _profileRemoteDataSource.searchUsers(term);
    return result.when(
      (users) => users,
      (failure) => [],
    );
  }
}

import 'package:sigma/core/network/search_manager.dart';
import 'package:sigma/data/models/user_response.dart';

abstract class RecipientRemoteDataSource {
  Future<List<UserDto>> searchUsers(String term);
}

class RecipientRemoteDataSourceImpl implements RecipientRemoteDataSource {
  final SearchManager _searchManager;

  RecipientRemoteDataSourceImpl(this._searchManager);

  @override
  Future<List<UserDto>> searchUsers(String term) async {
    final rawList = await _searchManager.searchUsers(term);
    return rawList.map((json) => UserDto.fromJson(json)).toList();
  }
}

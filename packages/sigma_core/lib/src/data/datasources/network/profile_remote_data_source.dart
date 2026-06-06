import 'package:multiple_result/multiple_result.dart';
import 'package:sigma_core/src/network/error/failure.dart';
import 'package:sigma_core/src/network/error/network_error_handler.dart';
import 'package:sigma_core/src/data/models/user_response.dart';
import 'package:sigma_core/sigma_core.dart';

abstract class ProfileRemoteDataSource {
  Future<Result<UserDto, Failure>> getProfile(String userId);
  Future<Result<UserDto, Failure>> updateProfile({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
    String? email,
    String? country,
    String? relativeName,
    String? relativeId,
    bool? isPrivate,
  });
  Future<Result<bool, Failure>> checkUsername(String username);
  Future<Result<List<UserDto>, Failure>> searchUsers(String term);
}

class ProfileRemoteDataSourceImpl with NetworkErrorHandler implements ProfileRemoteDataSource {
  final ProfileService _service;

  ProfileRemoteDataSourceImpl(this._service);

  @override
  Future<Result<UserDto, Failure>> getProfile(String userId) {
    return safeCall(() => _service.getProfile(userId).then((res) => res.data));
  }

  @override
  Future<Result<UserDto, Failure>> updateProfile({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
    String? email,
    String? country,
    String? relativeName,
    String? relativeId,
    bool? isPrivate,
  }) {
    final data = {
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (email != null) 'email': email,
      if (country != null) 'country': country,
      if (relativeName != null) 'relative_name': relativeName,
      if (relativeId != null) 'relative_id': relativeId,
      if (isPrivate != null) 'is_private': isPrivate,
    };
    return safeCall(() => _service.updateProfile(data).then((res) => res.data));
  }

  @override
  Future<Result<bool, Failure>> checkUsername(String username) {
    return safeCall(() => _service.checkUsername(username).then((res) => res.data.available));
  }

  @override
  Future<Result<List<UserDto>, Failure>> searchUsers(String term) {
    return safeCall(() => _service.searchUsers(term).then((res) => res.data));
  }
}

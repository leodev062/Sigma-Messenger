import 'package:sigma_core/sigma_core.dart';

abstract class IProfileRepository {
  Future<Recipient> updateProfile({
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

  Future<Recipient?> getSelfProfile();
  
  Stream<Recipient?> watchSelfProfile();

  Future<bool> isUsernameAvailable(String username);
}

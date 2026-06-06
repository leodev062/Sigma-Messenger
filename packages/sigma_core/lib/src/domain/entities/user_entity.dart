import 'package:sigma_core/src/domain/entities/recipient.dart';

/// UserEntity - O modelo de negócio puro.
/// Representa o usuário logado ou qualquer contato no sistema.
class UserEntity {
  final String id;
  final String? name;
  final String? username;
  final String? bio;
  final String phone;
  final String? email;
  final String? country;
  final String? avatarUrl;
  final bool isVerified;
  final String type;
  final String? relativeName;
  final String? relativeId;
  final String? identityKey;
  final int? signedPreKeyId;
  final String? signedPreKeyPublic;
  final String? signedPreKeySignature;
  final int? registrationId;
  final String? preKeys;
  final bool isPrivate;

  UserEntity({
    required this.id,
    required this.phone,
    this.name,
    this.username,
    this.bio,
    this.email,
    this.country,
    this.avatarUrl,
    this.isVerified = false,
    this.type = 'individual',
    this.relativeName,
    this.relativeId,
    this.identityKey,
    this.signedPreKeyId,
    this.signedPreKeyPublic,
    this.signedPreKeySignature,
    this.registrationId,
    this.preKeys,
    this.isPrivate = false,
  });

  /// Converte para o objeto Recipient usado na UI de Chat.
  Recipient toRecipient() {
    return Recipient(
      id: id,
      type: type == 'bot' ? RecipientType.bot : RecipientType.individual,
      phone: phone,
      profileName: name,
      username: username,
      avatarUrl: avatarUrl,
      bio: bio,
      email: email,
      country: country,
      isPrivate: isPrivate,
    );
  }

  UserEntity copyWith({
    String? name,
    String? username,
    String? bio,
    String? avatarUrl,
    String? email,
    String? country,
    String? type,
    String? relativeName,
    String? relativeId,
    String? identityKey,
    int? signedPreKeyId,
    String? signedPreKeyPublic,
    String? signedPreKeySignature,
    int? registrationId,
    String? preKeys,
    bool? isPrivate,
  }) {
    return UserEntity(
      id: id,
      phone: phone,
      name: name ?? this.name,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      country: country ?? this.country,
      isVerified: isVerified,
      type: type ?? this.type,
      relativeName: relativeName ?? this.relativeName,
      relativeId: relativeId ?? this.relativeId,
      identityKey: identityKey ?? this.identityKey,
      signedPreKeyId: signedPreKeyId ?? this.signedPreKeyId,
      signedPreKeyPublic: signedPreKeyPublic ?? this.signedPreKeyPublic,
      signedPreKeySignature: signedPreKeySignature ?? this.signedPreKeySignature,
      registrationId: registrationId ?? this.registrationId,
      preKeys: preKeys ?? this.preKeys,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }
}

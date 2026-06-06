import 'package:sigma_core/src/data/models/user_response.dart';
import 'package:sigma_core/src/domain/entities/user_entity.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:drift/drift.dart';
import 'package:sigma_core/src/util/avatar_util.dart';

/// UserMapper - Isola a camada de domínio das camadas de dados (API e DB).
class UserMapper {
  
  /// Converte DTO da API para Entidade de Domínio.
  static UserEntity fromDto(UserDto dto) {
    return UserEntity(
      id: dto.id,
      phone: dto.phone,
      name: dto.name,
      username: dto.username,
      bio: dto.bio,
      avatarUrl: dto.avatarUrl,
      email: dto.email,
      country: dto.country,
      isVerified: dto.isVerified,
      type: dto.type,
      relativeName: dto.relativeName,
      relativeId: dto.relativeId,
      identityKey: dto.identityKey,
      signedPreKeyId: dto.signedPreKeyId,
      signedPreKeyPublic: dto.signedPreKeyPublic,
      signedPreKeySignature: dto.signedPreKeySignature,
      registrationId: dto.registrationId,
      preKeys: dto.preKeys,
      isPrivate: dto.isPrivate,
    );
  }

  /// Converte Registro do Banco de Dados para Entidade de Domínio.
  static UserEntity fromDb(RecipientData record) {
    return UserEntity(
      id: record.id,
      phone: record.phone ?? "",
      name: record.profileName ?? record.displayName,
      username: record.username,
      bio: record.bio,
      avatarUrl: record.avatarUrl,
      email: record.email,
      country: record.country,
      relativeName: record.relativeName,
      relativeId: record.relativeId,
      identityKey: record.identityKey,
      signedPreKeyId: record.signedPreKeyId,
      signedPreKeyPublic: record.signedPreKeyPublic,
      signedPreKeySignature: record.signedPreKeySignature,
      registrationId: record.registrationId != null ? record.registrationId!.toInt() : null,
      preKeys: record.preKeys,
      isPrivate: record.isPrivate,
    );
  }

  /// Converte Entidade para Companion do Drift (para salvar no banco).
  static RecipientsCompanion toDb(UserEntity entity) {
    final color = AvatarUtil.getBackgroundColor(entity.name ?? entity.username ?? entity.id);
    final colorHex = '#FF${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return RecipientsCompanion(
      id: Value(entity.id),
      type: Value(entity.type == 'bot' ? RecipientTypeDb.bot : RecipientTypeDb.individual),
      phone: Value(entity.phone),
      email: Value(entity.email),
      profileName: Value(entity.name), // Mapear para profileName (Padrão Signal)
      displayName: Value(entity.name), // Fallback para displayName
      username: Value(entity.username),
      avatarUrl: Value(entity.avatarUrl),
      bio: Value(entity.bio),
      country: Value(entity.country),
      relativeName: Value(entity.relativeName),
      relativeId: Value(entity.relativeId),
      identityKey: Value(entity.identityKey),
      signedPreKeyId: Value(entity.signedPreKeyId),
      signedPreKeyPublic: Value(entity.signedPreKeyPublic),
      signedPreKeySignature: Value(entity.signedPreKeySignature),
      registrationId: Value(entity.registrationId != null ? BigInt.from(entity.registrationId!) : null),
      preKeys: Value(entity.preKeys),
      isPrivate: Value(entity.isPrivate),
      fallbackColor: Value(colorHex),
    );
  }
}

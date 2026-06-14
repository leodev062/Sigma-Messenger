import 'package:sigma_core/src/data/models/user_response.dart';
import 'package:sigma_core/src/domain/entities/user_entity.dart';
import 'package:sigma_database/sigma_database.dart';
import 'package:drift/drift.dart';

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
  static UserEntity fromDb(User record) {
    return UserEntity(
      id: record.id,
      phone: record.phone ?? "",
      name: record.name,
      username: record.username,
      bio: record.bio,
      avatarUrl: record.avatarUrl,
      type: record.isBot ? 'bot' : 'individual',
    );
  }

  /// Converte Entidade para Companion do Drift (para salvar no banco).
  static UsersCompanion toDb(UserEntity entity) {
    return UsersCompanion(
      id: Value(entity.id),
      phone: Value(entity.phone),
      name: Value(entity.name),
      username: Value(entity.username),
      email: Value(entity.email),
      bio: Value(entity.bio),
      avatarUrl: Value(entity.avatarUrl),
      isBot: Value(entity.type == 'bot'),
      updatedAt: Value(DateTime.now().millisecondsSinceEpoch),
    );
  }
}

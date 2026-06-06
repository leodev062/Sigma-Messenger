import 'dart:ui';
import 'package:sigma_core/src/contacts/avatars/contact_photo.dart';
import 'package:sigma_core/src/contacts/avatars/profile_contact_photo.dart';
import 'package:sigma_core/src/contacts/avatars/fallback_contact_photo.dart';
import 'package:sigma_core/src/util/avatar_util.dart';

// Alinhado com RecipientType.java do Signal
enum RecipientType { individual, group, channel, bot }

/// Recipient - Representa um contato ou grupo.
/// Implementado como um Snapshot imutável seguindo o padrão Signal-Android.
class Recipient {
  final String id;
  
  // Identificadores Signal-Style (ACI/PNI)
  final String? aci; // Account Connection Identifier
  final String? pni; // Phone Number Identity
  
  final RecipientType type;
  final String? phone;
  final String? email;
  final String? username;
  
  // Nomes com precedência (Signal Standard)
  final String? systemDisplayName; // Nome dos contatos do celular
  final String? profileName;       // Nome definido pelo usuário no servidor Signal
  final String? groupName;         // Nome do grupo
  
  final String? avatarUrl;
  final String? bio;
  final bool isOnline;
  final DateTime? lastSeen;
  final String? verificationType;
  final Color fallbackColor;
  final bool isPrivate;
  final String? country;

  // Campo restaurado para suporte a grupos
  final int participantCount;

  Recipient({
    required this.id,
    required this.type,
    this.aci,
    this.pni,
    this.phone,
    this.email,
    this.username,
    this.systemDisplayName,
    this.profileName,
    this.groupName,
    this.avatarUrl,
    this.bio,
    this.isOnline = false,
    this.lastSeen,
    this.verificationType = 'none',
    this.participantCount = 0,
    this.isPrivate = false,
    this.country,
    Color? fallbackColor,
  }) : fallbackColor = fallbackColor ?? AvatarUtil.getBackgroundColor(
          systemDisplayName ?? profileName ?? groupName ?? username ?? phone ?? id
        );

  /// Factory para criar um contato desconhecido (Stub)
  factory Recipient.createUnknown(String id) {
    return Recipient(
      id: id,
      type: RecipientType.individual,
    );
  }

  /// Lógica de exibição de nome com precedência rigorosa (Signal Standard)
  String get computedDisplayName {
    if (type == RecipientType.group && groupName != null && groupName!.isNotEmpty) {
      return groupName!;
    }
    // 1. Prioridade para o nome que o usuário deu ao contato no celular
    if (systemDisplayName != null && systemDisplayName!.isNotEmpty) {
      return systemDisplayName!;
    }
    // 2. Nome do perfil Signal (definido pelo contato)
    if (profileName != null && profileName!.isNotEmpty) {
      return profileName!;
    }
    // 3. Username
    if (username != null && username!.isNotEmpty) {
      return '@$username';
    }
    // 4. Telefone ou Fallback
    return phone ?? 'Desconhecido';
  }

  /// Alias para computedDisplayName para compatibilidade com código legado
  String get displayName => computedDisplayName;

  String get initials => AvatarUtil.getInitials(computedDisplayName);

  Color get color => fallbackColor;

  ContactPhoto get contactPhoto {
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return ProfileContactPhoto(avatarUrl!);
    }
    return FallbackContactPhoto(this);
  }

  /// snapshot: Retorna uma cópia para garantir imutabilidade em fluxos reativos
  Recipient copyWith({
    String? systemDisplayName,
    String? profileName,
    String? avatarUrl,
    bool? isOnline,
    DateTime? lastSeen,
    int? participantCount,
    bool? isPrivate,
    String? country,
  }) {
    return Recipient(
      id: id,
      aci: aci,
      pni: pni,
      type: type,
      phone: phone,
      email: email,
      username: username,
      systemDisplayName: systemDisplayName ?? this.systemDisplayName,
      profileName: profileName ?? this.profileName,
      groupName: groupName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      verificationType: verificationType,
      participantCount: participantCount ?? this.participantCount,
      isPrivate: isPrivate ?? this.isPrivate,
      country: country ?? this.country,
      fallbackColor: fallbackColor,
    );
  }
}

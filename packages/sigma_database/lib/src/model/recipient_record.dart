import 'package:sigma_database/sigma_database.dart';

/// RecipientRecord - Objeto de domínio do banco para contatos.
/// Refatorado para o padrão Signal 2024 (ACI/PNI/Profile).
class RecipientRecord {
  final RecipientData data;
  
  RecipientRecord(this.data);

  String get id => data.id;
  
  // Identificadores modernos
  String? get aci => data.aci;
  String? get pni => data.pni;
  
  String? get username => data.username;
  
  // Lógica de nome prioritária do Signal: 
  // 1. Nome do Perfil (decriptado)
  // 2. Nome do Sistema (contatos do celular)
  // 3. Username
  // 4. Telefone
  String get displayName => data.profileName ?? data.systemDisplayName ?? data.username ?? data.phone ?? "Unknown";
  
  String? get avatarUrl => data.avatarUrl;
  String? get bio => data.bio;
  String? get profileKey => data.profileKey;
}

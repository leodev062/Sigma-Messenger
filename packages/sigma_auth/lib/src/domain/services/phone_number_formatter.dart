import 'package:phone_numbers_parser/phone_numbers_parser.dart';

/// Utilitário para formatação e validação de números de telefone.
class PhoneNumberFormatter {
  /// Formata um número nacional baseado na região.
  /// Ex: (11) 99999-9999 para BR.
  static String formatNational(String nationalNumber, String isoCode) {
    if (nationalNumber.isEmpty) return "";
    
    try {
      final parsed = PhoneNumber.parse(nationalNumber, destinationCountry: IsoCode.fromJson(isoCode));
      return parsed.formatNsn();
    } catch (e) {
      // Fallback para números parciais ou inválidos
      return nationalNumber;
    }
  }

  /// Converte para o formato E164 (Internacional padronizado).
  /// Ex: +5511999999999
  static String toE164(String nationalNumber, String countryCode) {
    final sanitized = nationalNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return "+$countryCode$sanitized";
  }

  /// Valida se o número é possível para o país.
  static bool isValid(String nationalNumber, String isoCode) {
    try {
      final parsed = PhoneNumber.parse(nationalNumber, destinationCountry: IsoCode.fromJson(isoCode));
      return parsed.isValid();
    } catch (e) {
      return false;
    }
  }
}

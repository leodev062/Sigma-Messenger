import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SigmaStrings {
  static Map<String, String>? _localizedValues;
  static String? _currentLocale;

  static Future<void> load(String languageCode) async {
    if (_currentLocale == languageCode && _localizedValues != null) return;

    try {
      String jsonString = await rootBundle.loadString('assets/lang/$languageCode.json');
      Map<String, dynamic> mappedJson = json.decode(jsonString);
      _localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
      _currentLocale = languageCode;
    } catch (e) {
      // Fallback to English if loading fails
      if (languageCode != 'en') {
        await load('en');
      }
    }
  }

  static String get(BuildContext context, String key, {Map<String, String>? args, int? count}) {
    // If we have count, we handle simple pluralization
    // Key pattern for plurals: key_zero, key_one, key_other
    String? value;
    
    if (count != null) {
      if (count == 0) value = _localizedValues?['${key}_zero'];
      if (count == 1) value = _localizedValues?['${key}_one'] ?? _localizedValues?[key];
      value ??= _localizedValues?['${key}_other'] ?? _localizedValues?[key];
    } else {
      value = _localizedValues?[key];
    }

    value ??= key; // Fallback to key itself if not found

    if (args != null) {
      args.forEach((k, v) {
        value = value!.replaceAll('{$k}', v);
      });
    }

    if (count != null) {
      value = value!.replaceAll('{count}', count.toString());
    }
    
    return value!;
  }
}

extension SigmaStringsExtension on BuildContext {
  String translate(String key, {Map<String, String>? args, int? count}) => 
      SigmaStrings.get(this, key, args: args, count: count);
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigma_core/src/i18n/strings.dart';

class DateUtil {
  /// Retorna um rótulo amigável para a data (Hoje, Ontem ou Data Formatada).
  static String getFriendlyDateLabel(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final checkDate = DateTime(date.year, date.month, date.day);

    if (checkDate == today) {
      return context.translate('today');
    } else if (checkDate == yesterday) {
      return context.translate('yesterday');
    } else if (now.difference(checkDate).inDays < 7) {
      final locale = Localizations.localeOf(context).languageCode;
      return DateFormat('EEEE', locale).format(date); // Nome do dia da semana
    } else {
      final locale = Localizations.localeOf(context).languageCode;
      return DateFormat.yMMMd(locale).format(date); // Data curta
    }
  }

  static bool isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}

import 'dart:ui' show Locale;

import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String relativeTime([Locale? locale]) {
    final now = DateTime.now();
    final diff = now.difference(this);
    final isArabic = locale?.languageCode == 'ar';

    if (diff.inMinutes < 1) return isArabic ? 'الآن' : 'now';
    if (diff.inMinutes < 60) {
      if (isArabic) return 'منذ ${diff.inMinutes} دقيقة';
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      if (isArabic) return 'منذ ${diff.inHours} ساعة';
      return '${diff.inHours}h ago';
    }
    if (diff.inDays < 7) {
      if (isArabic) return 'منذ ${diff.inDays} يوم';
      return '${diff.inDays}d ago';
    }
    return DateFormat('yyyy/MM/dd').format(this);
  }
}

extension StringCasing on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

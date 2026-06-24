import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:newslingo/core/utils/extensions.dart';

void main() {
  group('DateTime.relativeTime', () {
    test('returns "now" for recent dates', () {
      final dt = DateTime.now();
      expect(dt.relativeTime(), 'now');
    });

    test('returns "Xm ago" for minutes', () {
      final dt = DateTime.now().subtract(const Duration(minutes: 5));
      expect(dt.relativeTime(), '5m ago');
    });

    test('returns "Xh ago" for hours', () {
      final dt = DateTime.now().subtract(const Duration(hours: 3));
      expect(dt.relativeTime(), '3h ago');
    });

    test('returns "Xd ago" for days', () {
      final dt = DateTime.now().subtract(const Duration(days: 2));
      expect(dt.relativeTime(), '2d ago');
    });

    test('returns formatted date for 7+ days', () {
      final dt = DateTime(2026, 1, 1);
      final result = dt.relativeTime();
      expect(result, contains('2026'));
    });

    test('returns Arabic for ar locale', () {
      final ar = const Locale('ar');
      final dt = DateTime.now().subtract(const Duration(minutes: 5));
      expect(dt.relativeTime(ar), contains('دقيقة'));
    });

    test('returns "الآن" for Arabic recent', () {
      final ar = const Locale('ar');
      expect(DateTime.now().relativeTime(ar), 'الآن');
    });
  });

  group('String.capitalize', () {
    test('capitalizes first letter', () {
      expect('hello'.capitalize, 'Hello');
    });

    test('handles empty string', () {
      expect(''.capitalize, '');
    });

    test('handles single char', () {
      expect('a'.capitalize, 'A');
    });
  });
}

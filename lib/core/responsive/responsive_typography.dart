import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_typography.dart';

class ResponsiveTypography {
  static double _sp(double size) => size.sp;

  static TextStyle get displayLarge =>
      AppTypography.displayLarge.copyWith(fontSize: _sp(34));
  static TextStyle get displayMedium =>
      AppTypography.displayMedium.copyWith(fontSize: _sp(28));
  static TextStyle get headlineLarge =>
      AppTypography.headlineLarge.copyWith(fontSize: _sp(24));
  static TextStyle get headlineMedium =>
      AppTypography.headlineMedium.copyWith(fontSize: _sp(22));
  static TextStyle get headlineSmall =>
      AppTypography.headlineSmall.copyWith(fontSize: _sp(20));
  static TextStyle get titleLarge =>
      AppTypography.titleLarge.copyWith(fontSize: _sp(18));
  static TextStyle get titleMedium =>
      AppTypography.titleMedium.copyWith(fontSize: _sp(16));
  static TextStyle get titleSmall =>
      AppTypography.titleSmall.copyWith(fontSize: _sp(14));
  static TextStyle get bodyLarge =>
      AppTypography.bodyLarge.copyWith(fontSize: _sp(16));
  static TextStyle get bodyMedium =>
      AppTypography.bodyMedium.copyWith(fontSize: _sp(14));
  static TextStyle get bodySmall =>
      AppTypography.bodySmall.copyWith(fontSize: _sp(12));
  static TextStyle get labelLarge =>
      AppTypography.labelLarge.copyWith(fontSize: _sp(14));
  static TextStyle get labelMedium =>
      AppTypography.labelMedium.copyWith(fontSize: _sp(12));
  static TextStyle get labelSmall =>
      AppTypography.labelSmall.copyWith(fontSize: _sp(11));
}

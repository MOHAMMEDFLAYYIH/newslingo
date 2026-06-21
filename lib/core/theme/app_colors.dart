import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary - Vibrant Green (Duolingo-inspired but unique)
  static const Color primary = Color(0xFF58CC02);
  static const Color primaryLight = Color(0xFF7CE033);
  static const Color primaryDark = Color(0xFF46A302);
  static const Color primaryContainer = Color(0xFFE6F9D1);

  // Secondary - Warm Coral
  static const Color secondary = Color(0xFFFF6B4A);
  static const Color secondaryLight = Color(0xFFFF8B72);
  static const Color secondaryContainer = Color(0xFFFFE4DD);

  // Tertiary - Playful Purple
  static const Color tertiary = Color(0xFF8C52FF);
  static const Color tertiaryLight = Color(0xFFA87DFF);
  static const Color tertiaryContainer = Color(0xFFEFE5FF);

  // Accent colors for variety
  static const Color accentBlue = Color(0xFF1CB0F6);
  static const Color accentBlueContainer = Color(0xFFD6F0FF);
  static const Color accentPink = Color(0xFFFF4B9C);
  static const Color accentPinkContainer = Color(0xFFFFE0EE);
  static const Color accentYellow = Color(0xFFFFC800);
  static const Color accentYellowContainer = Color(0xFFFFEFB8);
  static const Color accentOrange = Color(0xFFFF9600);
  static const Color accentOrangeContainer = Color(0xFFFFEACC);

  // Surfaces
  static const Color background = Color(0xFFFAF9F6);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F0);
  static const Color surfaceContainer = Color(0xFFEBEAE4);
  static const Color outline = Color(0xFFD1D0C9);
  static const Color outlineVariant = Color(0xFFE5E4DE);

  // Text
  static const Color textPrimary = Color(0xFF2B2B2B);
  static const Color textSecondary = Color(0xFF777777);
  static const Color textTertiary = Color(0xFFAFAFAF);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnDark = Color(0xFFF8F9FA);

  // Semantic
  static const Color success = Color(0xFF58CC02);
  static const Color successContainer = Color(0xFFE6F9D1);
  static const Color warning = Color(0xFFFFC800);
  static const Color warningContainer = Color(0xFFFFEFB8);
  static const Color error = Color(0xFFFF4B4B);
  static const Color errorContainer = Color(0xFFFFE0E0);
  static const Color info = Color(0xFF1CB0F6);
  static const Color infoContainer = Color(0xFFD6F0FF);

  // Level colors - colorful
  static const Color levelA1 = Color(0xFF58CC02);
  static const Color levelA2 = Color(0xFF7CE033);
  static const Color levelB1 = Color(0xFFFFC800);
  static const Color levelB2 = Color(0xFFFF9600);
  static const Color levelC1 = Color(0xFFFF4B4B);

  // Card accent colors
  static const List<Color> cardAccents = [
    Color(0xFF58CC02),
    Color(0xFF1CB0F6),
    Color(0xFF8C52FF),
    Color(0xFFFF6B4A),
    Color(0xFFFF4B9C),
    Color(0xFFFFC800),
  ];

  // Fun gradients for decorative elements
  static const List<Color> primaryGradient = [
    Color(0xFF58CC02),
    Color(0xFF46A302),
  ];
  static const List<Color> sunsetGradient = [
    Color(0xFFFF6B4A),
    Color(0xFFFF9600),
  ];
  static const List<Color> oceanGradient = [
    Color(0xFF1CB0F6),
    Color(0xFF0D7EB5),
  ];
  static const List<Color> purpleGradient = [
    Color(0xFF8C52FF),
    Color(0xFF6B3FD1),
  ];

  // Background gradients
  static const List<Color> surfaceGradient = [
    Color(0xFFFAF9F6),
    Color(0xFFF5F5F0),
  ];

  // Shadows - softer and more playful
  static List<BoxShadow> get shadowSm => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get shadowMd => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get shadowLg => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> get shadowColorful => [
        BoxShadow(
          color: primary.withValues(alpha: 0.25),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];
}

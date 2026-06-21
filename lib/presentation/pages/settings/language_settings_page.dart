import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final currentCode = context.watch<LocaleCubit>().state.languageCode;
    final langCodes = ['ar', 'en', 'es', 'fr', 'pt', 'ru', 'hi', 'zh'];
    final selectedIndex = langCodes.indexOf(currentCode).clamp(0, langCodes.length - 1);

    final languages = [
      _LangData('🇸🇦', t.settingsArabic, 'Arabic'),
      _LangData('🇬🇧', 'English', 'English'),
      _LangData('🇪🇸', 'Español', 'Spanish'),
      _LangData('🇫🇷', 'Français', 'French'),
      _LangData('🇧🇷', 'Português', 'Portuguese'),
      _LangData('🇷🇺', 'Русский', 'Russian'),
      _LangData('🇮🇳', 'हिन्दी', 'Hindi'),
      _LangData('🇨🇳', '中文', 'Chinese'),
    ];

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  children: [
                    AppBackButton(),
                    const Spacer(),
                    Text(
                      t.langSettingsTitle,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                  children: [
                    Text(
                      t.langSettingsChoose,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    ...languages.asMap().entries.map(
                      (entry) => _LangTile(
                        lang: entry.value,
                        isSelected: selectedIndex == entry.key,
                        onTap: () => context
                            .read<LocaleCubit>()
                            .setLanguageCode(langCodes[entry.key]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LangData {
  final String flag;
  final String nativeName;
  final String englishName;
  const _LangData(this.flag, this.nativeName, this.englishName);
}

class _LangTile extends StatelessWidget {
  final _LangData lang;
  final bool isSelected;
  final VoidCallback onTap;

  const _LangTile({
    required this.lang,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryContainer : AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.outline.withValues(alpha: 0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md + 2,
            ),
            child: Row(
              children: [
                Text(lang.flag, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.nativeName,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        lang.englishName,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/constants/level_constants.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class LanguageLevelPage extends StatefulWidget {
  const LanguageLevelPage({super.key});

  @override
  State<LanguageLevelPage> createState() => _LanguageLevelPageState();
}

class _LanguageLevelPageState extends State<LanguageLevelPage> {
  LanguageLevel? _selectedLevel;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.surfaceGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: AppBackButton(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(t.levelTitle, style: AppTypography.displayMedium),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      t.levelSubtitle,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  itemCount: LanguageLevel.values.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final level = LanguageLevel.values[index];
                    final isSelected = _selectedLevel == level;
                    final color = _levelColor(level);

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOutCubic,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() => _selectedLevel = level);
                          },
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusLg,
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOutCubic,
                            padding: const EdgeInsets.all(AppSpacing.xxl),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? color.withValues(alpha: 0.08)
                                  : AppColors.surface,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusLg,
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? color
                                    : AppColors.outlineVariant,
                                width: isSelected ? 2 : 1,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.15),
                                        blurRadius: 16,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : AppColors.shadowSm,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 56,
                                  height: 56,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        color,
                                        color.withValues(alpha: 0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusMd,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      level.shortLabel,
                                      style: AppTypography.titleMedium.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.lg),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        level.label,
                                        style: AppTypography.titleMedium
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        t.levelDescription(
                                          level.name.toUpperCase(),
                                        ),
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withValues(alpha: 0.4),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xxl,
                  AppSpacing.lg,
                  AppSpacing.xxl,
                  AppSpacing.xl4,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      boxShadow: _selectedLevel != null
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : null,
                    ),
                    child: FilledButton(
                      onPressed: _selectedLevel != null
                          ? () async {
                              await sl<UserLocalDataSource>()
                                  .saveOnboardingLevel(_selectedLevel!.name);
                              if (context.mounted) {
                                context.go('/onboarding/interests');
                              }
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: _selectedLevel != null
                            ? AppColors.primary
                            : AppColors.outline.withValues(alpha: 0.5),
                        disabledBackgroundColor: AppColors.outline.withValues(
                          alpha: 0.3,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            t.levelContinue,
                            style: AppTypography.titleMedium.copyWith(
                              color: _selectedLevel != null
                                  ? Colors.white
                                  : AppColors.textTertiary,
                            ),
                          ),
                          if (_selectedLevel != null) ...[
                            const SizedBox(width: AppSpacing.sm),
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.arrow_back_ios_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _levelColor(LanguageLevel level) {
    switch (level) {
      case LanguageLevel.a1:
        return AppColors.levelA1;
      case LanguageLevel.a2:
        return AppColors.levelA2;
      case LanguageLevel.b1:
        return AppColors.levelB1;
      case LanguageLevel.b2:
        return AppColors.levelB2;
      case LanguageLevel.c1:
        return AppColors.levelC1;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/data/datasources/local/user_local_datasource.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({super.key});

  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage>
    with SingleTickerProviderStateMixin {
  final Set<String> _selectedInterests = {};

  late AnimationController _animController;

  List<_InterestData> _buildInterests(AppLocalizations t) => [
    _InterestData(
      'general',
      t.interestGeneral,
      Icons.public_rounded,
      AppColors.primary,
    ),
    _InterestData(
      'sports',
      t.interestSports,
      Icons.sports_soccer_rounded,
      AppColors.levelA1,
    ),
    _InterestData(
      'technology',
      t.interestTechnology,
      Icons.computer_rounded,
      AppColors.tertiary,
    ),
    _InterestData(
      'business',
      t.interestBusiness,
      Icons.trending_up_rounded,
      AppColors.accentYellow,
    ),
    _InterestData(
      'science',
      t.interestScience,
      Icons.science_rounded,
      AppColors.accentBlue,
    ),
    _InterestData(
      'entertainment',
      t.interestEntertainment,
      Icons.movie_rounded,
      AppColors.accentPink,
    ),
    _InterestData(
      'health',
      t.interestHealth,
      Icons.favorite_rounded,
      AppColors.secondary,
    ),
    _InterestData(
      'world',
      t.interestWorld,
      Icons.language_rounded,
      AppColors.levelB1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

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
                    Text(t.interestTitle, style: AppTypography.displayMedium),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      t.interestSubtitle,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                        ),
                    itemCount: _buildInterests(t).length,
                    itemBuilder: (context, index) {
                      final interest = _buildInterests(t)[index];
                      final isSelected = _selectedInterests.contains(
                        interest.key,
                      );

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOutCubic,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedInterests.remove(interest.key);
                                } else {
                                  _selectedInterests.add(interest.key);
                                }
                              });
                            },
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusLg,
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOutCubic,
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(
                                        colors: [
                                          interest.color,
                                          interest.color.withValues(
                                            alpha: 0.85,
                                          ),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                color: isSelected ? null : AppColors.surface,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusLg,
                                ),
                                border: Border.all(
                                  color: isSelected
                                      ? interest.color
                                      : AppColors.outlineVariant,
                                  width: isSelected ? 0 : 1,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: interest.color.withValues(
                                            alpha: 0.3,
                                          ),
                                          blurRadius: 16,
                                          offset: const Offset(0, 6),
                                        ),
                                      ]
                                    : AppColors.shadowSm,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    interest.icon,
                                    size: 40,
                                    color: isSelected
                                        ? Colors.white
                                        : interest.color,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    interest.label,
                                    style: AppTypography.titleSmall.copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.textPrimary,
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
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xxl,
                  AppSpacing.xs,
                  AppSpacing.xxl,
                  AppSpacing.xl4,
                ),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      child: Text(
                        _selectedInterests.isNotEmpty
                            ? t.interestSelected.replaceAll(
                                '{n}',
                                '${_selectedInterests.length}',
                              )
                            : t.interestMin,
                        style: AppTypography.bodySmall.copyWith(
                          color: _selectedInterests.isNotEmpty
                              ? AppColors.primary
                              : AppColors.textTertiary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                          boxShadow: _selectedInterests.isNotEmpty
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ]
                              : null,
                        ),
                        child: FilledButton(
                          onPressed: _selectedInterests.isNotEmpty
                              ? () async {
                                  await sl<UserLocalDataSource>()
                                      .saveOnboardingInterests(
                                        _selectedInterests.toList(),
                                      );
                                  if (context.mounted) {
                                    context.go('/onboarding/signup');
                                  }
                                }
                              : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: _selectedInterests.isNotEmpty
                                ? AppColors.primary
                                : AppColors.outline.withValues(alpha: 0.5),
                            disabledBackgroundColor: AppColors.outline
                                .withValues(alpha: 0.3),
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
                                t.interestNext,
                                style: AppTypography.titleMedium.copyWith(
                                  color: _selectedInterests.isNotEmpty
                                      ? Colors.white
                                      : AppColors.textTertiary,
                                ),
                              ),
                              if (_selectedInterests.isNotEmpty) ...[
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

class _InterestData {
  final String key;
  final String label;
  final IconData icon;
  final Color color;

  const _InterestData(this.key, this.label, this.icon, this.color);
}

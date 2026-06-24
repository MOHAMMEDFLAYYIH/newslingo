import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProgressCubit>()..loadProgress(),
      child: const _AchievementsBody(),
    );
  }
}

class _AchievementsBody extends StatefulWidget {
  const _AchievementsBody();

  @override
  State<_AchievementsBody> createState() => _AchievementsBodyState();
}

class _AchievementsBodyState extends State<_AchievementsBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
        color: AppColors.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xs,
                  ),
                  child: Row(
                    children: [
                      AppBackButton(),
                      const Spacer(),
                      Text(
                        t.achievementsTitle,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) {
                    if (state.status == ProgressStatus.loading) {
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.xl4),
                        child: CircularProgressIndicator(),
                      );
                    }
                    final achievements = _computeAchievements(
                      state.progress,
                      t,
                    );
                    final unlocked = achievements
                        .where((a) => a.unlocked)
                        .length;
                    return Column(
                      children: [
                        _ProgressHeader(
                          unlocked: unlocked,
                          total: achievements.length,
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                          ),
                          child: Wrap(
                            spacing: AppSpacing.md,
                            runSpacing: AppSpacing.md,
                            children: achievements.asMap().entries.map((entry) {
                              final i = entry.key;
                              final achievement = entry.value;
                              return SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width -
                                        AppSpacing.xl * 2 -
                                        AppSpacing.md) /
                                    2,
                                child: FadeTransition(
                                  opacity: CurvedAnimation(
                                    parent: _animController,
                                    curve: Interval(
                                      (i / achievements.length) * 0.5,
                                      1.0,
                                      curve: Curves.easeOut,
                                    ),
                                  ),
                                  child: _AchievementCard(
                                    achievement: achievement,
                                    index: i,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xl4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_Achievement> _computeAchievements(UserProgress p, AppLocalizations t) {
    final today = DateTime.now();
    final dateStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final emojis = [
      '🏆',
      '🔥',
      '📝',
      '✅',
      '🦉',
      '👑',
      '💎',
      '📰',
      '🎯',
      '🌟',
      '🎓',
      '⚡',
      '🎪',
      '🔁',
      '🗣️',
      '📚',
      '🏅',
      '🎊',
      '🤝',
      '💪',
    ];
    return List.generate(20, (i) {
      final unlocked = switch (i) {
        0 => p.articlesRead >= 1,
        1 => p.streak >= 7,
        2 => p.wordsLearned >= 50,
        3 => p.quizzesPassed >= 10,
        4 => p.wordsLearned >= 100,
        5 => p.streak >= 30,
        6 => p.wordsLearned >= 50,
        7 => p.articlesRead >= 50,
        8 => p.articlesRead >= 1,
        9 => p.streak >= 7,
        10 => p.quizzesPassed >= 20,
        11 => p.streak >= 5,
        12 => p.articlesRead >= 100,
        13 => p.streak >= 365,
        14 => p.wordsLearned >= 500,
        15 => p.wordsLearned >= 5,
        16 => p.streak >= 30,
        17 => p.wordsLearned >= 500,
        18 => p.articlesRead >= 30,
        19 => p.quizzesPassed >= 100,
        _ => false,
      };
      return _Achievement(
        emojis[i],
        t.achievementTitle(i),
        t.achievementDesc(i),
        unlocked,
        unlocked ? dateStr : null,
      );
    });
  }
}

class _Achievement {
  final String emoji;
  final String title;
  final String description;
  final bool unlocked;
  final String? date;
  const _Achievement(
    this.emoji,
    this.title,
    this.description,
    this.unlocked,
    this.date,
  );
}

class _ProgressHeader extends StatelessWidget {
  final int unlocked;
  final int total;
  const _ProgressHeader({required this.unlocked, required this.total});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final progress = total > 0 ? unlocked / total : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.tertiary, AppColors.tertiaryLight],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.tertiary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('🎖️', style: TextStyle(fontSize: 36)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$unlocked / $total',
                      style: AppTypography.headlineMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      t.achievementsUnlockedLabel,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.white.withValues(alpha: 0.25),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final _Achievement achievement;
  final int index;
  const _AchievementCard({required this.achievement, required this.index});

  @override
  Widget build(BuildContext context) {
    final accentColors = [
      AppColors.primary,
      AppColors.accentBlue,
      AppColors.tertiary,
      AppColors.secondary,
      AppColors.accentPink,
      AppColors.accentYellow,
    ];
    final color = accentColors[index % accentColors.length];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: achievement.unlocked
              ? color.withValues(alpha: 0.3)
              : AppColors.outline.withValues(alpha: 0.3),
        ),
        boxShadow: achievement.unlocked
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : AppColors.shadowSm,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: achievement.unlocked
                    ? LinearGradient(
                        colors: [color, color.withValues(alpha: 0.75)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: achievement.unlocked ? null : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: achievement.unlocked
                    ? null
                    : Border.all(
                        color: AppColors.outline.withValues(alpha: 0.3),
                      ),
              ),
              child: Center(
                child: Text(
                  achievement.emoji,
                  style: TextStyle(
                    fontSize: achievement.unlocked ? 28 : 24,
                    color: achievement.unlocked ? null : AppColors.textTertiary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              achievement.title,
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
                color: achievement.unlocked
                    ? AppColors.textPrimary
                    : AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              achievement.unlocked && achievement.date != null
                  ? '🟢 ${achievement.date}'
                  : achievement.description,
              style: AppTypography.bodySmall.copyWith(
                color: achievement.unlocked
                    ? AppColors.primary
                    : AppColors.textTertiary,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/responsive/responsive_config.dart';
import 'package:newslingo/core/responsive/responsive_typography.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';
import 'package:newslingo/presentation/widgets/bento/bento_container.dart';
import 'package:newslingo/presentation/widgets/bento/bento_grid_view.dart';
import 'package:newslingo/presentation/widgets/bento/bento_section.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProgressCubit>()..loadProgress(),
      child: _DashboardBody(),
    );
  }
}

class _DashboardBody extends StatelessWidget {
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
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.xs.w),
                  child: Row(
                    children: [
                      AppBackButton(),
                      const Spacer(),
                      Text(
                        t.dashboardTitle,
                        style: ResponsiveTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 48.w),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.sm.h),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) {
                    if (state.status == ProgressStatus.loading) {
                      return _shimmerHeader();
                    }
                    return _LevelHeader(progress: state.progress);
                  },
                ),
                SizedBox(height: AppSpacing.xl.h),
                BentoSection(
                  title: t.dashboardStats,
                  spacing: AppSpacing.md,
                  children: [
                    BlocBuilder<ProgressCubit, ProgressState>(
                      builder: (context, state) {
                        if (state.status == ProgressStatus.loading) {
                          return _shimmerGrid();
                        }
                        return _StatsGrid(progress: state.progress);
                      },
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.lg.h),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) => BentoSection(
                    title: t.dashboardWeekly,
                    children: [
                      BentoContainer.card(
                        child: _WeeklyChart(
                          values: <double>[],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg.h),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) => BentoSection(
                    title: t.dashboardToday,
                    children: [
                      BentoContainer.card(
                        child: _TodaysActivity(
                          lastActiveDate: state.progress.lastActiveDate,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.lg.h),
                BentoSection(
                  title: t.dashboardComparison,
                  children: [BentoContainer.card(child: _WeeklyComparison())],
                ),
                SizedBox(height: AppSpacing.lg.h),
                BentoSection(
                  title: t.dashboardLevelProgress,
                  children: [BentoContainer.card(child: _LevelProgress())],
                ),
                SizedBox(height: AppSpacing.lg.h),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) => BentoSection(
                    title: t.dashboardLearningTime,
                    children: [
                      BentoContainer.card(
                        child: _TimeSpent(
                          articlesRead: state.progress.articlesRead,
                          quizzesPassed: state.progress.quizzesPassed,
                          wordsLearned: state.progress.wordsLearned,
                          streak: state.progress.streak,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSpacing.xl4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _shimmerHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
      child: BentoContainer.card(
        height: 100.h,
        child: Center(
          child: Text('🦉', style: TextStyle(fontSize: 36.sp)),
        ),
      ),
    );
  }

  Widget _shimmerGrid() {
    return BentoGridView(
      delegate: const BentoGridDelegate(
        crossAxisCount: _statsCrossAxis,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: List.generate(
        4,
        (_) => BentoContainer.card(
          height: 100.h,
          child: Center(
            child: Text('⬜', style: TextStyle(fontSize: 28.sp)),
          ),
        ),
      ),
    );
  }
}

class _LevelHeader extends StatelessWidget {
  final UserProgress progress;
  const _LevelHeader({required this.progress});

  int _levelPoints() {
    return progress.articlesRead * 10 +
        progress.wordsLearned * 5 +
        progress.quizzesPassed * 20;
  }

  double _levelProgress() {
    final total = _levelPoints();
    final next = _pointsToNextLevel();
    if (next <= 0) return 1.0;
    return (total % 2000) / 2000;
  }

  int _pointsToNextLevel() {
    final total = _levelPoints();
    final next = 2000 - (total % 2000);
    return next;
  }

  String _computeLevelKey() {
    final total = _levelPoints();
    if (total >= 10000) return 'C2';
    if (total >= 6000) return 'C1';
    if (total >= 3000) return 'B2';
    if (total >= 1000) return 'B1';
    if (total >= 400) return 'A2';
    return 'A1';
  }

  String _levelEmoji(String key) {
    switch (key) {
      case 'C2':
        return '💎';
      case 'C1':
        return '🏆';
      case 'B2':
        return '🌟';
      case 'B1':
        return '📚';
      case 'A2':
        return '🌱';
      default:
        return '🪴';
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final levelKey = _computeLevelKey();
    final emoji = _levelEmoji(levelKey);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.xl.w),
      child: BentoContainer.gradient(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        child: Row(
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
              ),
              child: Center(
                child: Text(emoji, style: TextStyle(fontSize: 36.sp)),
              ),
            ),
            SizedBox(width: AppSpacing.lg.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.levelLabel(levelKey),
                    style: ResponsiveTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    t.points(_levelPoints()),
                    style: ResponsiveTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: _levelProgress(),
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                      minHeight: 8.h,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  final UserProgress progress;
  const _StatsGrid({required this.progress});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final stats = [
      {'emoji': '🔥', 'value': '${progress.streak}', 'label': t.streakDays},
      {
        'emoji': '📰',
        'value': '${progress.articlesRead}',
        'label': t.articlesRead,
      },
      {
        'emoji': '📝',
        'value': '${progress.wordsLearned}',
        'label': t.wordsSaved,
      },
      {
        'emoji': '✅',
        'value': '${progress.quizzesPassed}',
        'label': t.quizzesPassed,
      },
    ];
    return BentoGridView(
      delegate: const BentoGridDelegate(
        crossAxisCount: _statsCrossAxis,
        mainAxisSpacing: AppSpacing.sm,
        crossAxisSpacing: AppSpacing.sm,
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: stats
          .map(
            (s) => BentoContainer.card(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      s['emoji'] as String,
                      style: TextStyle(fontSize: 28.sp),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      s['value'] as String,
                      style: ResponsiveTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      s['label'] as String,
                      style: ResponsiveTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _WeeklyChart extends StatelessWidget {
  final List<double> values;
  const _WeeklyChart({this.values = const []});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final days = t.weekDaysAbbr;
    final chartValues = values.length == 7
        ? values
        : <double>[];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.hourLabel,
          style: ResponsiveTypography.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppSpacing.lg.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (i) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 32.w,
                  height: 100.h * chartValues[i],
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(
                      alpha: 0.3 + chartValues[i] * 0.5,
                    ),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm.r),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  days[i],
                  style: ResponsiveTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _TodaysActivity extends StatelessWidget {
  final DateTime lastActiveDate;
  const _TodaysActivity({required this.lastActiveDate});

  bool get _isToday {
    final now = DateTime.now();
    return lastActiveDate.year == now.year &&
        lastActiveDate.month == now.month &&
        lastActiveDate.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final isToday = _isToday;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ActivityRow(
          emoji: '📖',
          label: t.activityReadArticle,
          detail: t.activityReadDetail,
          done: isToday,
        ),
        SizedBox(height: AppSpacing.sm.h),
        _ActivityRow(
          emoji: '📝',
          label: t.activityQuiz,
          detail: t.activityQuizDetail,
          done: isToday,
        ),
        SizedBox(height: AppSpacing.sm.h),
        _ActivityRow(
          emoji: '🔄',
          label: t.activityFlashcards,
          detail: t.activityFlashcardDetail,
          done: isToday,
        ),
        SizedBox(height: AppSpacing.sm.h),
        _ActivityRow(
          emoji: '🎤',
          label: t.activityPronunciation,
          detail: t.activityPronunciationDetail,
          done: isToday,
        ),
      ],
    );
  }
}

class _ActivityRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String detail;
  final bool done;
  const _ActivityRow({
    required this.emoji,
    required this.label,
    required this.detail,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: done ? AppColors.successContainer : AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm.r),
          ),
          child: Center(
            child: Text(emoji, style: TextStyle(fontSize: 18.sp)),
          ),
        ),
        SizedBox(width: AppSpacing.md.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: ResponsiveTypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration: done ? TextDecoration.lineThrough : null,
                  color: done ? AppColors.textSecondary : AppColors.textPrimary,
                ),
              ),
              Text(
                detail,
                style: ResponsiveTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        if (done)
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20.w,
          ),
      ],
    );
  }
}

class _WeeklyComparison extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.thisWeek,
                style: ResponsiveTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '-',
                style: ResponsiveTypography.displayMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                t.hour,
                style: ResponsiveTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Container(width: 1, height: 48.h, color: AppColors.outlineVariant),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                t.lastWeek,
                style: ResponsiveTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                '-',
                style: ResponsiveTypography.displayMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                t.hour,
                style: ResponsiveTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LevelProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressCubit, ProgressState>(
      builder: (context, state) {
        final t = AppLocalizations.of(context);
        final total =
            state.progress.articlesRead * 10 +
            state.progress.wordsLearned * 5 +
            state.progress.quizzesPassed * 20;
        final levelPoints = total % 2000;
        final remaining = 2000 - levelPoints;
        final currentLevel = 'B${(total ~/ 2000) + 1}';
        final nextLevel = 'B${(total ~/ 2000) + 2}';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '$currentLevel → $nextLevel',
                    style: ResponsiveTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: AppSpacing.sm.w),
                Text(
                  '$levelPoints / 2,000',
                  style: ResponsiveTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.sm.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: LinearProgressIndicator(
                value: levelPoints / 2000,
                backgroundColor: AppColors.primaryContainer,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
                minHeight: 10.h,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              t.remainingPoints(remaining),
              style: ResponsiveTypography.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TimeSpent extends StatelessWidget {
  final int articlesRead;
  final int quizzesPassed;
  final int wordsLearned;
  final int streak;
  const _TimeSpent({
    required this.articlesRead,
    required this.quizzesPassed,
    required this.wordsLearned,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _TimeStat(
          emoji: '📅',
          value: '$articlesRead',
          unit: t.articlesRead,
          label: t.thisWeek,
        ),
        _TimeStat(
          emoji: '📊',
          value: '$quizzesPassed',
          unit: t.quizzesPassed,
          label: t.thisMonth,
        ),
        _TimeStat(
          emoji: '🏆',
          value: '$wordsLearned',
          unit: t.wordsSaved,
          label: t.total,
        ),
      ],
    );
  }
}

class _TimeStat extends StatelessWidget {
  final String emoji;
  final String value;
  final String unit;
  final String label;
  const _TimeStat({
    required this.emoji,
    required this.value,
    required this.unit,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: TextStyle(fontSize: 24.sp)),
        SizedBox(height: 4.h),
        Text(
          value,
          style: ResponsiveTypography.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          unit,
          style: ResponsiveTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: ResponsiveTypography.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

int _statsCrossAxis(ScreenType type) {
  return switch (type) {
    ScreenType.mobile => 2,
    ScreenType.tablet => 4,
    ScreenType.desktop => 4,
  };
}

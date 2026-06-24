import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class StreakPage extends StatelessWidget {
  const StreakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProgressCubit>()..loadProgress(),
      child: const _StreakBody(),
    );
  }
}

class _StreakBody extends StatelessWidget {
  const _StreakBody();

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
                        t.streakTitle,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                BlocBuilder<ProgressCubit, ProgressState>(
                  builder: (context, state) {
                    if (state.status == ProgressStatus.loading) {
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.xl4),
                        child: CircularProgressIndicator(),
                      );
                    }
                    final streak = state.progress.streak;
                    if (streak == 0) return _ZeroStreak();
                    return _StreakContent(
                      streak: streak,
                      progress: state.progress,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ZeroStreak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.xl7,
      ),
      child: Column(
        children: [
          const Text('😴', style: TextStyle(fontSize: 80)),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            t.streakStart,
            style: AppTypography.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.streakPrompt,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl4),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: FilledButton(
                onPressed: () => context.go('/home'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  t.streakReadNow,
                  style: AppTypography.titleMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakContent extends StatelessWidget {
  final int streak;
  final dynamic progress;
  const _StreakContent({required this.streak, required this.progress});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final nextMilestone = () {
      if (streak >= 100) return null;
      if (streak >= 60) return '💎 ${t.streakMilestone(100)}';
      if (streak >= 30) return '👑 ${t.streakMilestone(60)}';
      if (streak >= 14) return '🏆 ${t.streakMilestone(30)}';
      if (streak >= 7) return '🎯 ${t.streakMilestone(14)}';
      return '🎯 ${t.streakMilestone(7)}';
    }();

    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
            border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
            boxShadow: AppColors.shadowMd,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 48)),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    '$streak',
                    style: AppTypography.displayLarge.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.secondary,
                      fontSize: 57,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                t.consecutiveDaysLabel,
                style: AppTypography.titleMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    t.streakBest,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  Text(
                    t.streakDaysCount(streak),
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.accentYellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Text(
            t.streakMessage(streak),
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (nextMilestone != null) ...[
          const SizedBox(height: AppSpacing.sm),
          Text(
            t.streakNextMilestone(nextMilestone),
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: AppSpacing.sm,
                  bottom: AppSpacing.md,
                ),
                child: Text(
                  t.streakLast30,
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _CalendarGrid(streak: streak),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.streakUpcoming,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _MilestoneRow(
                milestones: [
                  _Milestone(
                    days: 7,
                    emoji: '🎯',
                    label: t.streakMilestone(7),
                    achieved: streak >= 7,
                  ),
                  _Milestone(
                    days: 14,
                    emoji: '🎯',
                    label: t.streakMilestone(14),
                    achieved: streak >= 14,
                  ),
                  _Milestone(
                    days: 30,
                    emoji: '🏆',
                    label: t.streakMilestone(30),
                    achieved: streak >= 30,
                  ),
                  _Milestone(
                    days: 60,
                    emoji: '👑',
                    label: t.streakMilestone(60),
                    achieved: streak >= 60,
                  ),
                  _Milestone(
                    days: 100,
                    emoji: '💎',
                    label: t.streakMilestone(100),
                    achieved: streak >= 100,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl4),
      ],
    );
  }
}

class _Milestone {
  final int days;
  final String emoji;
  final String label;
  final bool achieved;
  const _Milestone({
    required this.days,
    required this.emoji,
    required this.label,
    required this.achieved,
  });
}

class _MilestoneRow extends StatelessWidget {
  final List<_Milestone> milestones;
  const _MilestoneRow({required this.milestones});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: milestones.map((m) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: m.achieved
                        ? const LinearGradient(
                            colors: [Color(0xFFFFC800), Color(0xFFFF9600)],
                          )
                        : null,
                    color: m.achieved ? null : AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: m.achieved
                        ? null
                        : Border.all(
                            color: AppColors.outline.withValues(alpha: 0.3),
                          ),
                  ),
                  child: Center(
                    child: Text(
                      m.emoji,
                      style: TextStyle(
                        fontSize: m.achieved ? 26 : 22,
                        color: m.achieved ? null : AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  m.label,
                  style: AppTypography.labelSmall.copyWith(
                    color: m.achieved
                        ? AppColors.accentOrange
                        : AppColors.textTertiary,
                    fontWeight: m.achieved ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final int streak;
  const _CalendarGrid({required this.streak});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = List.generate(
      30,
      (i) => today.subtract(Duration(days: 29 - i)),
    );

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isToday =
              day.day == today.day &&
              day.month == today.month &&
              day.year == today.year;
          final isActive = index >= (30 - streak) && index < 30;
          final dayNumber = day.day.toString();

          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isActive
                  ? (isToday
                        ? const LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryLight],
                          )
                        : null)
                  : null,
              color: isActive
                  ? (isToday ? null : AppColors.primaryContainer)
                  : AppColors.surfaceVariant,
              border: isToday
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
              boxShadow: isToday
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Text(
                dayNumber,
                style: AppTypography.labelSmall.copyWith(
                  color: isActive
                      ? (isToday ? Colors.white : AppColors.primary)
                      : AppColors.textTertiary,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 11,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class QuizResultsPage extends StatelessWidget {
  const QuizResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
    final correct = extra?['correct'] as int? ?? 0;
    final wrong = extra?['wrong'] as int? ?? 0;
    final total = extra?['total'] as int? ?? 5;
    final timeTaken = extra?['timeTaken'] as int? ?? 0;
    final questions = extra?['questions'] as List<dynamic>? ?? [];
    final selectedAnswers = extra?['selectedAnswers'] as List<dynamic>? ?? [];

    final score = total > 0 ? (correct / total * 100).round() : 0;
    final isAchievement = score >= 80;

    final minutes = timeTaken ~/ 60;
    final seconds = timeTaken % 60;
    final timeStr = t.resultsTimeFormat(minutes, seconds);

    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xs, AppSpacing.sm, AppSpacing.xl, AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 24),
                      onPressed: () => context.go('/home'),
                    ),
                    const Spacer(),
                    const Text('📊', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      t.resultsTitle,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 160, height: 160,
                            child: CircularProgressIndicator(
                              value: correct / total,
                              strokeWidth: 12,
                              backgroundColor: AppColors.surfaceVariant,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                score >= 80
                                    ? AppColors.success
                                    : score >= 50
                                        ? AppColors.warning
                                        : AppColors.error,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$score%',
                                style: AppTypography.displayMedium.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: score >= 80
                                      ? AppColors.success
                                      : score >= 50
                                          ? AppColors.warning
                                          : AppColors.error,
                                ),
                              ),
                              Text(
                                score >= 80 ? t.resultsExcellent : score >= 50 ? t.resultsGood : t.resultsTryAgain,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isAchievement) ...[
                      const SizedBox(height: AppSpacing.lg),
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFFC800), Color(0xFFFF9600)],
                          ),
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Row(
                          children: [
                            const Text('🏆', style: TextStyle(fontSize: 32)),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.resultsNewAchievement,
                                    style: AppTypography.titleSmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    t.resultsAchievementDesc,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      children: [
                        _StatCard(
                          emoji: '✅',
                          value: '$correct',
                          label: t.resultsCorrect,
                          color: AppColors.success,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _StatCard(
                          emoji: '❌',
                          value: '$wrong',
                          label: t.resultsWrong,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _StatCard(
                          emoji: '⏱️',
                          value: timeStr,
                          label: t.resultsTime,
                          color: AppColors.accentBlue,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      t.resultsDetails,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...questions.asMap().entries.map((entry) {
                      final i = entry.key;
                      final q = entry.value;
                      final selected = i < selectedAnswers.length
                          ? selectedAnswers[i] as int
                          : -1;
                      final isCorrect = selected == q.correctIndex;
                      return Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          border: Border.all(
                            color: isCorrect
                                ? AppColors.success.withValues(alpha: 0.3)
                                : AppColors.error.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 32, height: 32,
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? AppColors.successContainer
                                    : AppColors.errorContainer,
                                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                              ),
                              child: Center(
                                child: Text(
                                  isCorrect ? '✅' : '❌',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.resultsQuestionNum(i + 1),
                                    style: AppTypography.labelSmall.copyWith(
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    q.question,
                                    style: AppTypography.bodyMedium.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (!isCorrect) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      t.resultsAnswer(q.options[q.correctIndex]),
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.success,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () => context.pop(),
                            icon: const Text('🔄', style: TextStyle(fontSize: 18)),
                            label: Text(
                              t.quizTryAgain,
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.textOnPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => context.go('/home'),
                            icon: const Text('📰', style: TextStyle(fontSize: 18)),
                            label: Text(
                              t.resultsBackToArticle,
                              style: AppTypography.labelLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textSecondary,
                              side: BorderSide(color: AppColors.outline.withValues(alpha: 0.5)),
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => context.go('/vocabulary'),
                            icon: const Text('📖', style: TextStyle(fontSize: 18)),
                            label: Text(
                              t.resultsReviewWords,
                              style: AppTypography.labelLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.tertiary,
                              side: BorderSide(color: AppColors.tertiary.withValues(alpha: 0.4)),
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Text('📤', style: TextStyle(fontSize: 16)),
                        label: Text(
                          t.resultsShare,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textTertiary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl5),
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

class _StatCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;
  const _StatCard({
    required this.emoji,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg, horizontal: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: AppSpacing.sm),
            Text(
              value,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

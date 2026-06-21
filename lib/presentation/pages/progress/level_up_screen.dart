import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class LevelUpScreen extends StatefulWidget {
  const LevelUpScreen({super.key});

  @override
  State<LevelUpScreen> createState() => _LevelUpScreenState();
}

class _LevelUpScreenState extends State<LevelUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _celebrationController;
  late Animation<double> _badgeScale;
  late Animation<double> _contentFade;

  final _emojiRain = ['🎉', '🎊', '⭐', '🌟', '✨', '💫', '🏆', '🎯'];
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _celebrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _badgeScale = CurvedAnimation(
      parent: _celebrationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
    );
    _contentFade = CurvedAnimation(
      parent: _celebrationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    );
    _celebrationController.forward();
  }

  @override
  void dispose() {
    _celebrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B5E1A),
              Color(0xFF58CC02),
              Color(0xFF7CE033),
              Color(0xFFFAF9F6),
              Color(0xFFFAF9F6),
            ],
            stops: [0.0, 0.2, 0.35, 0.55, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              _EmojiRain(emojiList: _emojiRain, random: _random),
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: _badgeScale,
                builder: (context, _) {
                  return Transform.scale(
                    scale: _badgeScale.value,
                    child: _NewLevelBadge(t: t),
                  );
                },
              ),
              const Spacer(flex: 1),
              AnimatedBuilder(
                animation: _contentFade,
                builder: (context, _) {
                  return Opacity(
                    opacity: _contentFade.value,
                    child: Expanded(
                      flex: 6,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                        children: [
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            t.levelUpCongrats,
                            style: AppTypography.headlineLarge.copyWith(
                              fontWeight: FontWeight.w900,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            t.levelUpMessage('B2'),
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppSpacing.xxl),
                          _ComparisonCard(t: t),
                          const SizedBox(height: AppSpacing.lg),
                          _UnlockList(t: t),
                          const SizedBox(height: AppSpacing.xxl),
                          _StatsRow(t: t),
                          const SizedBox(height: AppSpacing.xxl),
                          FilledButton.icon(
                            onPressed: () => context.go('/home'),
                            icon: const Icon(Icons.arrow_back_rounded, size: 20),
                            label: Text(
                              t.levelUpContinue,
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
                          const SizedBox(height: AppSpacing.xl4),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmojiRain extends StatelessWidget {
  final List<String> emojiList;
  final Random random;

  const _EmojiRain({required this.emojiList, required this.random});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        children: List.generate(12, (i) {
          final left = random.nextDouble() * 100;
          final emoji = emojiList[i % emojiList.length];
          return Positioned(
            left: left * MediaQuery.of(context).size.width / 100,
            top: random.nextDouble() * 40,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1 + random.nextInt(2)),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, -(1 - value) * 40),
                    child: Text(emoji, style: TextStyle(fontSize: 20 + random.nextDouble() * 12)),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}

class _NewLevelBadge extends StatelessWidget {
  final AppLocalizations t;
  const _NewLevelBadge({required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFC800), Color(0xFFFF9600)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentYellow.withValues(alpha: 0.4),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'B2',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -1,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                    width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text('👑', style: TextStyle(fontSize: 16))),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          child: Text(
            t.levelName('B2'),
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.levelB2,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _ComparisonCard extends StatelessWidget {
  final AppLocalizations t;
  const _ComparisonCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
        boxShadow: AppColors.shadowSm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'B1',
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.levelB1,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  t.levelName('B1'),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: const Center(child: Text('➡️', style: TextStyle(fontSize: 16))),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  'B2',
                  style: AppTypography.headlineLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.levelB2,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  t.levelName('B2'),
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnlockList extends StatelessWidget {
  final AppLocalizations t;
  const _UnlockList({required this.t});

  @override
  Widget build(BuildContext context) {
    final features = [
      _FeatureData('📰', t.levelUpFeature1Title, t.levelUpFeature1Sub),
      _FeatureData('📝', t.levelUpFeature2Title, t.levelUpFeature2Sub),
      _FeatureData('🎯', t.levelUpFeature3Title, t.levelUpFeature3Sub),
      _FeatureData('💬', t.levelUpFeature4Title, t.levelUpFeature4Sub),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
        boxShadow: AppColors.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🔓', style: TextStyle(fontSize: 18)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                t.levelUpFeatures,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Center(child: Text(f.emoji, style: const TextStyle(fontSize: 18))),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        f.title,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        f.subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _FeatureData {
  final String emoji;
  final String title;
  final String subtitle;
  const _FeatureData(this.emoji, this.title, this.subtitle);
}

class _StatsRow extends StatelessWidget {
  final AppLocalizations t;
  const _StatsRow({required this.t});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatItem('📖', '1,250', t.levelUpWordLearned),
      _StatItem('📰', '48', t.levelUpArticleRead),
      _StatItem('✅', '24', t.levelUpQuizPassed),
      _StatItem('🔥', '15', t.levelUpStreakDays),
    ];

    return Row(
      children: stats.map((s) => Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(color: AppColors.outline.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              Text(s.emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                s.value,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
              Text(
                s.label,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textTertiary,
                  fontSize: 9,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }
}

class _StatItem {
  final String emoji;
  final String value;
  final String label;
  const _StatItem(this.emoji, this.value, this.label);
}

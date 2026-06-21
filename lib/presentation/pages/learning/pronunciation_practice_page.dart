import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class PronunciationPracticePage extends StatefulWidget {
  final String word;

  const PronunciationPracticePage({super.key, required this.word});

  @override
  State<PronunciationPracticePage> createState() => _PronunciationPracticePageState();
}

class _PronunciationPracticePageState extends State<PronunciationPracticePage>
    with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  bool _showResult = false;
  double _accuracy = 0;
  String _resultLabel = '';
  Color _resultColor = AppColors.success;
  String _resultEmoji = '';

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _showResult = false;
    });
    _pulseController.repeat(reverse: true);
  }

  void _stopRecording() {
    _pulseController.stop();
    _pulseController.reset();

    // TODO: Replace with actual speech recognition API
    setState(() {
      _isRecording = false;
      _showResult = true;
      _accuracy = 0;
      _resultLabel = AppLocalizations.of(context).pronunciationAnalyzing;
      _resultColor = AppColors.warning;
      _resultEmoji = '🟡';
    });
  }

  void _tryAgain() {
    setState(() {
      _showResult = false;
      _accuracy = 0;
    });
  }

  String _getTip(AppLocalizations t, double accuracy) {
    if (accuracy >= 80) return t.pronunciationExcellent;
    if (accuracy >= 50) return t.pronunciationGood;
    return t.pronunciationKeepTrying;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
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
                      onPressed: () => context.pop(),
                    ),
                    const Spacer(),
                    const Text('🎤', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      t.pronunciationTitle,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text(
                        '🎤',
                        style: AppTypography.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    Center(
                      child:                       Text(
                        t.pronunciationHint,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxxl, vertical: AppSpacing.xl,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                          border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
                          boxShadow: AppColors.shadowMd,
                        ),
                        child: Text(
                          widget.word,
                          style: AppTypography.displayMedium.copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColors.textPrimary,
                            letterSpacing: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl5),
                    Center(
                      child: GestureDetector(
                        onTap: _toggleRecording,
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, _) {
                            final pulseScale = _isRecording
                                ? 1.0 + _pulseAnimation.value * 0.15
                                : 1.0;
                            final pulseOpacity = _isRecording
                                ? 0.3 - _pulseAnimation.value * 0.2
                                : 0.0;
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                if (_isRecording)
                                  Transform.scale(
                                    scale: pulseScale * 1.6,
                                    child: Container(
                                      width: 120, height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.error.withValues(alpha: pulseOpacity),
                                      ),
                                    ),
                                  ),
                                if (_isRecording)
                                  Transform.scale(
                                    scale: pulseScale * 1.3,
                                    child: Container(
                                      width: 120, height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.error.withValues(alpha: pulseOpacity * 0.7),
                                      ),
                                    ),
                                  ),
                                Container(
                                  width: 120, height: 120,
                                  decoration: BoxDecoration(
                                    color: _isRecording ? AppColors.error : AppColors.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: (_isRecording ? AppColors.error : AppColors.primary)
                                            .withValues(alpha: 0.35),
                                        blurRadius: 20,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: _isRecording
                                        ? Container(
                                            width: 40, height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                          )
                                        : const Text(
                                            '🎤',
                                            style: TextStyle(fontSize: 48),
                                          ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Center(
                      child: Text(
                        _isRecording ? t.pronunciationStop : t.pronunciationRecord,
                        style: AppTypography.bodyMedium.copyWith(
                          color: _isRecording ? AppColors.error : AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (_showResult) ...[
                      const SizedBox(height: AppSpacing.xxxl),
                      _ResultCard(
                        emoji: _resultEmoji,
                        label: _resultLabel,
                        accuracy: _accuracy,
                        color: _resultColor,
                        tip: _getTip(t, _accuracy),
                        onTryAgain: _tryAgain,
                        onNext: () => context.pop(),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xl4),
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

class _ResultCard extends StatelessWidget {
  final String emoji;
  final String label;
  final double accuracy;
  final Color color;
  final String tip;
  final VoidCallback onTryAgain;
  final VoidCallback onNext;

  const _ResultCard({
    required this.emoji,
    required this.label,
    required this.accuracy,
    required this.color,
    required this.tip,
    required this.onTryAgain,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        boxShadow: AppColors.shadowSm,
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: accuracy / 100,
              minHeight: 14,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '${accuracy.round()}%',
            style: AppTypography.titleLarge.copyWith(
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Row(
              children: [
                const Text('💡', style: TextStyle(fontSize: 18)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    tip,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTryAgain,
                  icon: const Text('🔄', style: TextStyle(fontSize: 18)),
                  label: Text(
                    t.pronunciationTryAgain,
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
                child: FilledButton.icon(
                  onPressed: onNext,
                  icon: const Text('⬅️', style: TextStyle(fontSize: 18)),
                  label: Text(
                    t.pronunciationNext,
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
        ],
      ),
    );
  }
}

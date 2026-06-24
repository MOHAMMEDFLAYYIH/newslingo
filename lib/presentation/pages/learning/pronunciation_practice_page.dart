import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/services/tts_service.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class PronunciationPracticePage extends StatefulWidget {
  final String word;

  const PronunciationPracticePage({super.key, required this.word});

  @override
  State<PronunciationPracticePage> createState() =>
      _PronunciationPracticePageState();
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
  final _speech = stt.SpeechToText();
  final _tts = sl<TtsService>();
  bool _speechAvailable = false;
  String _recognizedWords = '';

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
    _initSpeech();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _speech.stop();
    super.dispose();
  }

  Future<void> _initSpeech() async {
    _speechAvailable = await _speech.initialize();
    if (mounted) setState(() {});
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    if (!_speechAvailable) return;
    setState(() {
      _isRecording = true;
      _showResult = false;
      _recognizedWords = '';
    });
    _pulseController.repeat(reverse: true);
    _speech.listen(
      onResult: (result) {
        _recognizedWords = result.recognizedWords;
      },
      listenOptions: stt.SpeechListenOptions(
        localeId: 'en_US',
        listenFor: const Duration(seconds: 5),
      ),
    );
  }

  void _stopRecording() {
    _pulseController.stop();
    _pulseController.reset();
    _speech.stop();

    final t = AppLocalizations.of(context);
    final spoken = _recognizedWords.trim().toLowerCase();
    final expected = widget.word.toLowerCase();

    double accuracy;
    String label;
    Color color;
    String emoji;

    if (spoken.isEmpty) {
      accuracy = 0;
      label = t.pronunciationNoSpeech;
      color = AppColors.warning;
      emoji = '🟡';
    } else {
      final levenshtein = _levenshteinDistance(spoken, expected);
      final maxLen = expected.length > spoken.length
          ? expected.length
          : spoken.length;
      accuracy = maxLen > 0 ? ((maxLen - levenshtein) / maxLen) * 100 : 0;
      if (accuracy > 100) accuracy = 100;

      if (accuracy >= 80) {
        label = t.pronunciationExcellent;
        color = AppColors.success;
        emoji = '🟢';
      } else if (accuracy >= 50) {
        label = t.pronunciationGood;
        color = AppColors.tertiary;
        emoji = '🔵';
      } else {
        label = t.pronunciationKeepTrying;
        color = AppColors.warning;
        emoji = '🟡';
      }
    }

    setState(() {
      _isRecording = false;
      _showResult = true;
      _accuracy = accuracy;
      _resultLabel = label;
      _resultColor = color;
      _resultEmoji = emoji;
    });
  }

  int _levenshteinDistance(String a, String b) {
    final alen = a.length;
    final blen = b.length;
    final matrix = List.generate(alen + 1, (_) => List.filled(blen + 1, 0));

    for (var i = 0; i <= alen; i++) {
      matrix[i][0] = i;
    }
    for (var j = 0; j <= blen; j++) {
      matrix[0][j] = j;
    }

    for (var i = 1; i <= alen; i++) {
      for (var j = 1; j <= blen; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        matrix[i][j] = [
          matrix[i - 1][j] + 1,
          matrix[i][j - 1] + 1,
          matrix[i - 1][j - 1] + cost,
        ].reduce((min, v) => min < v ? min : v);
      }
    }
    return matrix[alen][blen];
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
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xs,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.sm,
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
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusFull,
                        ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    Center(
                      child: Text(
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
                          horizontal: AppSpacing.xxxl,
                          vertical: AppSpacing.xl,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusXl,
                          ),
                          border: Border.all(
                            color: AppColors.outline.withValues(alpha: 0.3),
                          ),
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
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: TextButton.icon(
                        onPressed: () => _tts.speak(widget.word),
                        icon: const Icon(Icons.volume_up_rounded, size: 20),
                        label: Text(
                          t.vocabListen,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
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
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.error.withValues(
                                          alpha: pulseOpacity,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_isRecording)
                                  Transform.scale(
                                    scale: pulseScale * 1.3,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.error.withValues(
                                          alpha: pulseOpacity * 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: _isRecording
                                        ? AppColors.error
                                        : AppColors.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            (_isRecording
                                                    ? AppColors.error
                                                    : AppColors.primary)
                                                .withValues(alpha: 0.35),
                                        blurRadius: 20,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: _isRecording
                                        ? Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
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
                        _isRecording
                            ? t.pronunciationStop
                            : t.pronunciationRecord,
                        style: AppTypography.bodyMedium.copyWith(
                          color: _isRecording
                              ? AppColors.error
                              : AppColors.textSecondary,
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
                    side: BorderSide(
                      color: AppColors.outline.withValues(alpha: 0.5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
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
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
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

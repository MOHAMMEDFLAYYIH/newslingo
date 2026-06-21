import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/manage_vocabulary.dart';

class FlashcardsPage extends StatefulWidget {
  const FlashcardsPage({super.key});

  @override
  State<FlashcardsPage> createState() => _FlashcardsPageState();
}

class _FlashcardsPageState extends State<FlashcardsPage> with TickerProviderStateMixin {
  List<SavedWord> _words = [];
  int _currentIndex = 0;
  bool _isFlipped = false;
  int _knownCount = 0;
  int _reviewCount = 0;
  bool _isCompleted = false;
  bool _isLoading = true;
  String? _errorMessage;

  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _loadWords();
  }

  Future<void> _loadWords() async {
    try {
      final words = await sl<ManageVocabulary>().getSavedWords();
      if (!mounted) return;
      setState(() {
        _words = words;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = AppLocalizations.of(context).flashcardError;
      });
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_flipController.isCompleted) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  void _swipeRight() {
    if (_isCompleted) return;
    _knownCount++;
    _nextCard();
  }

  void _swipeLeft() {
    if (_isCompleted) return;
    _reviewCount++;
    _nextCard();
  }

  void _nextCard() {
    if (_currentIndex >= _words.length - 1) {
      setState(() => _isCompleted = true);
      return;
    }
    setState(() {
      _currentIndex++;
      _isFlipped = false;
    });
    if (_flipController.isCompleted) {
      _flipController.reverse();
    }
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'A1': return AppColors.levelA1;
      case 'A2': return AppColors.levelA2;
      case 'B1': return AppColors.levelB1;
      case 'B2': return AppColors.levelB2;
      case 'C1': return AppColors.levelC1;
      default: return AppColors.levelB1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (_isLoading) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (_errorMessage != null || _words.isEmpty) {
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('📭', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      _errorMessage ?? t.flashcardEmpty,
                      style: AppTypography.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    FilledButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Text('📰', style: TextStyle(fontSize: 18)),
                      label: Text(t.flashcardBrowse),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    if (_isCompleted) {
      return _CompletionScreen(
        knownCount: _knownCount,
        reviewCount: _reviewCount,
      );
    }

    final word = _words[_currentIndex];
    final accentColor = _levelColor('B1');
    final progress = (_currentIndex) / _words.length;

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
                    Text(
                      t.flashcardTitle,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${_currentIndex + 1}/${_words.length}',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: AppColors.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                t.flashcardRemaining(_words.length - _currentIndex),
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: GestureDetector(
                  onTap: _flipCard,
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity != null) {
                      if (details.primaryVelocity! > 200) {
                        _swipeRight();
                      } else if (details.primaryVelocity! < -200) {
                        _swipeLeft();
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedBuilder(
                          animation: _flipAnimation,
                          builder: (context, child) {
                            final isFront = _flipAnimation.value < 0.5;
                            final angle = _flipAnimation.value * pi;
                            return Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(angle),
                              child: isFront
                                  ? _FrontCard(word: word, accentColor: accentColor)
                                  : Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.identity()..rotateY(pi),
                                      child: _BackCard(word: word, accentColor: accentColor),
                                    ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _SwipeButton(
                    emoji: '🔄',
                    label: t.flashcardNeedReview,
                    color: AppColors.secondary,
                    onTap: _swipeLeft,
                  ),
                  const SizedBox(width: AppSpacing.xxl),
                  _SwipeButton(
                    emoji: '✅',
                    label: t.flashcardKnown,
                    color: AppColors.primary,
                    onTap: _swipeRight,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _FrontCard extends StatelessWidget {
  final SavedWord word;
  final Color accentColor;
  const _FrontCard({required this.word, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64, height: 64,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            ),
            child: Center(
              child: Text(
                word.word[0].toUpperCase(),
                style: AppTypography.displayMedium.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            word.word,
            style: AppTypography.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👆', style: TextStyle(fontSize: 20)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                t.flashcardTapToFlip,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackCard extends StatelessWidget {
  final SavedWord word;
  final Color accentColor;
  const _BackCard({required this.word, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxxl),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
        border: Border.all(color: accentColor.withValues(alpha: 0.3), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(
              child: Text('🇸🇦', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            word.translation,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.center,
          ),
          if (word.definition.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Text(
                word.definition,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SwipeButton extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _SwipeButton({
    required this.emoji,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl, vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CompletionScreen extends StatelessWidget {
  final int knownCount;
  final int reviewCount;
  const _CompletionScreen({required this.knownCount, required this.reviewCount});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎉', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    t.flashcardWellDone,
                    style: AppTypography.displayMedium.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    t.flashcardComplete,
                    style: AppTypography.titleLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatBadge(
                        emoji: '✅',
                        count: knownCount.toString(),
                        label: t.flashcardKnown,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: AppSpacing.xl),
                      _StatBadge(
                        emoji: '🔄',
                        count: reviewCount.toString(),
                        label: t.flashcardForReview,
                        color: AppColors.secondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl5),
                  FilledButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Text('🏠', style: TextStyle(fontSize: 20)),
                    label: Text(
                      t.flashcardBackHome,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textOnPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xxxl,
                        vertical: AppSpacing.lg,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  TextButton.icon(
                    onPressed: () => context.go('/flashcards'),
                    icon: const Text('🔄', style: TextStyle(fontSize: 16)),
                    label: Text(
                      t.flashcardRestart,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String emoji;
  final String count;
  final String label;
  final Color color;
  const _StatBadge({
    required this.emoji,
    required this.count,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl, vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: AppSpacing.sm),
          Text(
            count,
            style: AppTypography.headlineMedium.copyWith(
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
    );
  }
}



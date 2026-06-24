import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/services/tts_service.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/cubit/word/word_cubit.dart';
import 'package:newslingo/presentation/cubit/word/word_state.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class VocabularyPage extends StatelessWidget {
  const VocabularyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<WordCubit>()..loadSavedWords(),
      child: const _VocabularyBody(),
    );
  }
}

class _VocabularyBody extends StatefulWidget {
  const _VocabularyBody();

  @override
  State<_VocabularyBody> createState() => _VocabularyBodyState();
}

class _VocabularyBodyState extends State<_VocabularyBody>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  String _searchQuery = '';
  final _searchController = TextEditingController();
  late AnimationController _staggerController;

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _staggerController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tabs = [t.vocabTodayTab, t.vocabMyWordsTab];
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(t),
              _buildSearchBar(t),
              const SizedBox(height: AppSpacing.lg),
              _buildTabBar(tabs),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: _selectedTab == 0
                    ? _buildDailyWords(t)
                    : _buildSavedWords(t),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      child: Row(
        children: [
          const Text('📖', style: TextStyle(fontSize: 28)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.vocabTitle,
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  t.vocabSubtitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          BlocBuilder<WordCubit, WordState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.warningContainer,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(
                      '${state.savedWords.length}',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.warning,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
          decoration: InputDecoration(
            hintText: t.searchHint,
            prefixIcon: const Icon(
              Icons.search_rounded,
              color: AppColors.textTertiary,
              size: 22,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.textTertiary,
                      size: 20,
                    ),
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md - 2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(List<String> tabs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final i = entry.key;
            final isSelected = _selectedTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = i;
                    _staggerController.reset();
                    _staggerController.forward();
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpacing.sm + 4,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.surface : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    boxShadow: isSelected ? AppColors.shadowSm : null,
                  ),
                  child: Text(
                    tabs[i],
                    style: AppTypography.labelMedium.copyWith(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textTertiary,
                      fontWeight: isSelected ? FontWeight.bold : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDailyWords(AppLocalizations t) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      children: [
        _buildProgressHeader(t),
      ],
    );
  }

  Widget _buildSavedWords(AppLocalizations t) {
    return BlocBuilder<WordCubit, WordState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('😕', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(
                    t.vocabError,
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton(
                    onPressed: () => context.read<WordCubit>().loadSavedWords(),
                    child: Text(t.vocabRetry),
                  ),
                ],
              ),
            ),
          );
        }
        final words = state.savedWords
            .where(
              (w) =>
                  _searchQuery.isEmpty ||
                  w.word.contains(_searchQuery) ||
                  w.translation.contains(_searchQuery),
            )
            .toList();
        if (words.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('📭', style: TextStyle(fontSize: 64)),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isEmpty ? t.vocabEmpty : t.vocabNoResults,
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _searchQuery.isEmpty ? t.vocabEmptyDetail : '',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          itemCount: words.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) return _buildProgressHeader(t);
            final i = index - 1;
            final w = words[i];
            return StaggeredFadeSlide(
              index: i,
              controller: _staggerController,
              child: Dismissible(
                key: ValueKey('saved_${w.word}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  padding: const EdgeInsetsDirectional.only(end: AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                confirmDismiss: (_) async {
                  context.read<WordCubit>().deleteWord(w.word);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.vocabDeleted),
                        action: SnackBarAction(
                          label: t.undo,
                          onPressed: () {
                            context.read<WordCubit>().addWord(w);
                          },
                        ),
                      ),
                    );
                  }
                  return false;
                },
                child: _InteractiveWordCard(
                  key: ValueKey('saved_${w.word}'),
                  word: w.word,
                  translation: w.translation,
                  level: w.reviewCount > 5 ? 'B2' : 'B1',
                  example: w.definition,
                  color: AppColors.primary,
                  reviewCount: w.reviewCount,
                  isBookmarked: true,
                  onTap: () => context.push('/vocabulary/${w.word}'),
                  onBookmark: () =>
                      context.read<WordCubit>().deleteWord(w.word),
                  onReview: () =>
                      context.read<WordCubit>().markReviewed(w.word),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildProgressHeader(AppLocalizations t) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        children: [
          BlocBuilder<WordCubit, WordState>(
            builder: (context, state) {
              return _ProgressBadge(
                emoji: '🔥',
                value: '${(state.dailyCount / 5).floor()}',
                label: t.vocabStreak,
                color: AppColors.accentOrange,
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
          BlocBuilder<WordCubit, WordState>(
            builder: (context, state) {
              return _ProgressBadge(
                emoji: '📚',
                value: '${state.dailyCount}',
                label: t.vocabTodayCount,
                color: AppColors.primary,
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
          BlocBuilder<WordCubit, WordState>(
            builder: (context, state) {
              return _ProgressBadge(
                emoji: '🎯',
                value: '${state.savedWords.length}',
                label: t.vocabTotal,
                color: AppColors.tertiary,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProgressBadge extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;
  const _ProgressBadge({
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
          vertical: AppSpacing.sm + 2,
          horizontal: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 2),
            Text(
              value,
              style: AppTypography.titleSmall.copyWith(
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textTertiary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StaggeredFadeSlide extends StatelessWidget {
  final int index;
  final AnimationController controller;
  final Widget child;
  const StaggeredFadeSlide({
    super.key,
    required this.index,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = index * 0.08;
    final anim = CurvedAnimation(
      parent: controller,
      curve: Interval(delay, min(1.0, delay + 0.3), curve: Curves.easeOutCubic),
    );
    return AnimatedBuilder(
      animation: anim,
      builder: (context, _) {
        return Opacity(
          opacity: anim.value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - anim.value)),
            child: child,
          ),
        );
      },
    );
  }
}

class _InteractiveWordCard extends StatefulWidget {
  final String word;
  final String translation;
  final String level;
  final String example;
  final Color color;
  final int reviewCount;
  final bool isBookmarked;
  final VoidCallback? onTap;
  final VoidCallback? onBookmark;
  final VoidCallback? onReview;

  const _InteractiveWordCard({
    super.key,
    required this.word,
    required this.translation,
    required this.level,
    required this.example,
    required this.color,
    this.reviewCount = 0,
    this.isBookmarked = false,
    this.onTap,
    this.onBookmark,
    this.onReview,
  });

  @override
  State<_InteractiveWordCard> createState() => _InteractiveWordCardState();
}

class _InteractiveWordCardState extends State<_InteractiveWordCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    });
  }

  final _tts = sl<TtsService>();

  void _speak() async {
    setState(() => _isSpeaking = true);
    await _tts.speak(widget.word);
    if (mounted) setState(() => _isSpeaking = _tts.isSpeaking);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: _toggleExpand,
          child: AnimatedBuilder(
            animation: _expandAnimation,
            builder: (context, _) {
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    _buildMainRow(),
                    SizeTransition(
                      sizeFactor: _expandAnimation,
                      axisAlignment: -1,
                      child: _buildExpandedDetails(context),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMainRow() {
    return Row(
      children: [
        _buildLevelIcon(),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.word,
                    style: AppTypography.titleSmall.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _buildLevelBadge(),
                  if (widget.reviewCount > 5) ...[
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 14,
                      color: AppColors.success,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                widget.translation,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        _buildAudioButton(),
        const SizedBox(width: AppSpacing.xs),
        _buildBookmarkButton(),
        const SizedBox(width: AppSpacing.xs),
        AnimatedRotation(
          turns: _isExpanded ? 0.5 : 0,
          duration: const Duration(milliseconds: 250),
          child: Icon(
            Icons.expand_more_rounded,
            color: AppColors.textTertiary,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildLevelIcon() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _isExpanded
            ? widget.color
            : widget.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _isExpanded
              ? const Icon(
                  Icons.check_rounded,
                  key: ValueKey('check'),
                  color: Colors.white,
                  size: 24,
                )
              : Text(
                  '📝',
                  key: const ValueKey('emoji'),
                  style: const TextStyle(fontSize: 20),
                ),
        ),
      ),
    );
  }

  Widget _buildLevelBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: widget.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        widget.level,
        style: AppTypography.labelSmall.copyWith(
          color: widget.color,
          fontWeight: FontWeight.w700,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildAudioButton() {
    return GestureDetector(
      onTap: _speak,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: _isSpeaking
              ? widget.color.withValues(alpha: 0.2)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: _isSpeaking
              ? Border.all(color: widget.color.withValues(alpha: 0.3))
              : null,
        ),
        child: AnimatedScale(
          scale: _isSpeaking ? 1.2 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Icon(
            _isSpeaking ? Icons.volume_up_rounded : Icons.volume_up_rounded,
            size: 18,
            color: _isSpeaking ? widget.color : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkButton() {
    return GestureDetector(
      onTap: widget.onBookmark,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: widget.isBookmarked
              ? AppColors.error.withValues(alpha: 0.1)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        ),
        child: Icon(
          widget.isBookmarked
              ? Icons.favorite_rounded
              : Icons.favorite_outline_rounded,
          size: 18,
          color: widget.isBookmarked ? AppColors.error : AppColors.textTertiary,
        ),
      ),
    );
  }

  Widget _buildExpandedDetails(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),
          const SizedBox(height: AppSpacing.md),
          Text(
            widget.example,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _ActionChip(
                icon: Icons.menu_book_rounded,
                label: t.vocabDetail,
                onTap: widget.onTap,
              ),
              const SizedBox(width: AppSpacing.sm),
              if (widget.onReview != null)
                _ActionChip(
                  icon: Icons.check_circle_outline_rounded,
                  label: t.vocabReviewed,
                  onTap: () {
                    widget.onReview!();
                    _toggleExpand();
                  },
                ),
              const Spacer(),
              if (widget.reviewCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    '${t.vocabReviewedCount} ${widget.reviewCount}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textTertiary,
                      fontSize: 10,
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

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _ActionChip({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


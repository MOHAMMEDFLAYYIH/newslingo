import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/responsive/responsive_config.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';
import 'package:newslingo/domain/usecases/get_article_details.dart';
import 'package:newslingo/presentation/pages/article/audio_player_widget.dart';
import 'package:newslingo/presentation/pages/article/word_definition_sheet.dart';
import 'package:newslingo/presentation/widgets/bento/adaptive_scaffold.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class ArticleDetailPage extends StatefulWidget {
  final String articleId;
  const ArticleDetailPage({super.key, required this.articleId});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  Article? _article;
  bool _isLoading = true;
  String? _error;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _loadArticle();
  }

  Future<void> _loadArticle() async {
    try {
      var article = await sl<GetArticleDetails>().call(widget.articleId);
      // Article stays in English regardless of UI locale
      if (mounted) {
        setState(() {
          _article = article;
          _isLoading = false;
        });
        sl<NewsRepository>().markArticleRead(widget.articleId);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  void _toggleBookmark() {
    setState(() => _isBookmarked = !_isBookmarked);
    if (_isBookmarked) {
      sl<NewsRepository>().bookmarkArticle(widget.articleId);
    } else {
      sl<NewsRepository>().unbookmarkArticle(widget.articleId);
    }
    final t = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? t.articleBookmarked : t.articleUnbookmarked,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Color _levelColor(String level) {
    switch (level) {
      case 'A1':
        return AppColors.levelA1;
      case 'A2':
        return AppColors.levelA2;
      case 'B1':
        return AppColors.levelB1;
      case 'B2':
        return AppColors.levelB2;
      case 'C1':
        return AppColors.levelC1;
      default:
        return AppColors.levelB1;
    }
  }

  String _categoryEmoji(String category) {
    switch (category) {
      case 'general':
        return '🌍';
      case 'sports':
        return '⚽';
      case 'technology':
        return '💻';
      case 'business':
        return '📈';
      case 'science':
        return '🔬';
      case 'entertainment':
        return '🎬';
      default:
        return '🌍';
    }
  }

  String _categoryLabel(String category) {
    final t = AppLocalizations.of(context);
    switch (category) {
      case 'general':
        return t.categoryGeneral;
      case 'sports':
        return t.categorySports;
      case 'technology':
        return t.categoryTechnology;
      case 'business':
        return t.categoryBusiness;
      case 'science':
        return t.categoryScience;
      case 'entertainment':
        return t.categoryEntertainment;
      default:
        return category;
    }
  }

  String _relativeTime(DateTime dt) {
    final t = AppLocalizations.of(context);
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return t.relativeTimeMinutes(diff.inMinutes);
    if (diff.inHours < 24) return t.relativeTimeHours(diff.inHours);
    if (diff.inDays < 7) return t.relativeTimeDays(diff.inDays);
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (_isLoading) {
      return AdaptiveScaffold(
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null || _article == null) {
      return AdaptiveScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('😕', style: TextStyle(fontSize: 64)),
              const SizedBox(height: AppSpacing.lg),
              Text(_error ?? t.articleNotFound),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: _loadArticle,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: Text(t.homeRetry),
              ),
            ],
          ),
        ),
      );
    }
    final article = _article!;
    final accentColor = AppColors.accentBlue;
    final isTablet = context.isTablet;
    return AdaptiveScaffold(
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(
              article: article,
              accentColor: accentColor,
              isBookmarked: _isBookmarked,
              onToggleBookmark: _toggleBookmark,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 48.w : AppSpacing.xl.w,
                ),
                children: [
                  const SizedBox(height: AppSpacing.xs),
                  _CategoryRow(
                    category: _categoryLabel(article.category),
                    level: article.level,
                    emoji: _categoryEmoji(article.category),
                    levelColor: _levelColor(article.level),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    article.translatedTitle ?? article.title,
                    style: AppTypography.headlineSmall.copyWith(
                      fontWeight: FontWeight.w800,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    children: [
                      const Text('📅', style: TextStyle(fontSize: 14)),
                      const SizedBox(width: 4),
                      Text(
                        _relativeTime(article.publishedAt),
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusXs,
                          ),
                        ),
                        child: Text(
                          t.articleListen,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    child: CachedNetworkImage(
                      imageUrl: article.imageUrl,
                      height: 200.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => Container(
                        height: 200.h,
                        color: AppColors.surfaceVariant,
                      ),
                      errorWidget: (_, _, _) => Container(
                        height: 200.h,
                        color: accentColor.withValues(alpha: 0.1),
                        child: const Center(
                          child: Text('🖼️', style: TextStyle(fontSize: 64)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _ArticleContent(
                    articleId: article.id,
                    accentColor: accentColor,
                    content: article.translatedContent ?? article.content,
                    level: article.level,
                    vocabulary: article.vocabulary,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
            _BottomActions(
              accentColor: accentColor,
              articleId: article.id,
              quiz: article.quiz,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Article article;
  final Color accentColor;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;
  const _AppBar({
    required this.article,
    required this.accentColor,
    this.isBookmarked = false,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xs,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppBackButton(iconSize: 22),
          const Spacer(),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: AppColors.outline.withValues(alpha: 0.5),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                onTap: onToggleBookmark,
                child: Center(
                  child: Text(
                    isBookmarked ? '🔖' : '🔖',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => AudioPlayerWidget(
                      audioUrl: article.audioUrl,
                      title: article.translatedTitle ?? article.title,
                    ),
                  );
                },
                child: const Center(
                  child: Text('🔊', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final String category;
  final String level;
  final String emoji;
  final Color levelColor;
  const _CategoryRow({
    required this.category,
    required this.level,
    required this.emoji,
    required this.levelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: AppSpacing.sm),
        Text(
          category,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: levelColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
          ),
          child: Text(
            level,
            style: AppTypography.labelSmall.copyWith(
              color: levelColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _ArticleContent extends StatefulWidget {
  final String articleId;
  final Color accentColor;
  final String content;
  final String level;
  final List<WordDefinition> vocabulary;
  const _ArticleContent({
    required this.articleId,
    required this.accentColor,
    required this.content,
    required this.level,
    required this.vocabulary,
  });

  @override
  State<_ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<_ArticleContent> {
  static const _levelLimits = {'A1': 2, 'A2': 3, 'B1': 5, 'B2': 8, 'C1': 999};

  late final Map<String, WordDefinition> _vocabularyCache;

  @override
  void initState() {
    super.initState();
    _buildVocabularyCache();
  }

  void _buildVocabularyCache() {
    _vocabularyCache = {};
    for (final def in widget.vocabulary) {
      _vocabularyCache[def.word.toLowerCase()] = def;
    }
  }

  bool get _isTruncated {
    final paragraphs = widget.content
        .split('\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    final limit = _levelLimits[widget.level] ?? 5;
    return paragraphs.length > limit;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final allParagraphs = widget.content
        .split('\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    final limit = _levelLimits[widget.level] ?? 5;
    final visible = allParagraphs.take(limit).toList();
    final hiddenCount = allParagraphs.length - visible.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...visible.map((p) => _buildParagraph(p)),
        if (_isTruncated) ...[
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: TextButton.icon(
              onPressed: () => _showFull(),
              icon: const Icon(Icons.expand_more_rounded, size: 20),
              label: Text(
                '${t.articleShowMore} (+$hiddenCount)',
                style: AppTypography.labelMedium.copyWith(
                  color: widget.accentColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _showFull() {
    final t = AppLocalizations.of(context);
    final allParagraphs = widget.content
        .split('\n')
        .where((p) => p.trim().isNotEmpty)
        .toList();
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.all(AppSpacing.lg),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${widget.level} — ${t.articleShowAll}',
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  children: allParagraphs
                      .map((p) => _buildParagraph(p))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    final regex = RegExp(r'<highlight>(.*?)</highlight>');
    final matches = regex.allMatches(text);
    if (matches.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Text(text, style: AppTypography.bodyLarge.copyWith(height: 1.8)),
      );
    }

    final spans = <InlineSpan>[];
    int lastEnd = 0;
    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: AppTypography.bodyLarge.copyWith(height: 1.8),
          ),
        );
      }
      final word = match.group(1)!;
      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: GestureDetector(
            onTap: () => _showWordDefinition(context, word),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
              decoration: BoxDecoration(
                color: AppColors.accentBlue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusXs.r),
              ),
              child: Text(
                word,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.accentBlue,
                  fontWeight: FontWeight.w600,
                  height: 1.8,
                ),
              ),
            ),
          ),
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: AppTypography.bodyLarge.copyWith(height: 1.8),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: RichText(text: TextSpan(children: spans)),
    );
  }

  void _showWordDefinition(BuildContext context, String word) {
    final cacheKey = word.toLowerCase();
    final cached = _vocabularyCache[cacheKey];

    if (cached != null) {
      // CACHE HIT — instant, zero latency
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => WordDefinitionSheet(
          word: cached.word,
          translation: cached.translation,
          definition: cached.definition,
          partOfSpeech: cached.partOfSpeech,
          examples: cached.examples,
          synonyms: cached.synonyms,
          accentColor: widget.accentColor,
          articleId: widget.articleId,
          level: widget.level,
        ),
      );
      return;
    }

    // CACHE MISS — shimmer + async fallback
    unawaited(_showWordSheetWithLoading(context, word));
  }

  Future<void> _showWordSheetWithLoading(
    BuildContext context,
    String word,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _LoadingWordSheet(
        word: word,
        articleId: widget.articleId,
        accentColor: widget.accentColor,
        level: widget.level,
      ),
    );
  }
}

class _LoadingWordSheet extends StatefulWidget {
  final String word;
  final String articleId;
  final Color accentColor;
  final String level;

  const _LoadingWordSheet({
    required this.word,
    required this.articleId,
    required this.accentColor,
    required this.level,
  });

  @override
  State<_LoadingWordSheet> createState() => _LoadingWordSheetState();
}

class _LoadingWordSheetState extends State<_LoadingWordSheet>
    with SingleTickerProviderStateMixin {
  WordDefinition? _def;
  bool _isLoading = true;
  bool _hasError = false;
  late AnimationController _shimmerCtrl;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _shimmerAnim = Tween<double>(begin: 0.3, end: 0.7).animate(_shimmerCtrl);
    _fetch();
  }

  Future<void> _fetch() async {
    try {
      final defs = await sl<NewsRepository>().getWordDefinitions(
        widget.articleId,
        widget.word,
      );
      if (!mounted) return;
      if (defs.isNotEmpty) {
        setState(() {
          _def = defs.first;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildShimmer();
    }
    if (_hasError || _def == null) {
      return WordDefinitionSheet(
        word: widget.word,
        translation: widget.word,
        definition: '',
        accentColor: widget.accentColor,
        articleId: widget.articleId,
      );
    }
    final d = _def!;
    return WordDefinitionSheet(
      word: d.word,
      translation: d.translation,
      definition: d.definition,
      partOfSpeech: d.partOfSpeech,
      examples: d.examples,
      synonyms: d.synonyms,
      accentColor: widget.accentColor,
      articleId: widget.articleId,
      level: widget.level,
    );
  }

  Widget _buildShimmer() {
    return AnimatedBuilder(
      animation: _shimmerAnim,
      builder: (context, child) {
        final opacity = _shimmerAnim.value;
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.radiusXxl),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: AppSpacing.md),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.outline.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  children: [
                    Opacity(
                      opacity: opacity,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Opacity(
                      opacity: opacity,
                      child: Container(
                        height: 18,
                        width: 200,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Opacity(
                      opacity: opacity,
                      child: Container(
                        height: 14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Opacity(
                      opacity: opacity,
                      child: Container(
                        height: 14,
                        width: 160,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Opacity(
                      opacity: opacity,
                      child: Container(
                        height: 14,
                        width: 240,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BottomActions extends StatelessWidget {
  final Color accentColor;
  final String articleId;
  final Quiz? quiz;
  const _BottomActions({
    required this.accentColor,
    required this.articleId,
    this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () {
                if (quiz == null || quiz!.questions.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.articleNoQuiz)),
                  );
                  return;
                }
                context.push('/quiz/$articleId', extra: quiz);
              },
              icon: const Text('📝', style: TextStyle(fontSize: 18)),
              label: Text(
                t.articleQuizButton,
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textOnPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: accentColor,
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                final t = AppLocalizations.of(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.vocabBookmarked),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Text('💾', style: TextStyle(fontSize: 18)),
              label: Text(
                t.articleSaveWords,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: accentColor,
                side: BorderSide(color: accentColor.withValues(alpha: 0.4)),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

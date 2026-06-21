import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
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
      final locale = sl<LocaleCubit>().state.languageCode;
      if (locale != 'en') {
        final translated = await sl<NewsRepository>().translateArticles([article], locale);
        article = translated.first;
      }
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
        content: Text(_isBookmarked ? t.articleBookmarked : t.articleUnbookmarked),
        duration: const Duration(seconds: 2),
      ),
    );
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

  String _categoryEmoji(String category) {
    switch (category) {
      case 'general': return '🌍';
      case 'sports': return '⚽';
      case 'technology': return '💻';
      case 'business': return '📈';
      case 'science': return '🔬';
      case 'entertainment': return '🎬';
      default: return '🌍';
    }
  }

  String _categoryLabel(String category) {
    final t = AppLocalizations.of(context);
    switch (category) {
      case 'general': return t.categoryGeneral;
      case 'sports': return t.categorySports;
      case 'technology': return t.categoryTechnology;
      case 'business': return t.categoryBusiness;
      case 'science': return t.categoryScience;
      case 'entertainment': return t.categoryEntertainment;
      default: return category;
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
                padding: EdgeInsets.symmetric(horizontal: isTablet ? 48.w : AppSpacing.xl.w),
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
                          horizontal: AppSpacing.sm, vertical: AppSpacing.xxs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
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
                    child: Container(
                      height: 200.h,
                      color: accentColor.withValues(alpha: 0.1),
                      child: const Center(
                        child: Text('🖼️', style: TextStyle(fontSize: 64)),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _ArticleContent(
                    articleId: article.id,
                    accentColor: accentColor,
                    content: article.translatedContent ?? article.content,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
            _BottomActions(accentColor: accentColor, articleId: article.id),
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
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs, AppSpacing.sm, AppSpacing.md, AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppBackButton(iconSize: 22),
          const Spacer(),
          Container(
            width: 40.w, height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                onTap: onToggleBookmark,
                child: Center(
                  child: Text(isBookmarked ? '🔖' : '🔖', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSpacing.sm.w),
          Container(
            width: 40.w, height: 40.w,
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
  const _ArticleContent({
    required this.articleId,
    required this.accentColor,
    required this.content,
  });

  @override
  State<_ArticleContent> createState() => _ArticleContentState();
}

class _ArticleContentState extends State<_ArticleContent> {
  @override
  Widget build(BuildContext context) {
    final paragraphs = widget.content.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.where((p) => p.trim().isNotEmpty).map((p) => _buildParagraph(p)).toList(),
    );
  }

  Widget _buildParagraph(String text) {
    final regex = RegExp(r'<highlight>(.*?)</highlight>');
    final matches = regex.allMatches(text);
    if (matches.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.lg),
        child: Text(
          text,
          style: AppTypography.bodyLarge.copyWith(height: 1.8),
        ),
      );
    }

    final spans = <InlineSpan>[];
    int lastEnd = 0;
    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: AppTypography.bodyLarge.copyWith(height: 1.8),
        ));
      }
      final word = match.group(1)!;
      spans.add(WidgetSpan(
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
      ));
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: AppTypography.bodyLarge.copyWith(height: 1.8),
      ));
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: RichText(
        text: TextSpan(children: spans),
      ),
    );
  }

  void _showWordDefinition(BuildContext context, String word) {
    final wordDefs = _extractDefinitions(widget.content);
    final entry = wordDefs[word];
    final translation = entry?.split(' - ').first ?? word;
    final defText = entry?.split(' - ').last ?? '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => WordDefinitionSheet(
        word: word,
        translation: translation,
        definition: defText,
        accentColor: AppColors.accentBlue,
        articleId: widget.articleId,
      ),
    );
  }

  Map<String, String> _extractDefinitions(String content) {
    const builtIn = {
      'sustainable': 'مستدام - Able to be maintained over time',
      'sustainably': 'بشكل مستدام - In a sustainable manner',
      'significant': 'مهم / كبير - Important or noticeable',
      'breakthrough': 'اختراق - A sudden important discovery',
      'comprehensive': 'شامل - Including everything needed',
      'widespread': 'واسع الانتشار - Existing over a large area',
      'despite': 'على الرغم من - Without being affected by',
      'implement': 'ينفذ / يطبق - Put into effect',
      'consequently': 'وبالتالي - As a result',
      'emerging': 'ناشئ - Newly developed or coming to attention',
      'secured': 'حصل على - Obtained with effort',
      'remarkable': 'رائع - Worthy of attention',
      'exceptional': 'استثنائي - Unusually good',
      'outstanding': 'ممتاز - Exceptionally good',
      'resilience': 'مرونة - Ability to recover quickly',
      'impressive': 'مثير للإعجاب - Evoking admiration',
      'inspired': 'ألهم - Motivated someone',
      'transforming': 'يحول - Making a marked change',
      'unimaginable': 'لا يمكن تصوره - Impossible to imagine',
      'intelligent': 'ذكي - Having intelligence',
      'accessible': 'متاح - Easy to approach or use',
      'effective': 'فعال - Successful in producing results',
      'embracing': 'يتبنى - Willingly accepting',
      'engaging': 'جذاب - Attracting attention',
      'potential': 'إمكانات - Latent qualities',
      'revolutionize': 'يحدث ثورة - Change fundamentally',
      'enormous': 'هائل - Very large in size',
      'unveiled': 'كشف النقاب - Removed a cover from',
      'groundbreaking': 'رائد - Innovative, pioneering',
      'incorporates': 'يدمج - Includes as a part',
      'sophisticated': 'متطور - Complex, advanced',
      'enhance': 'يعزز - Intensify or improve',
      'praised': 'أشاد - Expressed approval',
      'influence': 'يؤثر - Have an effect on',
      'reached': 'توصل إلى - Arrived at',
      'dramatically': 'بشكل كبير - By a large margin',
      'ambitious': 'طموح - Having a strong desire for success',
      'commits': 'يلتزم - Pledges to do something',
      'substantial': 'كبير - Of considerable importance',
      'crucial': 'حاسم - Decisive, critical',
      'welcomed': 'رحب - Greeted with pleasure',
      'emphasize': 'يؤكد - Stress the importance of',
      'immediate': 'فوري - Occurring at once',
      'implementation': 'تنفيذ - The process of putting into effect',
      'unprecedented': 'غير مسبوق - Never done before',
      'officially': 'رسمياً - In an official capacity',
      'showcases': 'يعرض - Displays prominently',
      'highlighting': 'يسلط الضوء - Draws attention to',
      'contemporary': 'معاصر - Modern, current',
      'includes': 'يتضمن - Contains as part of',
      'continues': 'يستمر - Keeps happening',
      'vital': 'حيوي - Absolutely necessary',
      'celebrating': 'يحتفل - Marks a special occasion',
      'developed': 'طور - Created over time',
      'promising': 'واعد - Showing potential for success',
      'innovative': 'مبتكر - Featuring new methods',
      'combines': 'يجمع - Joins together',
      'restore': 'يستعيد - Brings back to original state',
      'experiencing': 'يعاني / يختبر - Going through',
      'optimistic': 'متفائل - Hopeful about the future',
      'surged': 'ارتفع بشكل حاد - Increased suddenly',
      'increasingly': 'بشكل متزايد - More and more',
      'attribute': 'يعزو - Regards as caused by',
      'strong': 'قوي - Powerful',
      'favourable': 'موات - Advantageous',
      'momentum': 'زخم - Force gained by movement',
      'continue': 'يستمر - Persists',
    };
    return builtIn;
  }
}

class _BottomActions extends StatelessWidget {
  final Color accentColor;
  final String articleId;
  const _BottomActions({required this.accentColor, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.md,
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
              onPressed: () => context.push('/quiz/$articleId'),
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



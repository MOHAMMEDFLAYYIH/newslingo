import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/services/deepl_service.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class VocabularyDetailPage extends StatefulWidget {
  final String word;

  const VocabularyDetailPage({super.key, required this.word});

  @override
  State<VocabularyDetailPage> createState() => _VocabularyDetailPageState();
}

class _VocabularyDetailPageState extends State<VocabularyDetailPage> {
  _WordData? _data;
  bool _loading = true;
  String _targetLang = 'AR';
  bool _initialized = false;

  String get _targetLocaleLabel {
    switch (_targetLang) {
      case 'ES': return '🇪🇸 Español';
      case 'FR': return '🇫🇷 Français';
      case 'PT-PT': return '🇵🇹 Português';
      case 'RU': return '🇷🇺 Русский';
      case 'HI': return '🇮🇳 हिन्दी';
      case 'ZH': return '🇨🇳 中文';
      default: return '🇸🇦 العربية';
    }
  }

  @override
  void initState() {
    super.initState();
    _targetLang = 'AR';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _targetLang = DeepLService.targetCode(
        Localizations.localeOf(context).languageCode,
      );
      _loadWordData();
    }
  }

  Future<void> _loadWordData() async {
    final lower = widget.word.toLowerCase();
    final cached = _wordData[lower];
    if (cached != null) {
      if (_targetLang == 'AR') {
        setState(() { _data = cached; _loading = false; });
        return;
      }
    }

    final generated = _generateWordData(widget.word);

    if (_seedWordLevels.containsKey(lower) && _targetLang == 'AR') {
      setState(() { _data = generated; _loading = false; });
      return;
    }

    try {
      final service = sl<DeepLService>();
      if (service.isAvailable && _targetLang != 'AR') {
        final translation = await service.translate(
          widget.word,
          targetLang: _targetLang,
        );
        if (mounted) {
          setState(() {
            _data = _WordData(
              translation: translation,
              level: generated.level,
              partOfSpeech: generated.partOfSpeech,
              definitionEn: generated.definitionEn,
              definitionAr: generated.definitionAr,
              examples: generated.examples,
              synonyms: generated.synonyms,
              similar: generated.similar,
            );
            _loading = false;
          });
        }
      } else if (_targetLang == 'AR' && cached != null) {
        setState(() { _data = cached; _loading = false; });
      } else if (_targetLang == 'AR' && _seedWordLevels.containsKey(lower)) {
        setState(() { _data = generated; _loading = false; });
      } else {
        final translation = service.isAvailable
            ? await service.translate(widget.word, targetLang: _targetLang)
            : generated.translation;
        if (mounted) {
          setState(() {
            _data = _WordData(
              translation: translation,
              level: generated.level,
              partOfSpeech: generated.partOfSpeech,
              definitionEn: generated.definitionEn,
              definitionAr: generated.definitionAr,
              examples: generated.examples,
              synonyms: generated.synonyms,
              similar: generated.similar,
            );
            _loading = false;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() { _data = generated; _loading = false; });
      }
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
    if (_loading) {
      final t = AppLocalizations.of(context);
      return Scaffold(
        body: Container(
          color: AppColors.background,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.xs, AppSpacing.sm, AppSpacing.xl, AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      AppBackButton(iconSize: 22),
                      const Spacer(),
                      Text('📖', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        t.vocabDetailTitle,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 48),
                    ],
                  ),
                ),
                const Expanded(child: Center(child: CircularProgressIndicator())),
              ],
            ),
          ),
        ),
      );
    }

    final wordData = _data!;
    final level = wordData.level;
    final accentColor = _levelColor(level);
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
                    AppBackButton(iconSize: 22),
                    const Spacer(),
                    Text('📖', style: TextStyle(fontSize: 22)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      t.vocabDetailTitle,
                      style: AppTypography.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
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
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.2),
                        ),
                        boxShadow: AppColors.shadowMd,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80, height: 80,
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                            ),
                            child: Center(
                              child: Text(
                                widget.word[0].toUpperCase(),
                                style: AppTypography.displayMedium.copyWith(
                                  color: accentColor,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            widget.word,
                            style: AppTypography.displayMedium.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(
                            wordData.translation,
                            style: AppTypography.titleLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  level,
                                  style: AppTypography.labelMedium.copyWith(
                                    color: accentColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceVariant,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  wordData.partOfSpeech,
                                  style: AppTypography.labelMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                onTap: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('🔊', style: TextStyle(fontSize: 20)),
                                      const SizedBox(width: AppSpacing.sm),
                                      Text(
                                        t.vocabListen,
                                        style: AppTypography.labelLarge.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _InfoCard(
                            title: '🇬🇧 English',
                            content: wordData.definitionEn,
                            accentColor: accentColor,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: _InfoCard(
                          title: _targetLang == 'AR'
                              ? '🇸🇦 العربية'
                              : _targetLocaleLabel,
                          content: _targetLang == 'AR'
                              ? wordData.definitionAr
                              : wordData.translation,
                          accentColor: accentColor,
                        ),
                      ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      t.vocabExamples,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ...wordData.examples.map((ex) => Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(
                          color: AppColors.outline.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✨',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              ex,
                              style: AppTypography.bodyMedium.copyWith(
                                height: 1.6,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    if (wordData.synonyms.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        t.vocabSynonyms,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: wordData.synonyms.map((s) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg, vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: accentColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                            border: Border.all(
                              color: accentColor.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            s,
                            style: AppTypography.labelLarge.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      t.vocabSimilar,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: wordData.similar.length,
                        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (_, i) {
                          final similar = wordData.similar[i];
                          final similarColor = _levelColor(similar.level);
                          return GestureDetector(
                            onTap: () => context.push('/vocabulary/${similar.word}'),
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                                border: Border.all(
                                  color: AppColors.outline.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    similar.word,
                                    style: AppTypography.titleSmall.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    similar.translation,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: similarColor.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      similar.level,
                                      style: AppTypography.labelSmall.copyWith(
                                        color: similarColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {},
                            icon: const Text('📝', style: TextStyle(fontSize: 18)),
                              label: Text(
                                t.vocabReview,
                                style: AppTypography.labelLarge.copyWith(
                                  color: AppColors.textOnPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: accentColor,
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
                            onPressed: () {},
                            icon: const Text('📤', style: TextStyle(fontSize: 18)),
                              label: Text(
                                t.vocabShare,
                                style: AppTypography.labelLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: accentColor,
                              side: BorderSide(color: accentColor.withValues(alpha: 0.4)),
                              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final Color accentColor;
  const _InfoCard({
    required this.title,
    required this.content,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: accentColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.labelMedium.copyWith(
            color: AppColors.textTertiary,
          )),
          const SizedBox(height: AppSpacing.sm),
          Text(content, style: AppTypography.bodyMedium.copyWith(
            height: 1.5,
          )),
        ],
      ),
    );
  }
}

class _WordData {
  final String translation;
  final String level;
  final String partOfSpeech;
  final String definitionEn;
  final String definitionAr;
  final List<String> examples;
  final List<String> synonyms;
  final List<_SimilarWord> similar;

  const _WordData({
    required this.translation,
    required this.level,
    required this.partOfSpeech,
    required this.definitionEn,
    required this.definitionAr,
    required this.examples,
    required this.synonyms,
    required this.similar,
  });
}

class _SimilarWord {
  final String word;
  final String translation;
  final String level;
  const _SimilarWord(this.word, this.translation, this.level);
}

const _seedWordLevels = {
  'sustainable': 'B2', 'significant': 'B1', 'breakthrough': 'C1',
  'comprehensive': 'B2', 'widespread': 'B2', 'despite': 'B1',
  'implement': 'B1', 'consequently': 'B2', 'sustainably': 'B2',
  'emerging': 'B2', 'secured': 'B1', 'remarkable': 'B2',
  'exceptional': 'C1', 'outstanding': 'B2', 'resilience': 'C1',
  'impressive': 'B1', 'inspired': 'B1', 'transforming': 'B2',
  'unimaginable': 'C1', 'intelligent': 'B1', 'accessible': 'B1',
  'effective': 'B1', 'embracing': 'B2', 'engaging': 'B1',
  'potential': 'B1', 'revolutionize': 'C1', 'enormous': 'B2',
  'unveiled': 'B2', 'groundbreaking': 'C1', 'incorporates': 'B2',
  'sophisticated': 'C1', 'enhance': 'B1', 'praised': 'B1',
  'influence': 'B1', 'reached': 'B1', 'dramatically': 'B2',
  'ambitious': 'B2', 'commits': 'B2', 'substantial': 'B2',
  'crucial': 'B2', 'welcomed': 'B1', 'emphasize': 'B2',
  'immediate': 'A2', 'implementation': 'C1', 'unprecedented': 'C1',
  'officially': 'B1', 'showcases': 'B2', 'highlighting': 'B2',
  'contemporary': 'B2', 'includes': 'A2', 'continues': 'A2',
  'vital': 'B2', 'celebrating': 'B1', 'developed': 'B1',
  'promising': 'B1', 'significantly': 'B2', 'innovative': 'B2',
  'combines': 'B1', 'restore': 'B1', 'experiencing': 'B1',
  'optimistic': 'B2', 'surged': 'B2', 'increasingly': 'B2',
  'attribute': 'B2', 'strong': 'A2', 'favourable': 'B2',
  'momentum': 'C1', 'continue': 'A2',
};

_WordData _generateWordData(String word) {
  final lower = word.toLowerCase();
  final level = _seedWordLevels[lower] ?? 'B1';
  return _WordData(
    translation: 'ترجمة "$word"',
    level: level,
    partOfSpeech: 'word',
    definitionEn: 'Definition of "$word".',
    definitionAr: 'تعريف كلمة "$word".',
    examples: ['Example sentence using "$word".'],
    synonyms: <String>[],
    similar: <_SimilarWord>[],
  );
}

const _wordData = {
  'significant': _WordData(
    translation: 'مهم / كبير',
    level: 'B1',
    partOfSpeech: 'adjective',
    definitionEn: 'Sufficiently great or important to be worthy of attention.',
    definitionAr: 'كافٍ من حيث الأهمية أو القيمة ليستحق الاهتمام.',
    examples: [
      'The study showed significant results that changed our understanding.',
      'There has been a significant increase in sales this quarter.',
      'Her contribution to the project was truly significant.',
    ],
    synonyms: ['important', 'notable', 'remarkable', 'substantial', 'major'],
    similar: [
      _SimilarWord('substantial', 'كبير / جوهري', 'B2'),
      _SimilarWord('notable', 'ملحوظ', 'B1'),
      _SimilarWord('crucial', 'حاسم', 'B2'),
    ],
  ),
  'implement': _WordData(
    translation: 'ينفذ / يطبق',
    level: 'B1',
    partOfSpeech: 'verb',
    definitionEn: 'To put a decision, plan, or agreement into effect.',
    definitionAr: 'وضع قرار أو خطة أو اتفاق موضع التنفيذ.',
    examples: [
      'The company will implement the new policy next month.',
      'We need to implement changes to improve efficiency.',
      'They implemented a new system for tracking orders.',
    ],
    synonyms: ['execute', 'apply', 'enforce', 'carry out', 'realize'],
    similar: [
      _SimilarWord('execute', 'ينفذ', 'B2'),
      _SimilarWord('apply', 'يطبق', 'B1'),
      _SimilarWord('enforce', 'يفرض', 'C1'),
    ],
  ),
  'sustainable': _WordData(
    translation: 'مستدام',
    level: 'B1',
    partOfSpeech: 'adjective',
    definitionEn: 'Able to be maintained at a certain rate or level over time.',
    definitionAr: 'قادر على الاستمرار بمعدل أو مستوى معين مع مرور الوقت.',
    examples: [
      'We need sustainable energy sources for the future.',
      'The company focuses on sustainable business practices.',
      'Sustainable agriculture is essential for food security.',
    ],
    synonyms: ['renewable', 'maintainable', 'viable', 'green', 'eco-friendly'],
    similar: [
      _SimilarWord('renewable', 'متجدد', 'B2'),
      _SimilarWord('viable', 'قابل للحياة', 'C1'),
      _SimilarWord('eco-friendly', 'صديق للبيئة', 'B1'),
    ],
  ),
};

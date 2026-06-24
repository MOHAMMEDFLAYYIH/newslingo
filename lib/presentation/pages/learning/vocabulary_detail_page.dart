import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/services/deepl_service.dart';
import 'package:newslingo/core/services/dictionary_service.dart';
import 'package:newslingo/core/services/tts_service.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/usecases/manage_vocabulary.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class VocabularyDetailPage extends StatefulWidget {
  final String word;
  final String? savedTranslation;
  final String? savedDefinition;

  const VocabularyDetailPage({
    super.key,
    required this.word,
    this.savedTranslation,
    this.savedDefinition,
  });

  @override
  State<VocabularyDetailPage> createState() => _VocabularyDetailPageState();
}

class _VocabularyDetailPageState extends State<VocabularyDetailPage> {
  _WordData? _data;
  bool _loading = true;
  String _targetLang = 'AR';
  bool _initialized = false;

  static const Map<String, String> _localeToDeepL = {
    'ar': 'AR',
    'es': 'ES',
    'fr': 'FR',
    'pt': 'PT-PT',
    'ru': 'RU',
    'hi': 'HI',
    'zh': 'ZH',
  };

  String get _targetLocaleLabel {
    switch (_targetLang) {
      case 'ES': return '🇪🇸 Español';
      case 'FR': return '🇫🇷 Français';
      case 'PT-PT': return '🇵🇹 Português';
      case 'RU': return '🇷🇺 Русский';
      case 'HI': return '🇮🇳 हिन्दी';
      case 'ZH': return '🇨🇳 中文';
      default: return '🇦🇪 العربية';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final _tts = sl<TtsService>();
  bool _isSpeaking = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final locale = Localizations.localeOf(context).languageCode;
      _targetLang = _localeToDeepL[locale] ?? 'AR';
      _loadWordData();
    }
  }

  Future<void> _speakWord() async {
    setState(() => _isSpeaking = true);
    await _tts.speak(widget.word);
    if (mounted) setState(() => _isSpeaking = _tts.isSpeaking);
  }

  Future<void> _loadWordData() async {
    final savedTranslation = widget.savedTranslation ?? '';
    final savedDefinition = widget.savedDefinition ?? '';

    final dict = await DictionaryService.fetchDefinition(widget.word);

    if (!mounted) return;

    String partOfSpeech = '';
    String definitionEn = savedDefinition;
    final List<String> examples = [];
    final List<String> synonyms = [];

    if (dict != null) {
      if (dict.meanings.isNotEmpty) {
        partOfSpeech = dict.meanings.first.partOfSpeech;
        if (definitionEn.isEmpty) {
          definitionEn = dict.meanings
              .expand((m) => m.definitions)
              .map((d) => d.definition)
              .where((d) => d.isNotEmpty)
              .firstOrNull ?? '';
        }
        for (final meaning in dict.meanings) {
          for (final def in meaning.definitions) {
            if (def.example.isNotEmpty && examples.length < 3) {
              examples.add(def.example);
            }
          }
        }
      }
    }

    String translation;
    if (_targetLang == 'AR' && savedTranslation.isNotEmpty) {
      translation = savedTranslation;
    } else {
      try {
        final service = sl<DeepLService>();
        if (service.isAvailable && definitionEn.isNotEmpty) {
          translation = await service.translate(
            definitionEn,
            targetLang: _targetLang,
          );
        } else {
          translation = widget.word;
        }
      } catch (_) {
        translation = widget.word;
      }
    }

    if (!mounted) return;
    final isAr = _targetLang == 'AR';
    setState(() {
      _data = _WordData(
        translation: translation,
        level: 'B1',
        partOfSpeech: partOfSpeech,
        definitionEn: definitionEn,
        definitionAr: isAr ? translation : (savedTranslation.isNotEmpty ? savedTranslation : translation),
        examples: examples,
        synonyms: synonyms,
        similar: [],
      );
      _loading = false;
    });
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
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.xs,
                    AppSpacing.sm,
                    AppSpacing.xl,
                    AppSpacing.sm,
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
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXl,
                        ),
                        border: Border.all(
                          color: accentColor.withValues(alpha: 0.2),
                        ),
                        boxShadow: AppColors.shadowMd,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: accentColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusLg,
                              ),
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
                                  horizontal: 10,
                                  vertical: 3,
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
                                  horizontal: 10,
                                  vertical: 3,
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
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                                onTap: _speakWord,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _isSpeaking ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                                      color: AppColors.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: AppSpacing.sm),
                                    Text(
                                      _isSpeaking
                                          ? '${t.vocabListen}...'
                                          : t.vocabListen,
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
                            title: _targetLocaleLabel,
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
                    ...wordData.examples.map(
                      (ex) => Container(
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusMd,
                          ),
                          border: Border.all(
                            color: AppColors.outline.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('✨', style: TextStyle(fontSize: 16)),
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
                      ),
                    ),
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
                        children: wordData.synonyms
                            .map(
                              (s) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.lg,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusFull,
                                  ),
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
                              ),
                            )
                            .toList(),
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
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (_, i) {
                          final similar = wordData.similar[i];
                          final similarColor = _levelColor(similar.level);
                          return GestureDetector(
                            onTap: () =>
                                context.push('/vocabulary/${similar.word}'),
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                                border: Border.all(
                                  color: AppColors.outline.withValues(
                                    alpha: 0.3,
                                  ),
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
                                      horizontal: 4,
                                      vertical: 0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: similarColor.withValues(
                                        alpha: 0.12,
                                      ),
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
                            onPressed: () => _speakWord(),
                            icon: const Icon(
                              Icons.volume_up_rounded,
                              size: 18,
                            ),
                            label: Text(
                              t.vocabListen,
                              style: AppTypography.labelLarge.copyWith(
                                color: AppColors.textOnPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: accentColor,
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.lg,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              sl<ManageVocabulary>().saveWord(
                                SavedWord(
                                  word: widget.word,
                                  definition: wordData.definitionEn,
                                  translation: wordData.translation,
                                  articleId: '',
                                  savedAt: DateTime.now(),
                                  reviewCount: 0,
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(t.vocabBookmarked)),
                              );
                            },
                            icon: const Text(
                              '📚',
                              style: TextStyle(fontSize: 18),
                            ),
                            label: Text(
                              t.vocabBookmarked,
                              style: AppTypography.labelLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: accentColor,
                              side: BorderSide(
                                color: accentColor.withValues(alpha: 0.4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSpacing.lg,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSpacing.radiusMd,
                                ),
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
          Text(
            title,
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(content, style: AppTypography.bodyMedium.copyWith(height: 1.5)),
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



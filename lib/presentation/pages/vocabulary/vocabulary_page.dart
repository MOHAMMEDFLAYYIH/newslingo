import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
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

class _VocabularyBodyState extends State<_VocabularyBody> {
  int _selectedTab = 0;
  String _searchQuery = '';

  final _dailyWords = [
    _WordData('significant', 'مهم / كبير', 'A2', 'The study showed significant results', AppColors.accentBlue),
    _WordData('implement', 'ينفذ / يطبق', 'B1', 'They will implement the new system', AppColors.tertiary),
    _WordData('despite', 'على الرغم من', 'B1', 'Despite the rain, they continued', AppColors.accentPink),
    _WordData('emerging', 'ناشئ', 'B2', 'Emerging technologies are changing the world', AppColors.accentOrange),
    _WordData('sustainable', 'مستدام', 'B1', 'We need sustainable energy sources', AppColors.primary),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tabs = [t.vocabTodayTab, t.vocabMyWordsTab];
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.md,
                ),
                child: Row(
                  children: [
                    const Text('📖', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      t.vocabTitle,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<WordCubit, WordState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md, vertical: AppSpacing.sm,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
                  ),
                  child: TextField(
                    textDirection: TextDirection.rtl,
                    onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                    decoration: InputDecoration(
                      hintText: t.searchHint,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.md,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Padding(
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
                          onTap: () => setState(() => _selectedTab = i),
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
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: _selectedTab == 0
                    ? _buildDailyWords()
                    : _buildSavedWords(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyWords() {
    final words = _dailyWords.where((w) =>
        _searchQuery.isEmpty || w.word.contains(_searchQuery) || w.translation.contains(_searchQuery)).toList();
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      children: words.map((w) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: _WordCard(
          word: w.word,
          translation: w.translation,
          level: w.level,
          example: w.example,
          color: w.color,
          onTap: () => context.push('/vocabulary/${w.word}'),
        ),
      )).toList(),
    );
  }

  Widget _buildSavedWords() {
    final t = AppLocalizations.of(context);
    return BlocBuilder<WordCubit, WordState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.errorMessage != null) {
          return Center(
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
          );
        }
        final words = state.savedWords.where((w) =>
            _searchQuery.isEmpty || w.word.contains(_searchQuery) || w.translation.contains(_searchQuery)).toList();
        if (words.isEmpty) {
          return Center(
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
              ],
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          children: words.map((w) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _WordCard(
              word: w.word,
              translation: w.translation,
              level: w.reviewCount > 5 ? 'B2' : 'B1',
              example: w.definition,
              color: AppColors.primary,
              onTap: () => context.push('/vocabulary/${w.word}'),
            ),
          )).toList(),
        );
      },
    );
  }
}

class _WordData {
  final String word;
  final String translation;
  final String level;
  final String example;
  final Color color;
  const _WordData(this.word, this.translation, this.level, this.example, this.color);
}

class _WordCard extends StatelessWidget {
  final String word;
  final String translation;
  final String level;
  final String example;
  final Color color;
  final VoidCallback? onTap;

  const _WordCard({
    required this.word,
    required this.translation,
    required this.level,
    required this.example,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: const Center(
                    child: Text('📝', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            word,
                            style: AppTypography.titleSmall.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              level,
                              style: AppTypography.labelSmall.copyWith(
                                color: color,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        translation,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: const Icon(Icons.volume_up_rounded, size: 16, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

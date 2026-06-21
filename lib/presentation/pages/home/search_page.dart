import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/domain/repositories/news_repository.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  String _query = '';
  String? _selectedCategory;
  String? _selectedLevel;
  List<Article> _allArticles = [];
  List<Article> _results = [];
  final _recentSearches = <String>[];
  bool _isLoading = false;
  String? _errorMessage;
  final _categories = [
    _CategoryData('general', '🌍'),
    _CategoryData('sports', '⚽'),
    _CategoryData('technology', '💻'),
    _CategoryData('business', '📈'),
    _CategoryData('science', '🔬'),
    _CategoryData('entertainment', '🎬'),
  ];
  final _levels = ['A1', 'A2', 'B1', 'B2', 'C1'];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _searchController.addListener(() {
      setState(() => _query = _searchController.text.trim());
    });
    _loadArticles();
  }

  Future<void> _loadArticles() async {
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      final articles = await sl<NewsRepository>().getArticles();
      if (!mounted) return;
      setState(() { _allArticles = articles; _isLoading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() { _isLoading = false; _errorMessage = AppLocalizations.of(context).articleError; });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _removeRecent(String query) {
    setState(() => _recentSearches.remove(query));
  }

  void _search(String query) {
    final lower = query.toLowerCase();
    setState(() {
      if (!_recentSearches.contains(query)) {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 8) _recentSearches.removeLast();
      }
      _results = _allArticles.where((a) {
        final matchesQuery = a.title.toLowerCase().contains(lower) ||
            a.description.toLowerCase().contains(lower);
        final matchesCategory = _selectedCategory == null || a.category == _selectedCategory;
        final matchesLevel = _selectedLevel == null || a.level == _selectedLevel;
        return matchesQuery && matchesCategory && matchesLevel;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              _SearchBar(
                controller: _searchController,
                focusNode: _focusNode,
                onBack: () => context.pop(),
              ),
              if (_isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else if (_errorMessage != null)
                Expanded(child: _ErrorView(message: _errorMessage!, onRetry: _loadArticles))
              else if (_query.isEmpty)
                Expanded(child: _RecentSearches(
                  searches: _recentSearches,
                  onTap: _search,
                  onRemove: _removeRecent,
                ))
              else
                Expanded(child: _SearchResults(
                  query: _query,
                  results: _results,
                  selectedCategory: _selectedCategory,
                  selectedLevel: _selectedLevel,
                  categories: _categories,
                  levels: _levels,
                  onCategoryChanged: (c) => setState(() => _selectedCategory = _selectedCategory == c ? null : c),
                  onLevelChanged: (l) => setState(() => _selectedLevel = _selectedLevel == l ? null : l),
                )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onBack;

  const _SearchBar({
    required this.controller,
    required this.focusNode,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xs, AppSpacing.sm, AppSpacing.xl, AppSpacing.sm,
      ),
      child: Row(
        children: [
          AppBackButton(iconSize: 22, onPressed: onBack),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
              ),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  hintText: t.searchArticlesHint,
                  hintTextDirection: TextDirection.rtl,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: AppSpacing.md,
                  ),
                  suffixIcon: controller.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 20),
                          onPressed: () {
                            controller.clear();
                            focusNode.requestFocus();
                          },
                        )
                      : null,
                ),
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  final List<String> searches;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onRemove;

  const _RecentSearches({
    required this.searches,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    if (searches.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔍', style: TextStyle(fontSize: 80)),
            const SizedBox(height: AppSpacing.xl),
            Text(
              t.searchEmptyTitle,
              style: AppTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              t.searchEmptySub,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.sm,
          ),
          child: Row(
            children: [
              const Text('🕐', style: TextStyle(fontSize: 18)),
              const SizedBox(width: AppSpacing.sm),
              Text(
                t.searchRecent,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            itemCount: searches.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.xs),
            itemBuilder: (context, index) {
              final search = searches[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
                ),
                child: ListTile(
                  leading: const Text('🕐', style: TextStyle(fontSize: 18)),
                  title: Text(
                    search,
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () => onRemove(search),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: const Center(
                        child: Icon(Icons.close_rounded, size: 16, color: AppColors.textTertiary),
                      ),
                    ),
                  ),
                  onTap: () => onTap(search),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SearchResults extends StatelessWidget {
  final String query;
  final List<Article> results;
  final String? selectedCategory;
  final String? selectedLevel;
  final List<_CategoryData> categories;
  final List<String> levels;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onLevelChanged;

  const _SearchResults({
    required this.query,
    required this.results,
    required this.selectedCategory,
    required this.selectedLevel,
    required this.categories,
    required this.levels,
    required this.onCategoryChanged,
    required this.onLevelChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final filtered = results.where((r) {
      if (selectedCategory != null && r.category != selectedCategory) return false;
      if (selectedLevel != null && r.level != selectedLevel) return false;
      if (query.isNotEmpty && !r.title.toLowerCase().contains(query.toLowerCase())) return false;
      return true;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isSelected = cat.id == selectedCategory;
              return GestureDetector(
                onTap: () => onCategoryChanged(cat.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primaryContainer : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary.withValues(alpha: 0.3)
                          : AppColors.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(cat.emoji, style: const TextStyle(fontSize: 14)),
                      const SizedBox(width: 6),
                      Text(
                        cat.id,
                        style: AppTypography.labelMedium.copyWith(
                          color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            itemCount: levels.length,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, index) {
              final level = levels[index];
              final isSelected = level == selectedLevel;
              final levelColor = _levelColor(level);
              return GestureDetector(
                onTap: () => onLevelChanged(level),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.xxs,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? levelColor.withValues(alpha: 0.12) : AppColors.surface,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(
                      color: isSelected
                          ? levelColor.withValues(alpha: 0.5)
                          : AppColors.outline.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    level,
                    style: AppTypography.labelMedium.copyWith(
                      color: isSelected ? levelColor : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Text(
            t.searchResults(filtered.length, query),
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 64)),
                      const SizedBox(height: AppSpacing.xl),
                      Text(
                        t.searchNoResults,
                        style: AppTypography.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        t.searchNoResultsDetail,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  itemCount: filtered.length,
                  separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final result = filtered[index];
                    final accentColors = [
                      AppColors.primary,
                      AppColors.accentBlue,
                      AppColors.tertiary,
                      AppColors.secondary,
                      AppColors.accentPink,
                      AppColors.accentYellow,
                    ];
                    final accent = accentColors[index % accentColors.length];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg, vertical: AppSpacing.sm,
                        ),
                        leading: Container(
                          width: 44, height: 44,
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          ),
                          child: Center(
                            child: Text(
                              _categoryEmoji(result.category),
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                        title: Text(
                          result.title,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: AppSpacing.xs),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: _levelColor(result.level).withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  result.level,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: _levelColor(result.level),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Text(
                                result.publishedAt.toIso8601String().substring(0, 10),
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        onTap: () => context.push('/article/${result.id}'),
                      ),
                    );
                  },
                ),
        ),
      ],
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
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('😕', style: TextStyle(fontSize: 64)),
            const SizedBox(height: AppSpacing.xl),
            Text(
              message,
              style: AppTypography.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxl),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(t.homeRetry),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryData {
  final String id;
  final String emoji;
  const _CategoryData(this.id, this.emoji);
}

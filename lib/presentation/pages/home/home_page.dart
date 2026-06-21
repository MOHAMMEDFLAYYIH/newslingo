import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/constants/app_constants.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/cubit/news/news_cubit.dart';
import 'package:newslingo/presentation/cubit/news/news_state.dart';
import 'package:newslingo/presentation/widgets/news_card.dart';
import 'package:newslingo/presentation/widgets/shimmer_loading.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              _Header(),
              _CategoryBar(),
              Expanded(child: _NewsList()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl, AppSpacing.md, AppSpacing.xl, AppSpacing.sm,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConstants.appName,
                  style: AppTypography.titleLarge.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  t.homeTodayTitle,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          _IconBtn(emoji: '🔍', onTap: () => context.push('/search')),
          const SizedBox(width: AppSpacing.sm),
          _IconBtn(emoji: '🔔', onTap: () {}),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final String emoji;
  final VoidCallback onTap;
  const _IconBtn({required this.emoji, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = AppConstants.categories;
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final category = categories[index];
          final cubit = context.watch<NewsCubit>();
          final isSelected = cubit.state.category == category;
          final emojis = {
            'general': '🌍',
            'sports': '⚽',
            'technology': '💻',
            'business': '📈',
            'science': '🔬',
            'entertainment': '🎬',
          };
          return GestureDetector(
            onTap: () {
              final locale = context.read<LocaleCubit>().state.languageCode;
              context
                  .read<NewsCubit>()
                  .filterByCategory(isSelected ? null : category, locale: locale);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryContainer
                    : AppColors.surface,
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
                  Text(emojis[category] ?? '🌍', style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    AppConstants.categoryLabels[category] ?? category,
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
    );
  }
}

class _NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        switch (state.status) {
          case NewsStatus.initial:
          case NewsStatus.loading:
            return ListView.builder(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              itemCount: 4,
              itemBuilder: (_, _) => const NewsCardShimmer(),
            );
          case NewsStatus.error:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('😕', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      t.homeError,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      state.errorMessage ?? t.homeErrorDetail,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    FilledButton.icon(
                      onPressed: () {
                        final locale = context.read<LocaleCubit>().state.languageCode;
                        context.read<NewsCubit>().refresh(locale: locale);
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: Text(t.homeRetry),
                    ),
                  ],
                ),
              ),
            );
          case NewsStatus.loaded:
            if (state.articles.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('📭', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      t.homeEmpty,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      t.homeEmptyDetail,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () {
                final locale = context.read<LocaleCubit>().state.languageCode;
                return context.read<NewsCubit>().refresh(locale: locale);
              },
              child: ListView(
                padding: const EdgeInsets.only(top: AppSpacing.xs, bottom: AppSpacing.xl),
                children: [
                  ...List.generate(state.articles.length, (index) {
                    final article = state.articles[index];
                    final accentColors = [
                      AppColors.primary,
                      AppColors.accentBlue,
                      AppColors.tertiary,
                      AppColors.secondary,
                      AppColors.accentPink,
                      AppColors.accentYellow,
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: NewsCard(
                        article: article,
                        accentColor: accentColors[index % accentColors.length],
                        onTap: () => context.push('/article/${article.id}'),
                      ),
                    );
                  }),
                ],
              ),
            );
        }
      },
    );
  }
}

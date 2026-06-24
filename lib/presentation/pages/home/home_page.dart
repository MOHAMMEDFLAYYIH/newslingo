import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/constants/app_constants.dart';
import 'package:newslingo/core/di/injection.dart';
import 'package:newslingo/core/localization/locale_cubit.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/domain/entities/article.dart';
import 'package:newslingo/presentation/cubit/news/news_cubit.dart';
import 'package:newslingo/presentation/cubit/news/news_state.dart';
import 'package:newslingo/presentation/cubit/progress/progress_cubit.dart';
import 'package:newslingo/presentation/cubit/progress/progress_state.dart';
import 'package:newslingo/presentation/widgets/bento_news_card.dart';
import 'package:newslingo/presentation/widgets/shimmer_loading.dart';
import 'package:newslingo/core/localization/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProgressCubit>(
      create: (_) => sl<ProgressCubit>()..loadProgress(),
      child: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              const _Header(),
              const _CategoryBar(),
              const Expanded(child: _NewsBentoGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.sm,
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
          BlocBuilder<ProgressCubit, ProgressState>(
            builder: (context, state) {
              if (state.status != ProgressStatus.loaded || state.progress.streak < 1) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsetsDirectional.only(end: AppSpacing.sm),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    border: Border.all(color: const Color(0xFFFFCC80).withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('🔥', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 4),
                      Text(
                        '${state.progress.streak}',
                        style: AppTypography.labelMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFE65100),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          _IconBtn(emoji: '🔍', onTap: () => context.push('/search')),
          const SizedBox(width: AppSpacing.sm),
          _IconBtn(emoji: '🔔', onTap: () => context.push('/settings')),
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
  const _CategoryBar();

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
              context.read<NewsCubit>().filterByCategory(
                isSelected ? null : category,
                locale: locale,
              );
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
                  Text(
                    emojis[category] ?? '🌍',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    AppLocalizations.of(context).categoryLabel(category),
                    style: AppTypography.labelMedium.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
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

class _NewsBentoGrid extends StatelessWidget {
  const _NewsBentoGrid();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        debugPrint('[HomePage] BlocBuilder — status: ${state.status}, articles: ${state.articles.length}');
        switch (state.status) {
          case NewsStatus.initial:
          case NewsStatus.loading:
            return ListView(
              padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.xl),
              children: const [
                BentoGridShimmer(),
              ],
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
                        final locale = context
                            .read<LocaleCubit>()
                            .state
                            .languageCode;
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
                children: _buildBentoGrid(state.articles, context),
              ),
            );
        }
      },
    );
  }

  List<Widget> _buildBentoGrid(List<Article> articles, BuildContext context) {
    final widgets = <Widget>[];
    final gap = AppSpacing.sm;
    int i = 0;

    while (i < articles.length) {
      final offset = i % 8;

      if (offset == 0) {
        final a = articles[i];
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: BentoNewsCard(
            article: a,
            size: BentoSize.hero,
            onTap: () => context.push('/article/${a.id}'),
          ),
        ));
        i++;
      } else if (offset == 1) {
        final a0 = articles[i];
        final hasSecond = i + 1 < articles.length;
        final a1 = hasSecond ? articles[i + 1] : null;
        widgets.add(Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: BentoNewsCard(
                  article: a0,
                  size: BentoSize.medium,
                  onTap: () => context.push('/article/${a0.id}'),
                ),
              ),
              SizedBox(width: gap),
              if (hasSecond)
                Expanded(
                  child: BentoNewsCard(
                    article: a1!,
                    size: BentoSize.medium,
                    onTap: () => context.push('/article/${a1.id}'),
                  ),
                )
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        ));
        i += 2;
      } else if (offset == 3) {
        final a = articles[i];
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: BentoNewsCard(
            article: a,
            size: BentoSize.wide,
            onTap: () => context.push('/article/${a.id}'),
          ),
        ));
        i++;
      } else {
        final a0 = articles[i];
        final hasSecond = i + 1 < articles.length;
        final a1 = hasSecond ? articles[i + 1] : null;
        widgets.add(Padding(
          padding: EdgeInsets.only(
            left: AppSpacing.xl,
            right: AppSpacing.xl,
            bottom: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: BentoNewsCard(
                  article: a0,
                  size: BentoSize.small,
                  onTap: () => context.push('/article/${a0.id}'),
                ),
              ),
              SizedBox(width: gap),
              if (hasSecond)
                Expanded(
                  child: BentoNewsCard(
                    article: a1!,
                    size: BentoSize.small,
                    onTap: () => context.push('/article/${a1.id}'),
                  ),
                )
              else
                const Expanded(child: SizedBox()),
            ],
          ),
        ));
        i += 2;
      }
    }

    return widgets;
  }
}

class BentoGridShimmer extends StatelessWidget {
  const BentoGridShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ShimmerHero(),
        const SizedBox(height: AppSpacing.sm),
        _ShimmerRow(height: 260),
        const SizedBox(height: AppSpacing.sm),
        _ShimmerWide(),
        const SizedBox(height: AppSpacing.sm),
        _ShimmerRow(height: 200),
      ],
    );
  }
}

class _ShimmerHero extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Stack(
          children: [
            const ShimmerLoading(height: 400, borderRadius: AppSpacing.radiusLg),
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              right: AppSpacing.lg,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerLoading(height: 20, width: 200, borderRadius: 4),
                  SizedBox(height: AppSpacing.sm),
                  ShimmerLoading(height: 14, width: 140, borderRadius: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShimmerRow extends StatelessWidget {
  final double height;
  const _ShimmerRow({required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: [
          Expanded(
            child: ShimmerLoading(height: height, borderRadius: AppSpacing.radiusMd),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: ShimmerLoading(height: height, borderRadius: AppSpacing.radiusMd),
          ),
        ],
      ),
    );
  }
}

class _ShimmerWide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Row(
          children: [
            const ShimmerLoading(width: 140, height: 180, borderRadius: AppSpacing.radiusMd),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(height: 16, width: 80, borderRadius: 4),
                    SizedBox(height: AppSpacing.sm),
                    ShimmerLoading(height: 18, width: double.infinity, borderRadius: 4),
                    SizedBox(height: AppSpacing.xs),
                    ShimmerLoading(height: 14, width: 120, borderRadius: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

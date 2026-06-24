import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/core/utils/extensions.dart';
import 'package:newslingo/domain/entities/article.dart';

enum BentoSize { hero, medium, wide, small }

class BentoNewsCard extends StatelessWidget {
  final Article article;
  final BentoSize size;
  final VoidCallback onTap;

  const BentoNewsCard({
    super.key,
    required this.article,
    required this.size,
    required this.onTap,
  });

  Color get _accentColor {
    final colors = AppColors.cardAccents;
    return colors[article.title.hashCode % colors.length];
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
    switch (size) {
      case BentoSize.hero:
        return _HeroCard(article: article, accentColor: _accentColor, levelColor: _levelColor(article.level), onTap: onTap);
      case BentoSize.medium:
        return _MediumCard(article: article, accentColor: _accentColor, levelColor: _levelColor(article.level), onTap: onTap);
      case BentoSize.wide:
        return _WideCard(article: article, accentColor: _accentColor, levelColor: _levelColor(article.level), onTap: onTap);
      case BentoSize.small:
        return _SmallCard(article: article, accentColor: _accentColor, levelColor: _levelColor(article.level), onTap: onTap);
    }
  }
}

class _HeroCard extends StatelessWidget {
  final Article article;
  final Color accentColor;
  final Color levelColor;
  final VoidCallback onTap;

  const _HeroCard({
    required this.article,
    required this.accentColor,
    required this.levelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: AppColors.shadowMd,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: article.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.surfaceVariant),
                errorWidget: (_, _, _) => Container(
                  color: accentColor.withValues(alpha: 0.15),
                  child: Icon(Icons.article_rounded, size: 48, color: accentColor.withValues(alpha: 0.4)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: AppSpacing.lg,
                left: AppSpacing.lg,
                child: Row(
                  children: [
                    _LevelBadge(level: article.level, color: levelColor),
                    const SizedBox(width: AppSpacing.sm),
                    _CategoryChip(category: article.category),
                  ],
                ),
              ),
              Positioned(
                bottom: AppSpacing.lg,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.translatedTitle ?? article.title,
                      style: AppTypography.titleLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      article.translatedDescription ?? article.description,
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 14, color: Colors.white.withValues(alpha: 0.6)),
                        const SizedBox(width: 4),
                        Text(
                          article.publishedAt.relativeTime(Localizations.localeOf(context)),
                          style: AppTypography.labelSmall.copyWith(color: Colors.white.withValues(alpha: 0.6)),
                        ),
                        const Spacer(),
                        Icon(Icons.play_circle_fill_rounded, size: 20, color: accentColor),
                        const SizedBox(width: 4),
                        Text(
                          t.cardListen,
                          style: AppTypography.labelSmall.copyWith(color: accentColor, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
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

class _MediumCard extends StatelessWidget {
  final Article article;
  final Color accentColor;
  final Color levelColor;
  final VoidCallback onTap;

  const _MediumCard({
    required this.article,
    required this.accentColor,
    required this.levelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          color: AppColors.surface,
          boxShadow: AppColors.shadowSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: CachedNetworkImage(
                imageUrl: article.imageUrl,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, _) => Container(color: AppColors.surfaceVariant),
                errorWidget: (_, _, _) => Container(
                  color: accentColor.withValues(alpha: 0.1),
                  child: Center(
                    child: Icon(Icons.article_rounded, size: 32, color: accentColor.withValues(alpha: 0.4)),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _LevelBadge(level: article.level, color: levelColor, compact: true),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).categoryLabel(article.category),
                            style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        article.translatedTitle ?? article.title,
                        style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700, height: 1.2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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

class _WideCard extends StatelessWidget {
  final Article article;
  final Color accentColor;
  final Color levelColor;
  final VoidCallback onTap;

  const _WideCard({
    required this.article,
    required this.accentColor,
    required this.levelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.antiAlias,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            color: AppColors.surface,
            boxShadow: AppColors.shadowSm,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 140,
                child: CachedNetworkImage(
                  imageUrl: article.imageUrl,
                  width: 140,
                  fit: BoxFit.cover,
                  placeholder: (_, _) => Container(color: AppColors.surfaceVariant),
                  errorWidget: (_, _, _) => Container(
                    color: accentColor.withValues(alpha: 0.1),
                    child: Center(
                      child: Icon(Icons.article_rounded, size: 32, color: accentColor.withValues(alpha: 0.4)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _LevelBadge(level: article.level, color: levelColor, compact: true),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            AppLocalizations.of(context).categoryLabel(article.category),
                            style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                          ),
                          const Spacer(),
                          Icon(Icons.play_circle_fill_rounded, size: 16, color: accentColor),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          article.translatedTitle ?? article.title,
                          style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w700, height: 1.3),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        article.publishedAt.relativeTime(Localizations.localeOf(context)),
                        style: AppTypography.labelSmall.copyWith(color: AppColors.textTertiary),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallCard extends StatelessWidget {
  final Article article;
  final Color accentColor;
  final Color levelColor;
  final VoidCallback onTap;

  const _SmallCard({
    required this.article,
    required this.accentColor,
    required this.levelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          color: AppColors.surface,
          boxShadow: AppColors.shadowSm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: article.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(color: AppColors.surfaceVariant),
                    errorWidget: (_, _, _) => Container(
                      color: accentColor.withValues(alpha: 0.1),
                      child: Center(
                        child: Icon(Icons.article_rounded, size: 24, color: accentColor.withValues(alpha: 0.4)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: _LevelBadge(level: article.level, color: levelColor, compact: true),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Text(
                  article.translatedTitle ?? article.title,
                  style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w700, height: 1.2),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final String level;
  final Color color;
  final bool compact;

  const _LevelBadge({
    required this.level,
    required this.color,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.sm : AppSpacing.sm + 2,
        vertical: compact ? 2 : AppSpacing.xxs + 1,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
      ),
      child: Text(
        level,
        style: TextStyle(
          fontSize: compact ? 9 : 11,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXs),
      ),
      child: Text(
        AppLocalizations.of(context).categoryLabel(category),
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}

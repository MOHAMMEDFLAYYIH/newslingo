import 'package:flutter/material.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final bool isFullPage;

  const NoInternetWidget({
    super.key,
    this.onRetry,
    this.isFullPage = false,
  });

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.warningContainer.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppColors.warningContainer,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('📡', style: TextStyle(fontSize: 44)),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text(
          AppLocalizations.of(context).noInternetTitle,
          style: AppTypography.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
          child: Text(
            AppLocalizations.of(context).noInternetDescription,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.xxl),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.warningContainer,
            shape: BoxShape.circle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onRetry,
              borderRadius: BorderRadius.circular(28),
              child: const Center(
                child: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.warning,
                  size: 28,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          AppLocalizations.of(context).homeRetry,
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.warning,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    if (isFullPage) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: content,
    );
  }
}

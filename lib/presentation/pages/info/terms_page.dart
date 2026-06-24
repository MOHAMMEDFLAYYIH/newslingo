import 'package:flutter/material.dart';

import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/widgets/app_back_button.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  List<_SectionData> _buildSections(AppLocalizations t) => [
    _SectionData(
      emoji: '📝',
      title: t.termsSection1Title,
      body: t.termsSection1Body,
    ),
    _SectionData(
      emoji: '👤',
      title: t.termsSection2Title,
      body: t.termsSection2Body,
    ),
    _SectionData(
      emoji: '📖',
      title: t.termsSection3Title,
      body: t.termsSection3Body,
    ),
    _SectionData(
      emoji: '🚫',
      title: t.termsSection4Title,
      body: t.termsSection4Body,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                child: Row(
                  children: [
                    AppBackButton(),
                    const Spacer(),
                    Text(
                      t.termsTitle,
                      style: AppTypography.titleLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 48),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.sm,
                ),
                child: Text(
                  t.termsLastUpdated,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                  ),
                  children: [
                    ..._buildSections(
                      t,
                    ).map((section) => _TermsSection(section: section)),
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

class _SectionData {
  final String emoji;
  final String title;
  final String body;
  const _SectionData({
    required this.emoji,
    required this.title,
    required this.body,
  });
}

class _TermsSection extends StatelessWidget {
  final _SectionData section;

  const _TermsSection({required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outline.withValues(alpha: 0.3)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: ColorScheme.light(primary: AppColors.primary),
        ),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          childrenPadding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          shape: const Border(),
          collapsedShape: const Border(),
          leading: Text(section.emoji, style: const TextStyle(fontSize: 20)),
          title: Text(
            section.title,
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          children: [
            Text(
              section.body,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

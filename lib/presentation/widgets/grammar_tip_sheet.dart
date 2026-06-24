import 'package:flutter/material.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class GrammarTip {
  final String title;
  final String rule;
  final List<GrammarExample> examples;
  final String level;
  final String category;

  const GrammarTip({
    required this.title,
    required this.rule,
    required this.examples,
    this.level = 'B1',
    this.category = 'grammar',
  });

  String get emoji {
    switch (category) {
      case 'writing':
        return '✍️';
      case 'speaking':
        return '🗣️';
      default:
        return '📚';
    }
  }

  Color get color {
    switch (category) {
      case 'writing':
        return AppColors.accentBlue;
      case 'speaking':
        return AppColors.tertiary;
      default:
        return AppColors.primary;
    }
  }
}

class GrammarExample {
  final String english;
  final String arabic;

  const GrammarExample({required this.english, required this.arabic});
}

final List<GrammarTip> sampleGrammarTips = [
  GrammarTip(
    title: 'المضارع البسيط vs المضارع المستمر',
    category: 'grammar',
    level: 'A2',
    rule:
        'المضارع البسيط (Present Simple) نستخدمه للتحدث عن حقائق ثابتة أو عادات يومية.\n'
        'المضارع المستمر (Present Continuous) نستخدمه للتحدث عن شيء يحدث الآن أو حول هذه الفترة.',
    examples: [
      GrammarExample(
        english: 'I drink coffee every morning.',
        arabic: 'أنا أشرب القهوة كل صباح. (عادة يومية)',
      ),
      GrammarExample(
        english: 'I am drinking coffee right now.',
        arabic: 'أنا أشرب القهوة الآن. (يحدث في هذه اللحظة)',
      ),
      GrammarExample(
        english: 'She works as a teacher.',
        arabic: 'هي تعمل كمدرسة. (حقيقة ثابتة)',
      ),
      GrammarExample(
        english: 'She is working on a project this week.',
        arabic: 'هي تعمل على مشروع هذا الأسبوع. (حول هذه الفترة)',
      ),
    ],
  ),
  GrammarTip(
    title: 'الفرق بين Despite و Although',
    category: 'writing',
    level: 'B1',
    rule:
        'كلاهما يعني "على الرغم من"، لكن الفرق في التركيب:\n'
        '• Although + جملة كاملة (فعل + فاعل)\n'
        '• Despite + اسم أو gerund (فعل + ing)',
    examples: [
      GrammarExample(
        english: 'Although it was raining, we went out.',
        arabic: 'على الرغم من أنه كان يمطر، خرجنا.',
      ),
      GrammarExample(
        english: 'Despite the rain, we went out.',
        arabic: 'على الرغم من المطر، خرجنا.',
      ),
      GrammarExample(
        english: 'Although he studied hard, he failed the exam.',
        arabic: 'على الرغم من أنه درس بجد، رسب في الامتحان.',
      ),
      GrammarExample(
        english: 'Despite studying hard, he failed the exam.',
        arabic: 'على الرغم من الدراسة بجد، رسب في الامتحان.',
      ),
    ],
  ),
  GrammarTip(
    title: 'الجمل الشرطية (If Sentences)',
    category: 'speaking',
    level: 'B1',
    rule:
        'الجمل الشرطية لها ثلاث أنواع رئيسية:\n'
        '• النوع الأول (Real): If + مضارع بسيط، will + فعل\n'
        '• النوع الثاني (Unreal): If + ماضي بسيط، would + فعل\n'
        '• النوع الثالث (Past Unreal): If + ماضي تام، would have + التصريف الثالث',
    examples: [
      GrammarExample(
        english: 'If it rains, I will stay home.',
        arabic: 'إذا أمطرت، سأبقى في المنزل. (محتمل حدوثه)',
      ),
      GrammarExample(
        english: 'If I were rich, I would travel the world.',
        arabic: 'إذا كنت غنياً، لسافرت حول العالم. (غير حقيقي الآن)',
      ),
      GrammarExample(
        english: 'If I had studied, I would have passed.',
        arabic: 'إذا كنت قد درست، لكنت نجحت. (شيء لم يحدث في الماضي)',
      ),
    ],
  ),
];

void showGrammarTipSheet(BuildContext context, GrammarTip tip) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _GrammarTipSheetContent(tip: tip),
  );
}

class _GrammarTipSheetContent extends StatelessWidget {
  final GrammarTip tip;

  const _GrammarTipSheetContent({required this.tip});

  @override
  Widget build(BuildContext context) {
    final color = tip.color;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXxl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: AppSpacing.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outline.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xxl,
              AppSpacing.xl,
              AppSpacing.xxl,
              AppSpacing.xxl,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          tip.emoji,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  tip.title,
                                  style: AppTypography.titleMedium.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xxs,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(
                                    AppSpacing.radiusXs,
                                  ),
                                ),
                                child: Text(
                                  tip.level,
                                  style: AppTypography.labelSmall.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceVariant,
                              borderRadius: BorderRadius.circular(
                                AppSpacing.radiusFull,
                              ),
                            ),
                            child: Text(
                              _categoryLabel(tip.category, context),
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    border: Border.all(color: color.withValues(alpha: 0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).grammarRule,
                        style: AppTypography.titleSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        tip.rule,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textPrimary,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context).grammarExamples,
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...tip.examples.map(
                  (ex) => Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🇬🇧', style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                ex.english,
                                style: AppTypography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🇦🇪', style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                ex.arabic,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.md,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context).grammarGotIt,
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _categoryLabel(String category, BuildContext context) {
    final t = AppLocalizations.of(context);
    switch (category) {
      case 'writing':
        return t.grammarCategoryWriting;
      case 'speaking':
        return t.grammarCategorySpeaking;
      default:
        return t.grammarCategoryGrammar;
    }
  }
}

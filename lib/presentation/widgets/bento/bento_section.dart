import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/responsive/responsive_typography.dart';

class BentoSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? trailing;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  const BentoSection({
    super.key,
    this.title,
    this.subtitle,
    this.trailing,
    required this.children,
    this.padding,
    this.spacing = AppSpacing.md,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null || trailing != null)
            Padding(
              padding: EdgeInsets.only(bottom: spacing.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Text(title!, style: ResponsiveTypography.titleSmall.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                        if (subtitle != null)
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(subtitle!, style: ResponsiveTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            )),
                          ),
                      ],
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class BentoContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final Border? border;

  const BentoContainer({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.gradient,
    this.borderRadius,
    this.boxShadow,
    this.margin,
    this.border,
    required this.child,
  });

  factory BentoContainer.primary({
    required Widget child,
    double? height,
    double? width,
  }) {
    return BentoContainer(
      height: height,
      width: width,
      color: AppColors.primaryContainer,
      padding: EdgeInsets.all(AppSpacing.md.w),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg.r),
      boxShadow: AppColors.shadowSm,
      child: child,
    );
  }

  factory BentoContainer.card({
    required Widget child,
    double? height,
    double? width,
  }) {
    return BentoContainer(
      height: height,
      width: width,
      color: AppColors.surface,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg.r),
      boxShadow: AppColors.shadowSm,
      child: child,
    );
  }

  factory BentoContainer.gradient({
    required Widget child,
    required Gradient gradient,
    double? height,
    double? width,
  }) {
    return BentoContainer(
      height: height,
      width: width,
      gradient: gradient,
      padding: EdgeInsets.all(AppSpacing.lg.w),
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg.r),
      child: child,
    );
  }

  factory BentoContainer.image({
    required Widget child,
    double? height,
    double? width,
  }) {
    return BentoContainer(
      height: height,
      width: width,
      color: AppColors.surfaceVariant,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(AppSpacing.radiusLg.r),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decoration = BoxDecoration(
      color: gradient == null ? (color ?? theme.cardTheme.color) : null,
      gradient: gradient,
      borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusMd.r),
      boxShadow: boxShadow,
      border: border,
    );

    final container = Container(
      height: height?.h,
      width: width?.w,
      margin: margin,
      decoration: decoration,
      padding: padding,
      child: child,
    );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: container,
      );
    }

    return container;
  }
}

import 'package:flutter/material.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';

class ShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = AppSpacing.radiusSm,
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + _controller.value * 2, -1),
              end: Alignment(1 - _controller.value * 2, 1),
              colors: [
                AppColors.surfaceVariant,
                AppColors.surfaceContainer.withValues(alpha: 0.5),
                AppColors.surfaceVariant,
              ],
            ),
          ),
        );
      },
    );
  }
}

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ShimmerLoading(width: 40, height: 18, borderRadius: 4),
                SizedBox(width: AppSpacing.sm),
                ShimmerLoading(width: 60, height: 18, borderRadius: 4),
                Spacer(),
                ShimmerLoading(width: 50, height: 18, borderRadius: 4),
              ],
            ),
            SizedBox(height: AppSpacing.md),
            ShimmerLoading(height: 20),
            SizedBox(height: AppSpacing.sm),
            ShimmerLoading(height: 16, width: 0.8),
            SizedBox(height: AppSpacing.md),
            ShimmerLoading(height: 14, width: 0.6),
          ],
        ),
      ),
    );
  }
}

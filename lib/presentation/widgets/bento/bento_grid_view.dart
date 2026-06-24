import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/responsive/responsive_config.dart';
import '../../../core/theme/app_spacing.dart';

class BentoGridDelegate {
  final int Function(ScreenType screenType) crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  const BentoGridDelegate({
    this.crossAxisCount = _defaultCrossAxis,
    this.mainAxisSpacing = AppSpacing.md,
    this.crossAxisSpacing = AppSpacing.md,
  });

  static int _defaultCrossAxis(ScreenType type) {
    switch (type) {
      case ScreenType.mobile:
        return 2;
      case ScreenType.tablet:
        return 3;
      case ScreenType.desktop:
        return 4;
    }
  }
}

class BentoGridView extends StatelessWidget {
  final List<Widget> children;
  final BentoGridDelegate delegate;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const BentoGridView({
    super.key,
    required this.children,
    this.delegate = const BentoGridDelegate(),
    this.padding,
    this.physics,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenType = context.screenType;
    final crossAxisCount = delegate.crossAxisCount(screenType);
    final spacing = delegate.crossAxisSpacing.w;

    if (crossAxisCount <= 1) {
      return ListView(
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding ?? EdgeInsets.all(AppSpacing.md.w),
        children: _insertSpacing(children, delegate.mainAxisSpacing.h),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final horizontalPadding = padding?.horizontal is EdgeInsets
            ? (padding as EdgeInsets).horizontal
            : AppSpacing.md.w * 2;
        final availableWidth = totalWidth - horizontalPadding;
        final itemWidth =
            (availableWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: delegate.mainAxisSpacing.h,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }

  List<Widget> _insertSpacing(List<Widget> items, double spacing) {
    if (items.isEmpty) return items;
    final result = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(SizedBox(height: spacing));
      }
    }
    return result;
  }
}

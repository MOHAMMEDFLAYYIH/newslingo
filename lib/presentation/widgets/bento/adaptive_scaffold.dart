import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/responsive/responsive_config.dart';
import '../../../core/responsive/responsive_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class AdaptiveScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? titleEmoji;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomNavigationBar;
  final Widget? sideRail;
  final double? sideRailWidth;

  const AdaptiveScaffold({
    super.key,
    required this.body,
    this.title,
    this.titleEmoji,
    this.actions,
    this.leading,
    this.bottomNavigationBar,
    this.sideRail,
    this.sideRailWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutBuilder(
      builder: (context, screenType) {
        if (screenType == ScreenType.mobile) {
          return _buildMobileLayout(context);
        }
        return _buildTabletDesktopLayout(context, screenType);
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  Widget _buildTabletDesktopLayout(BuildContext context, ScreenType type) {
    final railWidth =
        sideRailWidth ?? (type == ScreenType.tablet ? 220.w : 260.w);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Row(
        children: [
          if (sideRail != null) SizedBox(width: railWidth, child: sideRail),
          Expanded(child: body),
          if (sideRail != null)
            Container(
              width: 1,
              color: AppColors.outline.withValues(alpha: 0.3),
            ),
        ],
      ),
    );
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (title == null && leading == null && actions == null) return null;

    final effectiveTitle = titleEmoji != null ? '$titleEmoji $title' : title;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      title: effectiveTitle != null
          ? Text(
              effectiveTitle,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            )
          : null,
      centerTitle: !context.isDesktop,
      actions: actions,
    );
  }
}

class SideRail extends StatelessWidget {
  final List<SideRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const SideRail({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    return Container(
      color: AppColors.surface,
      child: Column(
        children: [
          if (isDesktop) ...[
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Center(
                      child: Text(
                        'NL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'NewsLingo',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm.w),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final isSelected = index == selectedIndex;
                return Padding(
                  padding: EdgeInsets.only(bottom: 2.h),
                  child: Material(
                    color: isSelected
                        ? AppColors.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(
                        AppSpacing.radiusMd.r,
                      ),
                      onTap: () => onItemSelected(index),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.md.w,
                          vertical: isDesktop ? 12.h : 10.h,
                        ),
                        child: Row(
                          children: [
                            Text(item.emoji, style: TextStyle(fontSize: 18.sp)),
                            SizedBox(width: AppSpacing.md.w),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: isDesktop ? 14.sp : 13.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideRailItem {
  final String emoji;
  final String label;
  const SideRailItem({required this.emoji, required this.label});
}

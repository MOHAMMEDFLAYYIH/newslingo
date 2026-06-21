import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/responsive/responsive_config.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';
import 'package:newslingo/presentation/widgets/bento/adaptive_scaffold.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell child;

  const MainShell({
    super.key,
    required this.child,
  });

  static const _navIcons = [
    Icons.home_outlined,
    Icons.book_outlined,
    Icons.person_outline_rounded,
  ];

  List<SideRailItem> _navItems(BuildContext context) {
    final t = AppLocalizations.of(context);
    return [
      SideRailItem(emoji: '📰', label: t.navHome),
      SideRailItem(emoji: '📚', label: t.navVocabulary),
      SideRailItem(emoji: '👤', label: t.navProfile),
    ];
  }

  void _onTap(int index) => child.goBranch(index);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (Breakpoints.isMobile(constraints.maxWidth)) {
          return _buildMobileLayout(context);
        }
        return _buildDesktopLayout(context);
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideRail(
            items: _navItems(context),
            selectedIndex: child.currentIndex,
            onItemSelected: _onTap,
          ),
          Container(
            width: 1,
            color: AppColors.outline.withValues(alpha: 0.3),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md.w,
              vertical: AppSpacing.xs.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(3, (i) => _NavItem(
                icon: _navIcons[i],
                label: _navItems(context)[i].label,
                isSelected: child.currentIndex == i,
                onTap: () => _onTap(i),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.xl.w,
          vertical: AppSpacing.sm.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
              size: 24.w,
            ),
            SizedBox(height: 2.h),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textTertiary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

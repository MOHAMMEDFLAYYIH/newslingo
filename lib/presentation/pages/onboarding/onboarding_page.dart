import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newslingo/core/localization/app_localizations.dart';
import 'package:newslingo/core/theme/app_colors.dart';
import 'package:newslingo/core/theme/app_spacing.dart';
import 'package:newslingo/core/theme/app_typography.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animController;

  late List<_PageData> _pages;

  List<_PageData> _buildPages(AppLocalizations t) => [
    _PageData(
      emoji: '📰',
      color: AppColors.primary,
      bgColor: AppColors.primaryContainer,
      title: t.obTitle1,
      subtitle: t.obSub1,
    ),
    _PageData(
      emoji: '🔍',
      color: AppColors.accentBlue,
      bgColor: AppColors.accentBlueContainer,
      title: t.obTitle2,
      subtitle: t.obSub2,
    ),
    _PageData(
      emoji: '🏆',
      color: AppColors.accentYellow,
      bgColor: AppColors.accentYellowContainer,
      title: t.obTitle3,
      subtitle: t.obSub3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    _pages = _buildPages(t);
    return Scaffold(
      body: Container(
        color: AppColors.background,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  0,
                ),
                child: Row(
                  children: [
                    if (_currentPage < _pages.length - 1)
                      TextButton(
                        onPressed: () => context.go('/onboarding/level'),
                        child: Text(
                          t.obSkip,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    else
                      const Spacer(),
                    const Spacer(),
                    _buildDots(),
                    const Spacer(),
                    SizedBox(width: _currentPage < _pages.length - 1 ? 64 : 72),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (i) {
                    setState(() => _currentPage = i);
                    _animController.reset();
                    _animController.forward();
                  },
                  itemCount: _pages.length,
                  itemBuilder: (_, i) => _OnboardingPage(
                    data: _pages[i],
                    isActive: i == _currentPage,
                  ),
                ),
              ),
              _buildBottom(t),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      children: List.generate(_pages.length, (i) {
        final isActive = i == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: isActive ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? _pages[i].color : AppColors.outline,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildBottom(AppLocalizations t) {
    final color = _pages[_currentPage].color;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xxl,
        AppSpacing.lg,
        AppSpacing.xxl,
        AppSpacing.xl4,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 56,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FilledButton(
                onPressed: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    context.go('/onboarding/level');
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentPage < _pages.length - 1 ? t.obNext : t.obStart,
                      style: AppTypography.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(
                      _currentPage < _pages.length - 1
                          ? Directionality.of(context) == TextDirection.rtl
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_forward_rounded
                          : Icons.rocket_launch_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageData {
  final String emoji;
  final Color color;
  final Color bgColor;
  final String title;
  final String subtitle;
  const _PageData({
    required this.emoji,
    required this.color,
    required this.bgColor,
    required this.title,
    required this.subtitle,
  });
}

class _OnboardingPage extends StatelessWidget {
  final _PageData data;
  final bool isActive;

  const _OnboardingPage({required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: data.bgColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Center(
              child: Text(data.emoji, style: TextStyle(fontSize: 72)),
            ),
          ),
          const SizedBox(height: AppSpacing.xl5),
          Text(
            data.title,
            style: AppTypography.displayMedium.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            data.subtitle,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

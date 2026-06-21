import 'package:flutter/material.dart';
import 'responsive_config.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ScreenType screenType) builder;
  const ResponsiveLayoutBuilder({super.key, required this.builder});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenType = ScreenTypeContext(context).screenType;
        return builder(context, screenType);
      },
    );
  }
}

class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({required this.mobile, this.tablet, this.desktop});

  T resolve(ScreenType type) {
    switch (type) {
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }
}

class Adaptive extends StatelessWidget {
  final Widget Function(ScreenType type) builder;
  const Adaptive({super.key, required this.builder});
  @override
  Widget build(BuildContext context) {
    final type = context.screenType;
    return builder(type);
  }
}

class IfMobile extends StatelessWidget {
  final Widget child;
  const IfMobile({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return child;
    return const SizedBox.shrink();
  }
}

class IfTablet extends StatelessWidget {
  final Widget child;
  const IfTablet({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    if (context.isTablet) return child;
    return const SizedBox.shrink();
  }
}

class IfDesktop extends StatelessWidget {
  final Widget child;
  const IfDesktop({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    if (context.isDesktop) return child;
    return const SizedBox.shrink();
  }
}

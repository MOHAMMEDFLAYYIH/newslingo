import 'package:flutter/material.dart';

class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < desktop;
  static bool isDesktop(double width) => width >= desktop;

  static const double designWidth = 430;
  static const double designHeight = 932;
}

enum ScreenType { mobile, tablet, desktop }

extension ScreenTypeContext on BuildContext {
  ScreenType get screenType {
    final w = MediaQuery.of(this).size.width;
    if (w < Breakpoints.mobile) return ScreenType.mobile;
    if (w < Breakpoints.desktop) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  bool get isMobile => screenType == ScreenType.mobile;
  bool get isTablet => screenType == ScreenType.tablet;
  bool get isDesktop => screenType == ScreenType.desktop;
}

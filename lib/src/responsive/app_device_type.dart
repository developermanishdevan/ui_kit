import 'package:flutter/material.dart';
import 'app_breakpoints.dart';

enum AppDeviceType { mobile, mobileLandscape, tablet, desktop, largeDesktop }

extension AppDeviceTypeX on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  AppDeviceType get deviceType {
    final w = screenWidth;
    if (w < AppBreakpoints.sm) return AppDeviceType.mobile;
    if (w < AppBreakpoints.md) return AppDeviceType.mobileLandscape;
    if (w < AppBreakpoints.lg) return AppDeviceType.tablet;
    if (w < AppBreakpoints.xl) return AppDeviceType.desktop;
    return AppDeviceType.largeDesktop;
  }

  bool get isMobile => deviceType == AppDeviceType.mobile;
  bool get isTablet => deviceType == AppDeviceType.tablet;
  bool get isDesktop =>
      deviceType == AppDeviceType.desktop ||
      deviceType == AppDeviceType.largeDesktop;
  bool get isSmallScreen => screenWidth < AppBreakpoints.md;
  bool get isLargeScreen => screenWidth >= AppBreakpoints.lg;
}

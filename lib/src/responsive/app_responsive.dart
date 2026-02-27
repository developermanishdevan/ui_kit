import 'package:flutter/material.dart';
import '../foundation/tokens/breakpoints/app_breakpoints.dart';
import 'app_device_type.dart';

/// Utility class for checking viewport sizes and categorizing them into [AppDeviceType].
/// Instead of hardcoded values, it utilizes the defined system tokens logic.
class AppResponsive {
  AppResponsive._();

  /// Gets the logical device type based on the current screen width.
  static AppDeviceType getDeviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Fallbacks to responsive checks using tokens
    if (width >= AppBreakpoints.xl) {
      return AppDeviceType.largeDesktop;
    } else if (width >= AppBreakpoints.lg) {
      return AppDeviceType.desktop;
    } else if (width >= AppBreakpoints.md) {
      return AppDeviceType.tablet;
    } else {
      return AppDeviceType.mobile;
    }
  }

  /// True if the current screen width corresponds to a mobile device.
  static bool isMobile(BuildContext context) =>
      getDeviceType(context) == AppDeviceType.mobile;

  /// True if the current screen width corresponds to a tablet.
  static bool isTablet(BuildContext context) =>
      getDeviceType(context) == AppDeviceType.tablet;

  /// True if the current screen width corresponds to a desktop screen.
  static bool isDesktop(BuildContext context) =>
      getDeviceType(context) == AppDeviceType.desktop;

  /// True if the current screen width corresponds to an extra large desktop screen.
  static bool isLargeDesktop(BuildContext context) =>
      getDeviceType(context) == AppDeviceType.largeDesktop;

  /// Custom rule: check if width is smaller than the provided generic breakpoint.
  static bool isWidthLessThan(BuildContext context, double breakpoint) =>
      MediaQuery.sizeOf(context).width < breakpoint;

  /// Custom rule: check if width is greater or equal to the provided generics breakpoint.
  static bool isWidthGreaterThan(BuildContext context, double breakpoint) =>
      MediaQuery.sizeOf(context).width >= breakpoint;
}

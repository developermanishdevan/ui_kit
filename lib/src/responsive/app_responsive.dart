import 'package:flutter/material.dart';
import 'app_device_type.dart';

/// Returns a value based on current device type.
/// Usage: `AppResponsive.value(context, mobile: 1, tablet: 2, desktop: 3)`
class AppResponsive {
  const AppResponsive._();

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    return switch (context.deviceType) {
      AppDeviceType.largeDesktop => largeDesktop ?? desktop ?? tablet ?? mobile,
      AppDeviceType.desktop => desktop ?? tablet ?? mobile,
      AppDeviceType.tablet => tablet ?? mobile,
      _ => mobile,
    };
  }
}

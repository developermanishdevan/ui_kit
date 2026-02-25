import 'package:flutter/material.dart';
import 'app_device_type.dart';

/// Renders different widgets based on screen size.
/// All builders are optional; falls back to the most applicable smaller size.
///
/// ```dart
/// AppResponsiveBuilder(
///   mobile : (_) => MobileView(),
///   tablet : (_) => TabletView(),
///   desktop: (_) => DesktopView(),
/// )
/// ```
class AppResponsiveBuilder extends StatelessWidget {
  const AppResponsiveBuilder({
    required this.mobile, super.key,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder? tablet;
  final WidgetBuilder? desktop;
  final WidgetBuilder? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final type = context.deviceType;
    return switch (type) {
      AppDeviceType.largeDesktop =>
        (largeDesktop ?? desktop ?? tablet ?? mobile)(context),
      AppDeviceType.desktop => (desktop ?? tablet ?? mobile)(context),
      AppDeviceType.tablet => (tablet ?? mobile)(context),
      _ => mobile(context),
    };
  }
}

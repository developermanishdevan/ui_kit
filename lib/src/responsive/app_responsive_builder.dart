import 'package:flutter/material.dart';
import '../foundation/tokens/breakpoints/app_breakpoints.dart';

/// Context-aware builder widget that returns different UI layouts
/// based on the available width layout constraints and predefined breakpoint tokens.
class AppResponsiveBuilder extends StatelessWidget {
  /// The default layout builder (typically for mobile devices or very small areas).
  final WidgetBuilder mobile;

  /// Layout builder targeting tablet resolution.
  final WidgetBuilder? tablet;

  /// Layout builder targeting desktop resolution.
  final WidgetBuilder? desktop;

  /// Layout builder targeting extra large desktop screens.
  final WidgetBuilder? largeDesktop;

  const AppResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        if (width >= AppBreakpoints.xl && largeDesktop != null) {
          return largeDesktop!(context);
        } else if (width >= AppBreakpoints.lg && desktop != null) {
          return desktop!(context);
        } else if (width >= AppBreakpoints.md && tablet != null) {
          return tablet!(context);
        }

        // Default to mobile if nothing else matches or is provided
        return mobile(context);
      },
    );
  }
}

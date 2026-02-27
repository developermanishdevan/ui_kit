import 'package:flutter/material.dart';

/// Provides common methods to retrieve theme properties across widgets.
mixin AppBaseWidgetMixin {
  /// Quickly gets access to the [ThemeData] in any inherited widget.
  ThemeData getTheme(BuildContext context) => Theme.of(context);

  /// Gets the screen width
  double getScreenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;

  /// Gets the screen height
  double getScreenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
}

/// Abstract base widget to be extended for consistent access to UI kit capabilities.
abstract class AppBaseWidget extends StatelessWidget with AppBaseWidgetMixin {
  const AppBaseWidget({super.key});
}

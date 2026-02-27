/// A central configuration object to define global behavior for the UI Kit.
class AppUiConfig {
  AppUiConfig._();

  /// Whether to use Material 3 design elements.
  static const bool useMaterial3 = true;

  /// Whether to animate interactions by default.
  static const bool enableAnimations = true;

  /// Global switch to show or hide ripple effects on interactive widgets.
  static const bool showRippleEffects = true;

  /// Minimum target size for all interactive elements to meet accessibility standards.
  static const double minTouchTargetSize = 48.0;
}

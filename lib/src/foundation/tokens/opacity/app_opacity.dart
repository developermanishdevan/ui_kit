/// Defines opacity values to be applied consistently on overlay layers, disabled states, or glass effects.
class AppOpacity {
  AppOpacity._();

  /// Very translucent opacity 0.1
  static const double transparent = 0.1;

  /// Semi-transparent opacity 0.3
  static const double semiTransparent = 0.3;

  /// Moderate opacity 0.5
  static const double moderate = 0.5;

  /// Most opacity 0.8
  static const double distinct = 0.8;

  /// High contrast / mostly opaque 0.95
  static const double almostSolid = 0.95;

  /// Hover state standard 0.08
  static const double hover = 0.08;

  /// Focus state standard 0.12
  static const double focus = 0.12;
}

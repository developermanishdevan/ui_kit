/// Toggle individual features on or off.
/// Useful for phasing rollouts or testing experimental components.
class FeatureFlags {
  FeatureFlags._();

  /// Enables unfinished beta components and layouts
  static const bool enableBetaFeatures = false;

  /// Enables debug mode borders or labels in the UI kit
  static const bool debugUiKit = false;

  /// Enables custom text scaling factor logic through the UI kit
  static const bool enableA11yTextScaling = true;
}

/// App-level UI configuration.
class AppUiConfig {
  const AppUiConfig({
    this.defaultAnimationEnabled = true,
    this.defaultBorderRadius = 8.0,
    this.defaultElevation = 2.0,
    this.useMaterial3 = true,
    this.compactMode = false,
  });

  final bool defaultAnimationEnabled;
  final double defaultBorderRadius;
  final double defaultElevation;
  final bool useMaterial3;
  final bool compactMode;

  static AppUiConfig _instance = const AppUiConfig();
  static AppUiConfig get instance => _instance;

  static void configure(AppUiConfig config) => _instance = config;

  AppUiConfig copyWith({
    bool? defaultAnimationEnabled,
    double? defaultBorderRadius,
    double? defaultElevation,
    bool? useMaterial3,
    bool? compactMode,
  }) {
    return AppUiConfig(
      defaultAnimationEnabled:
          defaultAnimationEnabled ?? this.defaultAnimationEnabled,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      defaultElevation: defaultElevation ?? this.defaultElevation,
      useMaterial3: useMaterial3 ?? this.useMaterial3,
      compactMode: compactMode ?? this.compactMode,
    );
  }
}

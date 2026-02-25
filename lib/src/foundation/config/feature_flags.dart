/// Runtime feature flags for conditional UI rendering.
class AppFeatureFlags {
  const AppFeatureFlags({
    this.enableDarkMode = true,
    this.enableAnimations = true,
    this.enableAnalytics = false,
    this.enableBetaFeatures = false,
    this.enableAccessibility = true,
    this.enableOfflineMode = false,
    this.enablePushNotifications = false,
  });

  final bool enableDarkMode;
  final bool enableAnimations;
  final bool enableAnalytics;
  final bool enableBetaFeatures;
  final bool enableAccessibility;
  final bool enableOfflineMode;
  final bool enablePushNotifications;

  static AppFeatureFlags _instance = const AppFeatureFlags();
  static AppFeatureFlags get instance => _instance;
  static void configure(AppFeatureFlags flags) => _instance = flags;
}

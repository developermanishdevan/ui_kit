/// Centralized list of durations to be used for components, animations, and transitions.
class AppDurations {
  AppDurations._();

  /// Very fast transition: 100ms
  static const Duration quickest = Duration(milliseconds: 100);

  /// Fast transition: 200ms
  static const Duration quick = Duration(milliseconds: 200);

  /// Normal standard transition: 300ms
  static const Duration normal = Duration(milliseconds: 300);

  /// Slow transition: 500ms
  static const Duration slow = Duration(milliseconds: 500);

  /// Very slow transition: 800ms
  static const Duration slowest = Duration(milliseconds: 800);
}

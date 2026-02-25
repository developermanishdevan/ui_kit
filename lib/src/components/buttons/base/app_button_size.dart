// lib/src/components/buttons/base/app_button_size.dart
enum AppButtonSize { compact, small, medium, large, block }

extension AppButtonSizeX on AppButtonSize {
  double get height => switch (this) {
        AppButtonSize.compact => 28,
        AppButtonSize.small => 36,
        AppButtonSize.medium => 44,
        AppButtonSize.large => 52,
        AppButtonSize.block => 52,
      };

  double get horizontalPadding => switch (this) {
        AppButtonSize.compact => 10,
        AppButtonSize.small => 16,
        AppButtonSize.medium => 20,
        AppButtonSize.large => 28,
        AppButtonSize.block => 24,
      };

  double get fontSize => switch (this) {
        AppButtonSize.compact => 12,
        AppButtonSize.small => 13,
        AppButtonSize.medium => 14,
        AppButtonSize.large => 16,
        AppButtonSize.block => 15,
      };

  double get iconSize => switch (this) {
        AppButtonSize.compact => 14,
        AppButtonSize.small => 16,
        AppButtonSize.medium => 18,
        AppButtonSize.large => 20,
        AppButtonSize.block => 18,
      };
}

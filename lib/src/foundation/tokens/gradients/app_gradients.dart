import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

/// Commonly used pre-defined UI gradients.
class AppGradients {
  AppGradients._();

  /// Standard brand gradient.
  static const LinearGradient brand = LinearGradient(
    colors: [AppColors.primary, AppColors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// A softer tone gradient.
  static const LinearGradient soft = LinearGradient(
    colors: [AppColors.gray100, AppColors.gray200],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// Gradient used for success messages or elements.
  static const LinearGradient success = LinearGradient(
    colors: [AppColors.success, AppColors.green],
  );

  /// Gradient used for error or destructive elements.
  static const LinearGradient error = LinearGradient(
    colors: [AppColors.danger, AppColors.pink],
  );
}

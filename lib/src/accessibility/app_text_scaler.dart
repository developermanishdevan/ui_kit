import 'package:flutter/material.dart';

/// Utility class for text scaling that respects device accessibility settings
/// while maintaining UI integrity through bounds.
class AppTextScaler {
  AppTextScaler._();

  /// Gets a [TextScaler] that clamps the system text scale factor between
  /// [minScaleFactor] and [maxScaleFactor].
  /// By default, it allows a max scale of 1.5x before capping, to prevent
  /// severe layout breakage while still offering good accessibility.
  static TextScaler clamped(
    BuildContext context, {
    double minScaleFactor = 0.8,
    double maxScaleFactor = 1.5,
  }) {
    final textScaler = MediaQuery.textScalerOf(context);

    // Calculate the current scale factor
    final systemScaleFactor = textScaler.scale(1.0);

    // If the system scale factor is within bounds, return the original scaler
    // to preserve any non-linear scaling behavior it might have.
    if (systemScaleFactor >= minScaleFactor &&
        systemScaleFactor <= maxScaleFactor) {
      return textScaler;
    }

    // Otherwise, return a clamped linear scaler
    final clampedScaleFactor = systemScaleFactor.clamp(
      minScaleFactor,
      maxScaleFactor,
    );
    return TextScaler.linear(clampedScaleFactor);
  }
}

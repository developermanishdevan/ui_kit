import 'package:flutter/material.dart';

extension AppColorExtensions on Color {
  /// Darkens the color by a given [percent].
  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
      (a * 255).round(),
      (r * 255 * f).round(),
      (g * 255 * f).round(),
      (b * 255 * f).round(),
    );
  }

  /// Lightens the color by a given [percent].
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
      (a * 255).round(),
      (r * 255 + ((1.0 - r) * 255 * p)).round(),
      (g * 255 + ((1.0 - g) * 255 * p)).round(),
      (b * 255 + ((1.0 - b) * 255 * p)).round(),
    );
  }

  /// Converts the color to a hex string
  String toHex({bool leadingHashSign = true}) =>
      '${leadingHashSign ? '#' : ''}'
      '${(a * 255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(r * 255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(g * 255).toInt().toRadixString(16).padLeft(2, '0')}'
      '${(b * 255).toInt().toRadixString(16).padLeft(2, '0')}';
}

import 'package:flutter/material.dart';

enum AppInputVariant { outlined, filled, underlined }

extension AppInputDecoration on AppInputVariant {
  InputBorder border(Color color, {double width = 1}) {
    return switch (this) {
      AppInputVariant.outlined => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: color, width: width),
        ),
      AppInputVariant.filled => OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      AppInputVariant.underlined => UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
        ),
    };
  }
}

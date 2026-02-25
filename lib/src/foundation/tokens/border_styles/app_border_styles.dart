import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

abstract final class AppBorderStyles {
  static const double widthThin = 1.0;
  static const double widthMedium = 1.5;
  static const double widthThick = 2.0;
  static const double widthHeavy = 3.0;

  static const BorderSide thin = BorderSide(
    color: AppColors.borderDefault,
    width: widthThin,
  );
  static const BorderSide medium = BorderSide(
    color: AppColors.borderDefault,
    width: widthMedium,
  );
  static const BorderSide focused = BorderSide(
    color: AppColors.borderFocused,
    width: widthThick,
  );
  static const BorderSide error = BorderSide(
    color: AppColors.borderError,
    width: widthThick,
  );
  static const BorderSide none = BorderSide.none;
}

import 'package:flutter/material.dart';

/// Predefined border styles for the UI Kit conforming to the design system.
class AppBorderStyles {
  AppBorderStyles._();

  static const BorderSide none = BorderSide(style: BorderStyle.none);

  static const BorderSide solidThin = BorderSide(
    style: BorderStyle.solid,
    width: 1.0,
  );

  static const BorderSide solidMedium = BorderSide(
    style: BorderStyle.solid,
    width: 2.0,
  );

  static const BorderSide solidThick = BorderSide(
    style: BorderStyle.solid,
    width: 3.0,
  );
}

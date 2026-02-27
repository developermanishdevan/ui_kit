import 'package:flutter/material.dart';

class AppShadows {
  static const BoxShadow base = BoxShadow(
    color: Color(0x07000000), // 0.03 opacity
    offset: Offset(0, 3),
    blurRadius: 4,
    spreadRadius: 0,
  );

  static const BoxShadow sm = BoxShadow(
    color: Color(0x13000000), // 0.075 opacity
    offset: Offset(0, 2), // 0.125rem
    blurRadius: 4, // 0.25rem
    spreadRadius: 0,
  );

  static const BoxShadow lg = BoxShadow(
    color: Color(0x1E1E2025), // rgba(30, 32, 37, 0.12)
    offset: Offset(0, 5),
    blurRadius: 10,
    spreadRadius: 0,
  );

  static const List<BoxShadow> none = [];

  static List<BoxShadow> button3dShadow(Color baseColor) {
    return [
      BoxShadow(
        color: baseColor.withValues(alpha: 0.5),
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.12),
        blurRadius: 0,
        offset: const Offset(0, -3),
      ),
    ];
  }
}

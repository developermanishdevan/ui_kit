import 'package:flutter/material.dart';

class AppColors {
  // Grays
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFF8F9FA);
  static const Color gray200 = Color(0xFFEEF2F7);
  static const Color gray300 = Color(0xFFD8DFE7);
  static const Color gray400 = Color(0xFFB0B0BB);
  static const Color gray500 = Color(0xFF8486A7);
  static const Color gray600 = Color(0xFF687D92);
  static const Color gray700 = Color(0xFF424E5A);
  static const Color gray800 = Color(0xFF36404A);
  static const Color gray900 = Color(0xFF21252E);
  static const Color black = Color(0xFF000000);

  // Brand Colors
  static const Color blue = Color(0xFF1A80F8);
  static const Color indigo = Color(0xFF53389F);
  static const Color purple = Color(0xFF7E67FE);
  static const Color pink = Color(0xFFFF86C8);
  static const Color red = Color(0xFFED321F);
  static const Color orange = Color(0xFFF0934E);
  static const Color yellow = Color(0xFFFB9F68);
  static const Color green = Color(0xFF21D760);
  static const Color teal = Color(0xFF040505);
  static const Color cyan = Color(0xFF1AB0F8);

  // Base Palette
  static const Color transparent = Colors.transparent;

  // Semantic Colors
  static const Color primary = purple;
  static const Color secondary = gray700;
  static const Color success = green;
  static const Color warning = orange;
  static const Color danger = red;
  static const Color info = cyan;
  static const Color light = gray200;
  static const Color dark = gray900;

  // Background Colors (Light Theme)
  static const Color bodyBg = Color(0xFFF8F7FA);
  static const Color bodyColor = Color(0xFF5D7186);

  // Background Colors (Dark Theme)
  static const Color bodyBgDark = Color(0xFF191E23); // Actually $body-bg-dark
  static const Color bodyColorDark = Color(0xFFAAB8C5);

  static const Color bodySecondaryColorDark = Color(0xFF8391A2);
  static const Color bodySecondaryBgDark = Color(0xFF1D2329);

  // Borders
  static const Color borderColor = Color(0xFFEAEDF1);
  static const Color borderColorDark = Color(0xFF272F37);
  static const Color borderColorTranslucent = Color(0x2C000000); // .175 opacity
  static const Color borderColorTranslucentDark = Color(0xFF8391A2);
}

import 'package:flutter/material.dart';

class AppRadius {
  static const double base = 5.6; // .35rem
  static const double sm = 4.0; // .25rem
  static const double lg = 8.0; // .5rem
  static const double xl = 16.0; // 1rem
  static const double xxl = 32.0; // 2rem
  static const double pill = 500.0; // 50rem

  static BorderRadius get baseRadius => BorderRadius.circular(base);
  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get xxlRadius => BorderRadius.circular(xxl);
  static BorderRadius get pillRadius => BorderRadius.circular(pill);
}

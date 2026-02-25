import 'package:flutter/material.dart';

extension WidgetExtensions on Widget {
  // Padding shortcuts
  Widget padAll(double v) => Padding(padding: EdgeInsets.all(v), child: this);
  Widget padH(double v) =>
      Padding(padding: EdgeInsets.symmetric(horizontal: v), child: this);
  Widget padV(double v) =>
      Padding(padding: EdgeInsets.symmetric(vertical: v), child: this);
  Widget padOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
        child: this,
      );

  // Margin via Container
  Widget marginAll(double v) =>
      Container(margin: EdgeInsets.all(v), child: this);

  // Sizing
  Widget withSize(double w, double h) =>
      SizedBox(width: w, height: h, child: this);
  Widget expanded([int flex = 1]) => Expanded(flex: flex, child: this);
  Widget flexible([int flex = 1]) => Flexible(flex: flex, child: this);
  Widget center() => Center(child: this);
  Widget align(AlignmentGeometry a) => Align(alignment: a, child: this);

  // Visibility
  Widget visible(bool show) => Visibility(visible: show, child: this);
  Widget opacity(double v) => Opacity(opacity: v, child: this);

  // Gestures
  Widget onTap(VoidCallback fn) => GestureDetector(onTap: fn, child: this);
  Widget inkWell(VoidCallback fn, {BorderRadius? borderRadius}) =>
      InkWell(onTap: fn, borderRadius: borderRadius, child: this);

  // Clipping
  Widget clip(double radius) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  Widget clipCircle() => ClipOval(child: this);

  // Card-like surface
  Widget card({
    double radius = 12,
    Color? color,
    List<BoxShadow>? shadows,
  }) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: shadows,
        ),
        child: this,
      );
}

// ─── BuildContext Extensions ────────────────────────────────

extension ContextExtensions on BuildContext {
  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // MediaQuery shortcuts
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  bool get isKeyboardVisible => MediaQuery.viewInsetsOf(this).bottom > 0;

  // Navigation shortcuts
  NavigatorState get navigator => Navigator.of(this);
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
  void push(Widget page, {bool replace = false}) {
    final route = MaterialPageRoute(builder: (_) => page);
    replace
        ? Navigator.of(this).pushReplacement(route)
        : Navigator.of(this).push(route);
  }
}

import 'package:flutter/material.dart';

/// Abstract base for all stateful UI Kit widgets.
abstract class AppStatefulWidget extends StatefulWidget {
  const AppStatefulWidget({super.key});
}

abstract class AppState<T extends AppStatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);
  ColorScheme get colors => Theme.of(context).colorScheme;
  TextTheme get textTheme => Theme.of(context).textTheme;
  bool get isDark => Theme.of(context).brightness == Brightness.dark;
  Size get screenSize => MediaQuery.sizeOf(context);
  EdgeInsets get screenPadding => MediaQuery.paddingOf(context);
}

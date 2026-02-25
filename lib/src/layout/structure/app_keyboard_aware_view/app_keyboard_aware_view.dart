import 'package:flutter/material.dart';

/// Scrollable view that pushes content above the keyboard.
class AppKeyboardAwareView extends StatelessWidget {
  const AppKeyboardAwareView({
    required this.child, super.key,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: padding,
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: child,
      ),
    );
  }
}

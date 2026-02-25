import 'package:flutter/material.dart';

class AppHeroWrapper extends StatelessWidget {
  const AppHeroWrapper({
    required this.tag, required this.child, super.key,
    this.transitionOnUserGestures = false,
  });

  final Object tag;
  final Widget child;
  final bool transitionOnUserGestures;

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        transitionOnUserGestures: transitionOnUserGestures,
        child: child,
      );
}

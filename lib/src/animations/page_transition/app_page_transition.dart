import 'package:flutter/material.dart';

/// Enum representing the predefined page transition types.
enum AppPageTransitionType { fade, scale, slide, size }

/// A standard page route builder that allows you to easily plug in basic
/// animations such as fade, scale, slide, and size when navigating
/// between pages using the Navigator.
class AppPageTransition<T> extends PageRouteBuilder<T> {
  final Widget child;
  final AppPageTransitionType type;

  AppPageTransition({
    required this.child,
    this.type = AppPageTransitionType.fade,
    super.settings,
    super.transitionDuration = const Duration(milliseconds: 300),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
  }) : super(
         pageBuilder: (context, animation, secondaryAnimation) => child,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           switch (type) {
             case AppPageTransitionType.fade:
               return FadeTransition(opacity: animation, child: child);
             case AppPageTransitionType.scale:
               return ScaleTransition(scale: animation, child: child);
             case AppPageTransitionType.slide:
               return SlideTransition(
                 position:
                     Tween<Offset>(
                       begin: const Offset(1.0, 0.0), // Slide from right
                       end: Offset.zero,
                     ).animate(
                       CurvedAnimation(
                         parent: animation,
                         curve: Curves.easeInOut,
                       ),
                     ),
                 child: child,
               );
             case AppPageTransitionType.size:
               return Align(
                 child: SizeTransition(
                   sizeFactor: CurvedAnimation(
                     parent: animation,
                     curve: Curves.easeInOut,
                   ),
                   child: child,
                 ),
               );
           }
         },
       );
}

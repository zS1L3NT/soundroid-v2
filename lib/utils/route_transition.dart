import 'package:flutter/material.dart';

class RouteTransition {
  static PageRouteBuilder fade(
    Widget page, {
    Duration duration = const Duration(milliseconds: 250),
  }) {
    return PageRouteBuilder(
      pageBuilder: (c, anim, anim2) => page,
      transitionsBuilder: (c, anim, anim2, child) => FadeTransition(
        opacity: anim,
        child: child,
      ),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder slide(
    Widget page, {
    required Offset from,
    Offset to = Offset.zero,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return PageRouteBuilder(
      pageBuilder: (c, anim, anim2) => page,
      transitionsBuilder: (c, anim, anim2, child) => SlideTransition(
        position: Tween<Offset>(begin: from, end: to).animate(anim),
        child: child,
      ),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }
}

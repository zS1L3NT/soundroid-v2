import 'package:flutter/material.dart';
import 'package:soundroid/utils/circular_reveal_clipper.dart';

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
      transitionsBuilder: (c, anim, anim2, child) => FadeTransition(
        opacity: anim,
        child: SlideTransition(
          position: Tween<Offset>(begin: from, end: to).animate(anim),
          child: child,
        ),
      ),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder reveal(
    Widget page, {
    required Offset center,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return PageRouteBuilder(
      pageBuilder: (c, anim, anim2) => page,
      transitionsBuilder: (c, anim, anim2, child) => ClipPath(
        child: child,
        clipper: CircularRevealClipper(
          radius: anim
              .drive(Tween(
                begin: 0.0,
                end: MediaQuery.of(c).size.height * 1.2,
              ))
              .value,
          center: center,
        ),
      ),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }
}

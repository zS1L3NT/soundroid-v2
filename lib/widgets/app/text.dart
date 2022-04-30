import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

// Credits to https://gist.github.com/rtybanana/2b0639052cd5bfd701b8d892f2d1088b
class AppText extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final TextStyle? style;
  final TextAlign textAlign;
  final double blankSpace;
  final double velocity;
  final Duration startAfter;
  final Duration pauseAfterRound;

  const AppText(
    this.text, {
    Key? key,
    required this.width,
    required this.height,
    this.style,
    this.textAlign = TextAlign.center,
    this.blankSpace = 30.0,
    this.velocity = 30.0,
    this.startAfter = const Duration(seconds: 3),
    this.pauseAfterRound = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var span = TextSpan(
          text: text,
          style: style,
        );

        var tp = TextPainter(
          maxLines: 1,
          textAlign: textAlign,
          textDirection: TextDirection.ltr,
          text: span,
        );

        tp.layout(maxWidth: width - 10);

        if (tp.didExceedMaxLines) {
          return SizedBox(
            height: height,
            width: width,
            child: Marquee(
              text: text,
              style: style,
              blankSpace: blankSpace,
              velocity: velocity,
              startAfter: startAfter,
              pauseAfterRound: pauseAfterRound,
            ),
          );
        } else {
          return SizedBox(
            width: width,
            height: height,
            child: Text(
              text,
              style: style,
              textAlign: textAlign,
            ),
          );
        }
      },
    );
  }
}

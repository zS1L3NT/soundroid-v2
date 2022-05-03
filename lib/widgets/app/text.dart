import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

// Credits to https://gist.github.com/rtybanana/2b0639052cd5bfd701b8d892f2d1088b
class AppText extends StatelessWidget {
  final String text;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double blankSpace;
  final double velocity;
  final Duration startAfter;
  final Duration pauseAfterRound;

  const AppText(
    this.text, {
    Key? key,
    required this.width,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
    this.blankSpace = 30.0,
    this.velocity = 30.0,
    this.startAfter = const Duration(seconds: 3),
    this.pauseAfterRound = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: (fontSize * 1.7) * MediaQuery.of(context).textScaleFactor,
      child: AutoSizeText(
        text,
        minFontSize: fontSize,
        maxFontSize: fontSize,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        overflowReplacement: ShaderMask(
          shaderCallback: (rectangle) => const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0, 0.01, 0.9, 1.0],
          ).createShader(rectangle),
          child: Marquee(
            text: text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            blankSpace: blankSpace,
            velocity: velocity,
            startAfter: startAfter,
            pauseAfterRound: pauseAfterRound,
          ),
        ),
      ),
    );
  }
}

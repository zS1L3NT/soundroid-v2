import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

enum TextType { ellipse, marquee }

// Credits to https://gist.github.com/rtybanana/2b0639052cd5bfd701b8d892f2d1088b
class AppText extends StatelessWidget {
  final TextType type;
  final String text;
  final double width;
  final double extraHeight;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color? color;
  final double blankSpace;
  final double velocity;
  final Duration startAfter;
  final Duration pauseAfterRound;

  const AppText(
    this.text, {
    Key? key,
    this.type = TextType.marquee,
    required this.width,
    this.extraHeight = 9,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
    this.color,
    this.blankSpace = 30.0,
    this.velocity = 30.0,
    this.startAfter = const Duration(seconds: 3),
    this.pauseAfterRound = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: (fontSize + extraHeight) * MediaQuery.of(context).textScaleFactor,
      child: type == TextType.marquee
          ? AutoSizeText(
              text,
              minFontSize: fontSize,
              maxFontSize: fontSize,
              textAlign: textAlign,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
              overflowReplacement: ShaderMask(
                shaderCallback: (rectangle) => LinearGradient(
                  colors: [
                    Colors.transparent,
                    color != null ? color! : Colors.black,
                    color != null ? color! : Colors.black,
                    Colors.transparent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0, 0.01, 0.9, 1.0],
                ).createShader(rectangle),
                child: Marquee(
                  text: text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: color,
                  ),
                  blankSpace: blankSpace,
                  velocity: velocity,
                  startAfter: startAfter,
                  pauseAfterRound: pauseAfterRound,
                ),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color,
              ),
              textAlign: textAlign,
              overflow: TextOverflow.ellipsis,
            ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

// Credits to https://gist.github.com/rtybanana/2b0639052cd5bfd701b8d892f2d1088b
class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget Function(BuildContext) child;

  static Widget marquee(
    String text, {
    double width = double.infinity,
    double extraHeight = 9,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.left,
    Color? color,
    double blankSpace = 30.0,
    double velocity = 30.0,
    Duration startAfter = const Duration(seconds: 3),
    Duration pauseAfterRound = const Duration(seconds: 3),
  }) {
    return AppText(
      child: (context) => SizedBox(
        width: width,
        height: (fontSize + extraHeight) * MediaQuery.of(context).textScaleFactor,
        child: AutoSizeText(
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
                color ?? Colors.black,
                color ?? Colors.black,
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
        ),
      ),
    );
  }

  static Widget ellipse(
    String text, {
    double width = double.infinity,
    double extraHeight = 9,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.left,
    Color? color,
  }) {
    return AppText(
      child: (context) => SizedBox(
        width: width,
        height: (fontSize + extraHeight) * MediaQuery.of(context).textScaleFactor,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child(context);
  }
}

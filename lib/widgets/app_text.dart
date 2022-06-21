import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext) builder;

  static Widget marquee(
    String text, {
    double width = double.infinity,
    double extraHeight = 9,
    TextStyle? style,
    TextAlign textAlign = TextAlign.left,
    double blankSpace = 30.0,
    double velocity = 30.0,
    Duration startAfter = const Duration(seconds: 3),
    Duration pauseAfterRound = const Duration(seconds: 3),
  }) {
    return AppText(
      builder: (context) {
        final textStyle = style ?? Theme.of(context).textTheme.bodyText2!;
        final fontSize = textStyle.fontSize ?? 14;
        return SizedBox(
          width: width,
          height: (fontSize + extraHeight) * MediaQuery.of(context).textScaleFactor,
          child: AutoSizeText(
            text,
            minFontSize: fontSize,
            maxFontSize: fontSize,
            textAlign: textAlign,
            style: style,
            overflowReplacement: ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                  colors: [
                    Colors.transparent,
                    textStyle.color ?? Colors.black,
                    textStyle.color ?? Colors.black,
                    Colors.transparent
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0, 0.01, 0.9, 1.0],
                ).createShader(rectangle);
              },
              child: Marquee(
                text: text,
                style: style,
                blankSpace: blankSpace,
                velocity: velocity,
                startAfter: startAfter,
                pauseAfterRound: pauseAfterRound,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget ellipse(
    String text, {
    double width = double.infinity,
    double extraHeight = 9,
    TextStyle? style,
    TextAlign textAlign = TextAlign.left,
  }) {
    return AppText(
      builder: (context) {
        final textStyle = style ?? Theme.of(context).textTheme.bodyText2!;
        final fontSize = textStyle.fontSize ?? 14;
        return SizedBox(
          width: width,
          height: (fontSize + extraHeight) * MediaQuery.of(context).textScaleFactor,
          child: Text(
            text,
            style: style,
            textAlign: textAlign,
            overflow: TextOverflow.ellipsis,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

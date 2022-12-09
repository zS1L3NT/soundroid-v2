import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/// A helper class for building a text widget
///
/// ### Rationale
/// - The default [Text] widget doesn't provide support for text marquee
/// - I want to abstract away the text marquee code since it is quite lengthy
/// - I want to toggle between marquee and ellipsis more easily
class AppText extends StatelessWidget {
  const AppText({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// The builder function to use to build the text widget
  final Widget Function(BuildContext) builder;

  /// Render the text and apply the marquee effect if the text is too long
  ///
  /// [extraHeight] is the extra height given to the AppText. This is needed
  /// to prevent the [Marquee] widget from accidentally marquee'ing the text
  /// when the overflow is vertical.
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

  /// Render the text and apply a ellipsis if the text is too long
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

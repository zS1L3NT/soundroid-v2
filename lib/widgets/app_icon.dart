import 'package:flutter/material.dart';

/// A helper class for building an Icon or IconButton widget
///
/// ### Rationale
/// - I repeatedly type the [IconButton.splashRadius] property on IconButtons
/// - I wanted to toggle between [Icon] and [IconButton] with much more ease
/// - It gets irritating to type "Icon" 3 times when making an [IconButton]
/// - I wanted a some convenience methods for setting the color of an Icon
/// - I wanted somewhere to store code for a loading Icon
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    Key? key,
    this.onPressed,
    this.color,
    this.size = 24,
    this.splashRadius = 20,
  }) : super(key: key);

  /// The Icon to display
  final IconData icon;

  /// The color of the [icon]
  final Color? color;

  /// The size of the [icon]
  final double size;

  /// The splash radius of the IconButton.
  ///
  /// This property only affects the AppIcon if the [onPressed] property is set.
  final double splashRadius;

  /// The click callback of the IconButton
  ///
  /// Setting this property will automatically make [AppIcon] render an [IconButton]
  /// and set it's [onPressed] property to this value.
  final Function()? onPressed;

  /// Render a [CircularProgressIndicator] that looks like an [Icon]
  static Widget loading({
    double padding = 16,
    double size = 16,
    double strokeWidth = 2,
    Color? color,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          color: color,
        ),
      ),
    );
  }

  static Widget primaryColor(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return Builder(
      builder: (context) {
        return AppIcon(
          icon,
          color: Theme.of(context).primaryColor,
          size: size,
          splashRadius: splashRadius,
          onPressed: onPressed,
        );
      },
    );
  }

  static Widget primaryColorLight(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return Builder(
      builder: (context) {
        return AppIcon(
          icon,
          color: Theme.of(context).primaryColorLight,
          size: size,
          splashRadius: splashRadius,
          onPressed: onPressed,
        );
      },
    );
  }

  static Widget primaryColorDark(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return Builder(
      builder: (context) {
        return AppIcon(
          icon,
          color: Theme.of(context).primaryColorDark,
          size: size,
          splashRadius: splashRadius,
          onPressed: onPressed,
        );
      },
    );
  }

  factory AppIcon.white(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Colors.white,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  factory AppIcon.black87(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Colors.black87,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  factory AppIcon.red(
    IconData icon, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Colors.red,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onPressed != null) {
      return IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: color,
        iconSize: size,
        splashRadius: splashRadius,
      );
    }
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}

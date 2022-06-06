import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    Key? key,
    this.onPressed,
    this.color,
    this.size = 24,
    this.splashRadius = 20,
  }) : super(key: key);

  final IconData icon;

  final Color? color;

  final double size;

  final double splashRadius;

  final Function()? onPressed;

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

  static AppIcon primaryColor(
    IconData icon,
    BuildContext context, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Theme.of(context).primaryColor,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  static AppIcon primaryColorLight(
    IconData icon,
    BuildContext context, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Theme.of(context).primaryColorLight,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  static AppIcon primaryColorDark(
    IconData icon,
    BuildContext context, {
    double size = 24,
    double splashRadius = 20,
    Function()? onPressed,
  }) {
    return AppIcon(
      icon,
      color: Theme.of(context).primaryColorDark,
      size: size,
      splashRadius: splashRadius,
      onPressed: onPressed,
    );
  }

  static AppIcon white(
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

  static AppIcon black87(
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

  static AppIcon red(
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

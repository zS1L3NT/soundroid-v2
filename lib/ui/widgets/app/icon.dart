import 'package:flutter/material.dart';

class AppIcon extends StatefulWidget {
  const AppIcon(
    this.icon, {
    Key? key,
    this.onPressed,
    this.color = Colors.black87,
    this.size = 24,
    this.splashRadius = 20,
  }) : super(key: key);

  final IconData icon;

  final Function()? onPressed;

  final Color color;

  final double size;

  final double splashRadius;

  @override
  State<AppIcon> createState() => _AppIconState();
}

class _AppIconState extends State<AppIcon> {
  @override
  Widget build(BuildContext context) {
    if (widget.onPressed != null) {
      return IconButton(
        onPressed: widget.onPressed,
        icon: Icon(widget.icon),
        color: widget.color,
        iconSize: widget.size,
        splashRadius: widget.splashRadius,
      );
    }
    return Icon(
      widget.icon,
      size: widget.size,
      color: widget.color,
    );
  }
}

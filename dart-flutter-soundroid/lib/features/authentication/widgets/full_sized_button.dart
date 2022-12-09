import 'package:flutter/material.dart';

class FullSizedButton extends StatelessWidget {
  const FullSizedButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

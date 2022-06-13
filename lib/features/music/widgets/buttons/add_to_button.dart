import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class AddToButton extends StatefulWidget {
  const AddToButton({Key? key}) : super(key: key);

  @override
  State<AddToButton> createState() => _AddToButtonState();
}

class _AddToButtonState extends State<AddToButton> {
  @override
  Widget build(BuildContext context) {
    return AppIcon.primaryColor(
      Icons.add_rounded,
      context,
      onPressed: () {},
    );
  }
}

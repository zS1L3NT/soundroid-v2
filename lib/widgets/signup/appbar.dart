import 'package:flutter/material.dart';

class SignupAppBar extends AppBar {
  SignupAppBar({Key? key}) : super(key: key);

  @override
  State<SignupAppBar> createState() => _SignupAppBarState();
}

class _SignupAppBarState extends State<SignupAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.close),
        color: Colors.black,
        splashRadius: 20,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SigninAppBar extends AppBar {
  SigninAppBar({Key? key}) : super(key: key);

  @override
  State<SigninAppBar> createState() => _SigninAppBarState();
}

class _SigninAppBarState extends State<SigninAppBar> {
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

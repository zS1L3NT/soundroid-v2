import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/widgets/widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const VerifyEmailScreen(),
    );
  }

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  int _cooldown = 60;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), checkCooldown);

    // ! Remove after prototyping stage
    // Timer(const Duration(seconds: 5), () {
    // Navigator.of(context).pushReplacement(MainScreen.route());
    // });
  }

  void checkCooldown() {
    if (_cooldown > 0) {
      setState(() {
        _cooldown--;
      });
      Timer(const Duration(seconds: 1), checkCooldown);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 2),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 100,
                height: 100,
                color: Theme.of(context).primaryColorLight,
                child: AppIcon.primaryColorDark(
                  Icons.email_rounded,
                  context,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Check your email",
              style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 300,
              child: Text(
                "We have sent a verification link to your email. Click the link to veify your email address.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: _cooldown == 0
                  ? () {
                      setState(() {
                        _cooldown = 60;
                        Timer(const Duration(seconds: 1), checkCooldown);
                      });
                    }
                  : null,
              child: Text(
                "Resend verification email${_cooldown > 0 ? " in ${_cooldown}s" : ""}",
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(WelcomeScreen.route());
              },
              child: const Text("Sign in another way"),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

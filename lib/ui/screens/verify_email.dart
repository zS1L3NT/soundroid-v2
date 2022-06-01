import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soundroid/ui/screens/main.dart';
import 'package:soundroid/ui/widgets/app/icon.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  static const routeName = "/verify_email";

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
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
    });
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
            const Text(
              "Check your email",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 300,
              child: Text(
                "We have sent a verification link to your email. Click the link to veify your email address.",
                textAlign: TextAlign.center,
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
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("/auth");
              },
              child: const Text(
                "Sign in another way",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

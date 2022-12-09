import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/widgets/widgets.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({
    Key? key,
    required this.showCountdown,
  }) : super(key: key);

  final bool showCountdown;

  static Route route(bool showCountdown) {
    return MaterialPageRoute(
      builder: (_) => VerifyEmailScreen(
        showCountdown: showCountdown,
      ),
    );
  }

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  late int _cooldown = widget.showCountdown ? 60 : 0;

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 1),
      checkCooldown,
    );

    watchEmailVerified();
  }

  void watchEmailVerified() async {
    while (true) {
      if (!mounted) break;
      if (await context.read<AuthenticationRepository>().isEmailVerified == true) {
        Navigator.of(context).pushReplacement(MainScreen.route());
        return;
      }
    }
  }

  void checkCooldown() {
    if (mounted && _cooldown > 0) {
      setState(() => _cooldown--);
      Timer(
        const Duration(seconds: 1),
        checkCooldown,
      );
    }
  }

  void resendVerification() async {
    await context.read<AuthenticationRepository>().sendVerificationEmail();
    setState(() {
      _cooldown = 60;
      Timer(
        const Duration(seconds: 1),
        checkCooldown,
      );
    });
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
              onPressed: _cooldown == 0 ? resendVerification : null,
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

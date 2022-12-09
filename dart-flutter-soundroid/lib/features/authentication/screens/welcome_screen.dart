import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/widgets/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const WelcomeScreen(),
    );
  }

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoading = false;

  void handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    final error = await context.read<AuthenticationRepository>().registerWithGoogle();
    if (error == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MainScreen.route(),
        (_) => false,
      );
    } else {
      AppSnackBar.error(error).show(context);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    AppImage.asset(
                      "assets/images/icon.png",
                      size: 128,
                    ),
                    Text(
                      "SounDroid",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Text(
                        "The Free Spotify Alternative",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ],
                ),
              ),
              FullSizedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.of(context).push(SignupScreen.route());
                      },
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Sign Up with Email"),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isLoading ? null : handleGoogleSignIn,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppImage.asset(
                        "assets/images/google-icon.png",
                        height: 21,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Sign Up with Google",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.grey[300], // foreground
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          Navigator.of(context).push(SigninScreen.route());
                        },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Already have an account? "),
                      Text(
                        "Sign In",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

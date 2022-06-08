import 'package:flutter/material.dart';
import 'package:soundroid/features/home/screens/main_screen.dart';
import 'package:soundroid/screens/auth/signin_screen.dart';
import 'package:soundroid/screens/auth/signup_screen.dart';
import 'package:soundroid/widgets/app_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const WelcomeScreen(),
    );
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SignupScreen.routeName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text("Sign Up with Email"),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      MainScreen.routeName,
                      (_) => false,
                    );
                  },
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(SigninScreen.routeName);
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

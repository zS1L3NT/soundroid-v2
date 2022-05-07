import 'package:flutter/material.dart';
import 'package:soundroid/screens/signin.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const routeName = "/auth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  Image.asset(
                    "assets/images/icon.png",
                    width: 128,
                    height: 128,
                  ),
                  const Text(
                    "SounDroid",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      "The Free Spotify Alternative",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton(
                onPressed: () {},
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text("Sign Up with Email"),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: MediaQuery.of(context).size.width - 32,
              child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
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
    );
  }
}

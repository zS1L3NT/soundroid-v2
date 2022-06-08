import 'package:flutter/material.dart';
import 'package:soundroid/features/home/screens/main_screen.dart';
import 'package:soundroid/screens/auth/forgot_password_screen.dart';
import 'package:soundroid/widgets/app_widgets.dart';
import 'package:soundroid/widgets/close_app_bar.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const SigninScreen(),
    );
  }

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome back",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Sign In with your data that you entered during your registration",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter your email address',
                      labelText: 'Email Address',
                      prefixIcon: AppIcon(Icons.email_rounded),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      errorStyle: TextStyle(height: 1),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email address cannot be empty!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your password',
                      labelText: "Password",
                      prefixIcon: const AppIcon(Icons.password_rounded),
                      contentPadding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 12,
                      ),
                      errorStyle: const TextStyle(height: 1),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: AppIcon(
                          _isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            MainScreen.routeName,
                            (_) => false,
                          );
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      SizedBox(width: 16),
                      Text("or"),
                      SizedBox(width: 16),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
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
                            "Sign In with Google",
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
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                      },
                      child: const Text("Forgot your password?"),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

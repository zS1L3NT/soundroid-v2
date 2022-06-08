import 'package:flutter/material.dart';
import 'package:soundroid/screens/auth/signin_screen.dart';
import 'package:soundroid/widgets/app_widgets.dart';
import 'package:soundroid/widgets/close_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ResetPasswordScreen(),
    );
  }

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _areObscure = [true, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CloseAppBar(),
      body: SingleChildScrollView(
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
                  "Password Recovery",
                  style: Theme.of(context).textTheme.headline2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter the email address associated with your account and we'll send an email with instructions to reset your password",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  obscureText: _areObscure[0],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    labelText: "Password",
                    prefixIcon: const AppIcon(Icons.password_rounded),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    errorStyle: const TextStyle(height: 1),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: AppIcon(
                        _areObscure[0] ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        onPressed: () {
                          setState(() {
                            _areObscure[0] = !_areObscure[0];
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
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: _areObscure[1],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password confirmation',
                    labelText: "Confirm Password",
                    prefixIcon: const AppIcon(Icons.password_rounded),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    errorStyle: const TextStyle(height: 1),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: AppIcon(
                        _areObscure[1] ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        onPressed: () {
                          setState(() {
                            _areObscure[1] = !_areObscure[1];
                          });
                        },
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password confirmation cannot be empty!';
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
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            title: const Text("Password reset!"),
                            content: const Text(
                              "Please use your new password when logging into your account.",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(dialogContext).pop();
                                },
                                child: const Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ).then(
                          (_) => Navigator.of(context)
                              .popUntil((route) => route.settings.name == SigninScreen.routeName),
                        );
                      }
                    },
                    child: const Text("Send Instructions"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

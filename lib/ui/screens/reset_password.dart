import 'package:flutter/material.dart';
import 'package:soundroid/ui/screens/signin.dart';
import 'package:soundroid/ui/widgets/close_app_bar.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static const routeName = "/reset_password";

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
                const Text(
                  "Password Recovery",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter the email address associated with your account and we'll send an email with instructions to reset your password",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  obscureText: _areObscure[0],
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password',
                    labelText: "Password",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    errorStyle: const TextStyle(height: 1),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _areObscure[0] = !_areObscure[0];
                          });
                        },
                        icon: Icon(
                          _areObscure[0] ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        ),
                        splashRadius: 20,
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
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter your password confirmation',
                    labelText: "Confirm Password",
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    errorStyle: const TextStyle(height: 1),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _areObscure[1] = !_areObscure[1];
                          });
                        },
                        icon: Icon(
                          _areObscure[1] ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                        ),
                        splashRadius: 20,
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
                              "You have successfully reset your password. Please use your new password when logging into your account.",
                              style: TextStyle(fontSize: 15),
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
                    child: const Text(
                      "Send Instructions",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
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

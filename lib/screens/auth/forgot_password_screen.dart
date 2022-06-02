import 'package:flutter/material.dart';
import 'package:soundroid/screens/auth/reset_password_screen.dart';
import 'package:soundroid/widgets/app_widgets.dart';
import 'package:soundroid/widgets/close_app_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = "/forgot_password";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

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
                  style: const TextStyle(fontSize: 15),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your email address',
                    labelText: "Email Address",
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
                            title: const Text("Check your mail"),
                            content: const Text(
                              "We have sent you an email containing the instructions to reset your password",
                              style: TextStyle(fontSize: 15),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(dialogContext).pop();
                                  Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
                                },
                                child: const Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ); //).then((_) => Navigator.of(context).pop());
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

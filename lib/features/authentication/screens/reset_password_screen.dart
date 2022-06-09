import 'package:flutter/material.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/widgets/widgets.dart';

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
  final _form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

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
            key: _form,
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
                PasswordFormField(
                  controller: _passwordController,
                  name: "Password",
                  placeholder: "Enter your password",
                ),
                const SizedBox(height: 16),
                PasswordFormField(
                  controller: _passwordConfirmController,
                  name: "Confirm Password",
                  placeholder: "Enter your password again",
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Passwords don't match";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FullSizedButton(
                  child: const Text("Reset Password"),
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      AppAlertDialog(
                        title: "Password reset!",
                        description: "Please use your new password when logging into your account.",
                        onClose: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

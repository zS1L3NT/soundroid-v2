import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/widgets/widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({
    Key? key,
    required this.code,
  }) : super(key: key);

  final String code;

  static Route route(String code) {
    return MaterialPageRoute(
      builder: (_) => ResetPasswordScreen(
        code: code,
      ),
    );
  }

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _isLoading = false;

  void handleResetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    if (await context
        .read<AuthenticationRepository>()
        .resetPassword(_passwordController.text, widget.code)) {
      AppAlertDialog(
        title: "Password reset!",
        description: "Please use your new password when logging into your account.",
        onClose: () {
          Navigator.of(context).pushAndRemoveUntil(
            WelcomeScreen.route(),
            (route) => true,
          );
          Navigator.of(context).push(
            SigninScreen.route(),
          );
        },
      ).show(context);
    } else {
      const AppSnackBar(
        text: "Password reset failed!",
        icon: Icons.close,
        color: Colors.red,
      ).show(context);
    }
    setState(() => _isLoading = false);
  }

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
                  onPressed: _isLoading ? null : handleResetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

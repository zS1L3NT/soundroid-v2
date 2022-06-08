import 'package:flutter/material.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ForgotPasswordScreen(),
    );
  }

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
                              "Check your email for instructions to reset your password",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // Navigator.of(dialogContext).pop();
                                  Navigator.of(context).push(ResetPasswordScreen.route());
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

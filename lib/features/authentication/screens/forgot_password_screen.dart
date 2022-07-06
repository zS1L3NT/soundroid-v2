import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void handleSendInstructions() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    if (await context
        .read<AuthenticationRepository>()
        .sendPasswordResetEmail(_emailController.text)) {
      AppAlertDialog(
        title: "Check your email",
        description: "Check your email for instructions to reset your password",
        onClose: Navigator.of(context).pop,
      ).show(context);
    } else {
      const AppSnackBar(
        icon: Icons.close_rounded,
        text: "Something went wrong, please try again",
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
                TextFormField(
                  controller: _emailController,
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
                FullSizedButton(
                  onPressed: _isLoading ? null : handleSendInstructions,
                  child: const Text("Send Instructions"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

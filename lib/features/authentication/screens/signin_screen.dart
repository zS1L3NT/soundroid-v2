import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/widgets/widgets.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    if (await context.read<AuthenticationRepository>().login(
          _emailController.text,
          _passwordController.text,
        )) {
      Navigator.of(context).pushAndRemoveUntil(
        MainScreen.route(),
        (_) => false,
      );
    } else {
      const AppSnackBar(
        text: "Failed to login with the provided credentials",
        icon: Icons.close_rounded,
        color: Colors.red,
      ).show(context);
    }
    setState(() => _isLoading = false);
  }

  void handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    if (await context.read<AuthenticationRepository>().signInWithGoogle()) {
      Navigator.of(context).pushAndRemoveUntil(
        MainScreen.route(),
        (_) => false,
      );
    } else {
      const AppSnackBar(
        text: "Failed to sign in with Google",
        icon: Icons.close_rounded,
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
                    controller: _emailController,
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
                  PasswordFormField(
                    controller: _passwordController,
                    name: "Password",
                    placeholder: "Enter your password",
                  ),
                  const SizedBox(height: 24),
                  FullSizedButton(
                    onPressed: _isLoading ? null : handleLogin,
                    child: const Text("Login"),
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
                    onPressed: _isLoading ? null : handleGoogleSignIn,
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
                  Center(
                    child: TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.of(context).push(ForgotPasswordScreen.route());
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

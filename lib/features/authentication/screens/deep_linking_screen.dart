import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/widgets/app_popup.dart';

class DeepLinkingScreen extends StatefulWidget {
  const DeepLinkingScreen({
    Key? key,
    required this.uri,
  }) : super(key: key);

  final Uri uri;

  static Route route(Uri uri) {
    return MaterialPageRoute(
      builder: (_) => DeepLinkingScreen(
        uri: uri,
      ),
    );
  }

  @override
  State<DeepLinkingScreen> createState() => _DeepLinkingScreenState();
}

class _DeepLinkingScreenState extends State<DeepLinkingScreen> {
  @override
  void initState() {
    super.initState();

    handleDeepLink();
  }

  void handleDeepLink() async {
    late final String mode;
    late final String code;
    try {
      mode = widget.uri.queryParameters['mode']!;
      code = widget.uri.queryParameters['code']!;
    } catch (e) {
      return const AppSnackBar(
        text: "Invalid URL",
        icon: Icons.close,
        color: Colors.red,
      ).show(context);
    }

    if (await context.read<AuthenticationRepository>().validateCode(code)) {
      switch (mode) {
        case "resetPassword":
          Navigator.of(context).pushReplacement(
            ResetPasswordScreen.route(code),
          );
          break;
      }
    } else {
      const AppSnackBar(
        text: "Invalid URL",
        icon: Icons.close,
        color: Colors.red,
      ).show(context);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

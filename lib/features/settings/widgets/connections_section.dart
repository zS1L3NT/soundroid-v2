import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/widgets/widgets.dart';

class ConnectionsSection extends StatefulWidget {
  const ConnectionsSection({Key? key}) : super(key: key);

  @override
  State<ConnectionsSection> createState() => _ConnectionsSectionState();
}

class _ConnectionsSectionState extends State<ConnectionsSection> {
  bool _isLoading = false;

  void handleGoogleConnectionToggle() async {
    final loader = AppLoader()..show(context);
    setState(() => _isLoading = true);

    try {
      if (context.read<AuthenticationRepository>().providers.contains("google.com")) {
        await context.read<AuthenticationRepository>().disconnectFromGoogle();
        const AppSnackBar(
          text: "Account disconnected from Google",
          icon: Icons.check_rounded,
        ).show(context);
      } else {
        await context.read<AuthenticationRepository>().connectToGoogle();
        const AppSnackBar(
          text: "Account connected to Google",
          icon: Icons.check_rounded,
        ).show(context);
      }
    } catch (e) {
      AppSnackBar(
        text: (e as dynamic).message,
        icon: Icons.close_rounded,
        color: Colors.red,
        duration: const Duration(seconds: 6),
      ).show(context);
    }

    setState(() => _isLoading = false);
    loader.hide(context);
  }

  @override
  Widget build(BuildContext context) {
    final providers = context.read<AuthenticationRepository>().providers;

    return SettingsGroup(
      title: "Connections",
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: (_isLoading || (providers.length == 1 && providers.contains("google.com")))
                ? null
                : handleGoogleConnectionToggle,
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
                  Text(
                    providers.contains("google.com")
                        ? "Disconnect from Google"
                        : "Connect to Google",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // background
              onPrimary: Colors.grey[300], // foreground
            ),
          ),
        ),
      ],
    );
  }
}

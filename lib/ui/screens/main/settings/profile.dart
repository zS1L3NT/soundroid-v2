import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:soundroid/ui/widgets/app_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _password = "";

  @override
  Widget build(BuildContext context) {
    return SettingsScreen(
      title: "Profile",
      children: [
        Form(
          key: _formKey,
          child: SettingsGroup(
            title: "Update Details",
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    AppImage.network(
                      "https://wiki.d-addicts.com/images/4/4c/IU.jpg",
                      borderRadius: BorderRadius.circular(32),
                      size: 64,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            AppIcon(Icons.upload_rounded),
                            Text("Upload Image"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  initialValue: "Zechariah Tan",
                  decoration: const InputDecoration(
                    hintText: 'What should we call you?',
                    labelText: 'Display Name',
                    prefixIcon: AppIcon(Icons.person_rounded),
                    contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextFormField(
                  onChanged: (password) {
                    setState(() {
                      _password = password;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Current Password (optional)',
                    prefixIcon: AppIcon(Icons.password_rounded),
                    contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                  ),
                ),
              ),
              _password.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'New Password',
                          prefixIcon: AppIcon(Icons.password_rounded),
                          contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                        ),
                      ),
                    ),
              _password.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'New Password Confirmation',
                          prefixIcon: AppIcon(Icons.password_rounded),
                          contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Profile saved!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:transparent_image/transparent_image.dart';

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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: FadeInImage.memoryNetwork(
                        fadeInCurve: Curves.decelerate,
                        placeholder: kTransparentImage,
                        image: "https://wiki.d-addicts.com/images/4/4c/IU.jpg",
                        fit: BoxFit.cover,
                        width: 64,
                        height: 64,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.upload_rounded),
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
                    icon: Icon(Icons.person_rounded),
                    hintText: 'What should we call you?',
                    labelText: 'Display Name',
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
                    icon: Icon(Icons.password_rounded),
                    labelText: 'Current Password (optional)',
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
                          icon: Icon(Icons.password_rounded),
                          labelText: 'New Password',
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
                          icon: Icon(Icons.password_rounded),
                          labelText: 'New Password Confirmation',
                          contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 4),
                        ),
                      ),
                    ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

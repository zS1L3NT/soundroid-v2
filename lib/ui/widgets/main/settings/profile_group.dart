import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:soundroid/ui/screens/main/settings/profile.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileGroup extends StatelessWidget {
  const ProfileGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsGroup(
      title: "Profile",
      children: [
        const SizedBox(height: 8),
        SimpleSettingsTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.memoryNetwork(
              fadeInCurve: Curves.decelerate,
              placeholder: kTransparentImage,
              image: "https://wiki.d-addicts.com/images/4/4c/IU.jpg",
              fit: BoxFit.cover,
              width: 40,
              height: 40,
            ),
          ),
          title: "Zechariah Tan",
          subtitle: "2100326D@student.tp.edu.sg",
          child: const ProfileScreen(),
        ),
      ],
    );
  }
}

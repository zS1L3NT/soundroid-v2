import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileGroup extends SettingsGroup {
  ProfileGroup({Key? key})
      : super(
          title: "Profile",
          children: [
            const SizedBox(height: 8),
            ExpandableSettingsTile(
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
              children: [],
            ),
          ],
        );
}

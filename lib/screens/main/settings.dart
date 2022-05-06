import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: FadeInImage.memoryNetwork(
                  fadeInCurve: Curves.decelerate,
                  placeholder: kTransparentImage,
                  image: "https://wiki.d-addicts.com/images/4/4c/IU.jpg",
                  fit: BoxFit.cover,
                  width: 96,
                  height: 96,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                children: [
                  AppText.marquee(
                    "Zechariah Tan",
                    width: MediaQuery.of(context).size.width - 144,
                    extraHeight: 11,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  AppText.marquee(
                    "2100326D@student.tp.edu.sg",
                    width: MediaQuery.of(context).size.width - 144,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

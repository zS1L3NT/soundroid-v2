import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
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
                  width: MediaQuery.of(context).size.width - 152,
                  extraHeight: 11,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                AppText.marquee(
                  "2100326D@student.tp.edu.sg",
                  width: MediaQuery.of(context).size.width - 152,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

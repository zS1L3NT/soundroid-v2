import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class Section extends StatelessWidget {
  const Section({
    Key? key,
    required this.section,
  }) : super(key: key);

  final Map<String, dynamic> section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section["type"] == "track"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  section["title"],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : const SizedBox(),
        section["type"] == "track"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  section["description"],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              )
            : const SizedBox(),
        section["type"] == "artist"
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(24)),
                      child: FadeInImage.memoryNetwork(
                        fadeInCurve: Curves.decelerate,
                        placeholder: kTransparentImage,
                        image: section["artist"]["picture"],
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      "More from ",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      section["artist"]["name"],
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
        const SizedBox(height: 12),
        SizedBox(
          height: 186,
          child: ShaderMask(
            shaderCallback: (rectangle) => const LinearGradient(
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0, 0.05, 0.9, 1],
            ).createShader(rectangle),
            blendMode: BlendMode.dstIn,
            child: NotificationListener(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 24),
                  for (final track in section["items"]) ...[
                    SizedBox(
                      width: 125,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: FadeInImage.memoryNetwork(
                              fadeInCurve: Curves.decelerate,
                              placeholder: kTransparentImage,
                              image: track.thumbnail,
                              fit: BoxFit.cover,
                              width: 125,
                              height: 125,
                            ),
                          ),
                          const SizedBox(height: 6),
                          AppText.marquee(
                            track.title,
                            width: 125,
                          ),
                          AppText.marquee(
                            track.artists,
                            width: 125,
                            fontSize: 14,
                            extraHeight: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24)
                  ]
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

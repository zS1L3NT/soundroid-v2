import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

class YourPlaylistsSection extends StatefulWidget {
  const YourPlaylistsSection({Key? key}) : super(key: key);

  @override
  State<YourPlaylistsSection> createState() => _YourPlaylistsSectionState();
}

class _YourPlaylistsSectionState extends State<YourPlaylistsSection> {
  final List<Playlist> _playlists = [
    Playlist(
      name: "Korean Songs",
      userId: "",
      thumbnail:
          "https://thebiaslistcom.files.wordpress.com/2020/11/gfriend-mago.jpg",
      trackIds: [],
    ),
    Playlist(
      name: "IU Best Songs",
      userId: "",
      thumbnail:
          "https://img.i-scmp.com/cdn-cgi/image/fit=contain,width=425,format=auto/sites/default/files/styles/768x768/public/d8/images/methode/2019/05/15/c436a58e-73e5-11e9-b91a-87f62b76a5ee_image_hires_115320.jpg?itok=3c74LGuO&v=1557892405",
      trackIds: [],
    ),
    Playlist(
      name: "OSTs",
      userId: "",
      thumbnail:
          "https://i.scdn.co/image/ab67616d0000b273a1f0a8d516a2b7448b2ccc8b",
      trackIds: [],
    ),
    Playlist(
      name: "EDM Songs",
      userId: "",
      thumbnail:
          "https://upload.wikimedia.org/wikipedia/en/d/da/Alan_Walker_-_Faded.png",
      trackIds: [],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
          child: Text(
            "Your Playlists",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        for (var playlist in _playlists)
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 8, left: 16),
            child: Material(
              elevation: 8,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: ShaderMask(
                      shaderCallback: (rectangle) => const LinearGradient(
                        colors: [Colors.black, Colors.transparent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.5, 1.0],
                      ).createShader(rectangle),
                      blendMode: BlendMode.dstIn,
                      child: FadeInImage.memoryNetwork(
                        fadeInCurve: Curves.decelerate,
                        placeholder: kTransparentImage,
                        image: playlist.thumbnail,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  AppText(
                    playlist.name,
                    height: 24,
                    width: MediaQuery.of(context).size.width - 124,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}

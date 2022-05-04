import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/widgets/main/library/playlist_item.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _playlists = [
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 4),
          PlaylistItem(
            playlist: Playlist(
              name: "Liked Songs",
              userId: "",
              thumbnail:
                  "https://media-exp1.licdn.com/dms/image/C5603AQH44a3q4YZIzQ/profile-displayphoto-shrink_800_800/0/1634632712439?e=1657152000&v=beta&t=GVQpTq83TxzfMnok37IolQPJXvpau3_wIedhS8GTvIc",
              trackIds: [],
            ),
          ),
        ],
      ),
    );
  }
}

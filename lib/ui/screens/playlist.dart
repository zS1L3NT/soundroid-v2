import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:indexed/indexed.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/ui/widgets/app_widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  static const routeName = "/playlist";

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _playlist = Playlist(
    userRef: FirebaseFirestore.instance.collection("-").doc("-"),
    name: "Korean Songs",
    thumbnail: "https://thebiaslistcom.files.wordpress.com/2020/11/gfriend-mago.jpg",
    favourite: true,
    trackIds: [],
  );

  final _tracks = [
    Track(
      id: "",
      title: "MAGO",
      artistIds: ["GFRIEND"],
      thumbnail:
          "https://static.wikia.nocookie.net/gfriend/images/5/51/GFriend_Walpurgis_Night_Digital_Cover.jpg/revision/latest?cb=20201109125023",
    ),
    Track(
      id: "",
      title: "LA DI DA",
      artistIds: ["EVERGLOW"],
      thumbnail: "https://kbopped.files.wordpress.com/2020/09/la-di-da.jpg",
    ),
    Track(
      id: "",
      title: "Voltage",
      artistIds: ["ITZY"],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b273aecb87fd2574ad79b05cc024",
    ),
    Track(
      id: "",
      title: "Odd Eye",
      artistIds: ["Dreamcatcher"],
      thumbnail:
          "https://colorcodedlyrics.com/wp-content/uploads/2021/01/Dreamcatcher-Dystopia-Road-to-Utopia.jpg",
    ),
    Track(
      id: "",
      title: "Ven Para",
      artistIds: ["Weeekly"],
      thumbnail: "https://images.genius.com/63812adc796134af85c3e8146dc016ef.600x600x1.jpg",
    ),
    Track(
      id: "",
      title: "Black Mamba",
      artistIds: ["aespa"],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/e/e4/Aespa_-_Black_Mamba.png",
    ),
    Track(
      id: "",
      title: "WA DA DA",
      artistIds: ["Kep1er"],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b2732963187314262831fa2baa49",
    ),
    Track(
      id: "",
      title: "TOMBOY",
      artistIds: ["(G)I-DLE"],
      thumbnail: "https://images.genius.com/c5c5b9daef8abffc860437ebd500e555.1000x1000x1.png",
    ),
    Track(
      id: "",
      title: "Why Not?",
      artistIds: ["LOONA"],
      thumbnail:
          "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2020/09/LOONA-1200.jpg?w=640&ssl=1",
    ),
    Track(
      id: "",
      title: "Step Back",
      artistIds: ["GOT the beat"],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/b/b0/Got_the_Beat_-_Step_Back.jpg",
    ),
    Track(
      id: "",
      title: "PLAYING WITH FIRE",
      artistIds: ["BLACKPINK"],
      thumbnail: "https://images.genius.com/4cb3a383634155a13f8db8594a79d27d.600x600x1.jpg",
    ),
    Track(
      id: "",
      title: "PTT (Paint The Town)",
      artistIds: ["LOONA"],
      thumbnail: "https://images.genius.com/b17668a45799ad30aadb722111d5124c.300x300x1.jpg",
    ),
    Track(
      id: "",
      title: "D-D-DANCE",
      artistIds: ["IZ*ONE"],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/8/80/Dddance.jpg",
    ),
    Track(
      id: "",
      title: "LOCO",
      artistIds: ["ITZY"],
      thumbnail: "https://i.ytimg.com/vi/-6gdPbihCNk/maxresdefault.jpg",
    ),
    Track(
      id: "",
      title: "Not Shy",
      artistIds: ["ITZY"],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/9/9a/Itzy_-_Not_Shy.jpg",
    ),
    Track(
      id: "",
      title: "WANNABE",
      artistIds: ["ITZY"],
      thumbnail:
          "https://popgasa1.files.wordpress.com/2020/03/81382519_1583735274558_1_600x600.jpg",
    ),
    Track(
      id: "",
      title: "달라달라 (DALLA DALLA)",
      artistIds: ["ITZY"],
      thumbnail:
          "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/02/ITZY-IT%E2%80%99z-Different.jpg?fit=600%2C600&ssl=1",
    ),
    Track(
      id: "",
      title: "SO BAD",
      artistIds: ["STAYC"],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b273bc125f40131dd5869b2ec36c",
    ),
    Track(
      id: "",
      title: "Rollin'",
      artistIds: ["Brave Girls"],
      thumbnail:
          "https://static.wikia.nocookie.net/kpop/images/0/04/Brave_Girls_Rollin%27_revised_digital_cover_art.png/revision/latest?cb=20210302021641",
    ),
    Track(
      id: "",
      title: "SMILEY(Feat. BIBI)",
      artistIds: ["YENA, BIBI"],
      thumbnail:
          "https://seoulbeats.com/wp-content/uploads/2022/01/20220123_seoulbeats_yena_smiley_cover.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PlaylistHeader(
              playlist: _playlist,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) => AppListItem.fromTrack(
                _tracks[index],
                onTap: () {},
              ),
              childCount: _tracks.length,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
        ],
      ),
    );
  }
}

class PlaylistHeader extends SliverPersistentHeaderDelegate {
  final double extendedHeight = 200 - kToolbarHeight;

  const PlaylistHeader({
    Key? key,
    required this.playlist,
  });

  final Playlist playlist;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = 1 - max(0, extendedHeight - shrinkOffset) / extendedHeight;

    final primaryColorWhiteTween = ColorTween(
      begin: Theme.of(context).scaffoldBackgroundColor,
      end: Theme.of(context).primaryColor,
    ).lerp(progress);

    final blackWhiteTween = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).lerp(progress);

    return Indexer(
      children: [
        Indexed(
          index: progress == 1 ? 3 : 1,
          child: AppBar(
            elevation: 0,
            leading: AppIcon(
              Icons.arrow_back_rounded,
              color: blackWhiteTween,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: (shrinkOffset - 100) > 0 ? 1 : 0,
              child: Text(playlist.name),
            ),
            actions: [
              AppIcon(
                Icons.more_vert_rounded,
                color: blackWhiteTween,
                onPressed: () {},
              ),
            ],
            backgroundColor: primaryColorWhiteTween,
          ),
        ),
        Indexed(
          index: 2,
          child: Positioned(
            bottom: 0,
            child: Opacity(
              opacity: 1 - progress,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: FadeInImage.memoryNetwork(
                        fadeInCurve: Curves.decelerate,
                        placeholder: kTransparentImage,
                        image: playlist.thumbnail,
                        fit: BoxFit.cover,
                        width: 128,
                        height: 128,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Material(
                        color: primaryColorWhiteTween,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.marquee(
                              playlist.name,
                              extraHeight: 12,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            AppText.marquee(
                              "${playlist.trackIds.length} tracks",
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                AppIcon.primaryColor(
                                  Icons.favorite_rounded,
                                  context,
                                  onPressed: () {},
                                ),
                                AppIcon.primaryColor(
                                  Icons.download_done_rounded,
                                  context,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => extendedHeight + kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

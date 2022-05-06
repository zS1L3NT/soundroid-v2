import 'dart:math';

import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:soundroid/models/playlist.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              splashRadius: 20,
              color: blackWhiteTween,
            ),
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: (shrinkOffset - 100) > 0 ? 1 : 0,
              child: Text(playlist.name),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                splashRadius: 20,
                color: blackWhiteTween,
              ),
              const SizedBox(width: 8)
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                    Material(
                      color: primaryColorWhiteTween,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.marquee(
                            playlist.name,
                            width: MediaQuery.of(context).size.width,
                            extraHeight: 12,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          AppText.marquee(
                            "${playlist.trackIds.length} tracks",
                            width: MediaQuery.of(context).size.width,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.favorite),
                                splashRadius: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.download_done),
                                splashRadius: 20,
                                color: Theme.of(context).primaryColor,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.more_vert),
                                splashRadius: 20,
                              ),
                            ],
                          ),
                        ],
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

import 'package:flutter/material.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:soundroid/features/playlists/playlists.dart';
import 'package:soundroid/widgets/widgets.dart';

class YourPlaylistsSection extends StatelessWidget {
  const YourPlaylistsSection({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist>? playlists;

  @override
  Widget build(BuildContext context) {
    if (playlists == null) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Playlists",
            style: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
          Text(
            "A list of your recent playlists",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 76 * playlists!.length - 12,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: playlists!.length,
              itemBuilder: (context, index) {
                final playlist = playlists![index];

                return Material(
                  elevation: 8,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        PlaylistScreen.route(playlist),
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: ShaderMask(
                            shaderCallback: (rectangle) {
                              return const LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.5, 1.0],
                              ).createShader(rectangle);
                            },
                            blendMode: BlendMode.dstIn,
                            child: Hero(
                              tag: "playlist_${playlist.id}",
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: AppImage.network(
                                  playlist.thumbnail,
                                  size: 64,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppText.marquee(
                            playlist.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            ),
          ),
        ],
      ),
    );
  }
}

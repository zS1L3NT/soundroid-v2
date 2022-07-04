import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class HorizontalTracks extends StatelessWidget {
  const HorizontalTracks({
    Key? key,
    required this.tracks,
  }) : super(key: key);

  final List<Track> tracks;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ShaderMask(
        shaderCallback: (rectangle) {
          return const LinearGradient(
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0, 0.05, 0.9, 1],
          ).createShader(rectangle);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
          itemCount: tracks.length,
          separatorBuilder: (context, index) {
            return const SizedBox(width: 24);
          },
          itemBuilder: (context, index) {
            final track = tracks[index];

            return StreamBuilder<bool>(
              stream: context.read<ApiRepository>().isOnlineStream,
              builder: (context, snap) {
                final isEnabled = snap.data == true ||
                    context.read<DownloadManager>().downloaded.contains(track.id);

                return Column(
                  children: [
                    Stack(
                      children: [
                        Opacity(
                          opacity: isEnabled ? 1 : 0.5,
                          child: AppImage.network(
                            track.thumbnail,
                            borderRadius: BorderRadius.circular(8),
                            size: 128,
                          ),
                        ),
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: const Color.fromRGBO(0, 0, 0, 0.4),
                              borderRadius: BorderRadius.circular(8),
                              onTap: isEnabled
                                  ? () {
                                      context.read<MusicProvider>().playTrackIds([track.id]);
                                    }
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Opacity(
                      opacity: isEnabled ? 1 : 0.5,
                      child: AppText.marquee(
                        track.title,
                        width: 125,
                      ),
                    ),
                    Opacity(
                      opacity: isEnabled ? 1 : 0.5,
                      child: AppText.marquee(
                        track.artists.map((artist) => artist.name).join(", "),
                        width: 125,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

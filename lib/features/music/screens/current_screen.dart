import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  late final _player = context.read<PlayingProvider>().player;
  late final _queue = context.read<PlayingProvider>().queue;

  @override
  void initState() {
    super.initState();

    print(_queue.tracks.map((track) => track.title));
    if (_queue.length > 0) {
      return;
    }
    _queue.addTrack(
      Track(
        id: "sqgxcCjD04s",
        title: "Strawberry Moon",
        artists: [
          const Artist(
            id: "UCTUR0sVEkD8T5MlSHqgaI_Q",
            name: "IU",
          ),
        ],
        thumbnail: "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
      ),
    );
    _queue.addTrack(
      Track(
        id: "v7bnOxV4jAc",
        title: "Lilac",
        artists: [
          const Artist(
            id: "UCTUR0sVEkD8T5MlSHqgaI_Q",
            name: "IU",
          ),
        ],
        thumbnail: "https://upload.wikimedia.org/wikipedia/en/4/41/IU_-_Lilac.png",
      ),
    );
    _queue.addTrack(
      Track(
        id: "D1PvIWdJ8xo",
        title: "Blueming",
        artists: [
          const Artist(
            id: "UCTUR0sVEkD8T5MlSHqgaI_Q",
            name: "IU",
          ),
        ],
        thumbnail: "https://i.imgur.com/evzC1EV.jpg",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const CoverImage(),
            const Spacer(flex: 2),
            Row(
              children: [
                const LikeButton(),
                const SizedBox(width: 8),
                Expanded(
                  child: StreamBuilder<int?>(
                    stream: _player.currentIndexStream,
                    builder: (context, snap) {
                      final current = snap.data != null ? _queue.tracks[snap.data!] : null;

                      return Column(
                        children: [
                          AppText.marquee(
                            current?.title ?? "...",
                            width: size.width,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                          AppText.marquee(
                            current?.artists.map((artist) => artist.name).join(", ") ?? "...",
                            width: size.width,
                            style: Theme.of(context).textTheme.subtitle1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                const AddToButton(),
              ],
            ),
            const Spacer(flex: 3),
            const PositionSlider(),
            const Spacer(),
            Row(
              children: const [
                ShuffleButton(),
                Spacer(),
                SkipPreviousButton(),
                Spacer(),
                PlayPauseButton(),
                Spacer(),
                SkipNextButton(),
                Spacer(),
                RepeatButton(),
              ],
            ),
            const Spacer(flex: 3),
            const VolumeSlider(),
          ],
        ),
      ),
    );
  }
}

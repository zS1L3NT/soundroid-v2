import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/utils/utils.dart';
import 'package:soundroid/widgets/widgets.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({Key? key}) : super(key: key);

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends KeptAliveState<CurrentScreen> {
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
                  child: StreamBuilder<Track?>(
                    stream: context.read<MusicProvider>().current,
                    builder: (context, snap) {
                      return Column(
                        children: [
                          AppText.marquee(
                            snap.data?.title ?? "...",
                            width: size.width,
                            style: Theme.of(context).textTheme.headline4,
                            textAlign: TextAlign.center,
                          ),
                          AppText.marquee(
                            snap.data?.artists.map((artist) => artist.name).join(", ") ?? "...",
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

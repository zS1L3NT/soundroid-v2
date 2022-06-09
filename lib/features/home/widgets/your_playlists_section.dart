import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class YourPlaylistsSection extends StatelessWidget {
  YourPlaylistsSection({Key? key}) : super(key: key);

  final _playlists = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          const SizedBox(height: 12),
          for (final playlist in _playlists) ...[
            Material(
              elevation: 8,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Row(
                children: [
                  AppImage.networkPlaylistFade(playlist.thumbnail),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppText.marquee(playlist.name),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
          ]
        ],
      ),
    );
  }
}

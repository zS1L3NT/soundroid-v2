import 'package:api_repository/api_repository.dart';
import 'package:audio_service/audio_service.dart' show AudioService, AudioServiceConfig;
import 'package:flutter/material.dart';
import 'package:music_service/src/audio_handler.dart';

class MusicService extends ChangeNotifier {
  late AudioHandler _handler;

  void setup() async {
    _handler = await AudioService.init<AudioHandler>(
      builder: () => AudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.zectan.soundroid.channel.audio',
        androidNotificationChannelName: 'Music playback',
        androidNotificationOngoing: true,
        androidStopForegroundOnPause: true,
      ),
    );

    _handler.playbackState.stream.listen(print);

    _handler.playbackState.stream.listen((state) {});
  }

  void playTracks(List<Track> tracks, [int index = 0]) {
    _handler.playTracks(tracks, index);
  }

  Stream<Track?> get current => Stream.empty();
}

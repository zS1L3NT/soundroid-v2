import 'package:api_repository/api_repository.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _tracks = <Track>[];
  int _queueIndex = 0;

  AudioHandler() {
    Rx.combineLatest2(
      player.positionStream,
      player.durationStream,
      (position, duration) {
        if (position == duration) {
          skipToNext();
          _playFirst();
        }
        // player.setAudioSource()
      },
    ).listen((_) {});
  }

  final player = AudioPlayer();

  @override
  Future<void> play() async => player.play();

  @override
  Future<void> pause() async => player.pause();

  @override
  Future<void> stop() async => player.stop();

  @override
  Future<void> seek(Duration position) async => player.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async => _queueIndex = index;

  Future<void> _playFirst() async {
    playbackState.add(
      PlaybackState(
        queueIndex: _queueIndex,
      ),
    );
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(
          "http://soundroid.zectan.com/api/download?videoId=${_tracks[_queueIndex].id}",
        ),
      ),
    );
    player.play();

    await Future.delayed(Duration(seconds: 5));
    await player.seek(Duration(minutes: 3, seconds: 15));
  }

  void playTracks(List<Track> tracks, int index) async {
    _tracks.clear();
    _tracks.addAll(tracks);
    await _playFirst();
  }
}

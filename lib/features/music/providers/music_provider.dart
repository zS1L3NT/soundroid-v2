import 'package:api_repository/api_repository.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundroid/utils/utils.dart';

class MusicProvider with ChangeNotifier {
  MusicProvider(this._apiRepo) {
    current.listen((current) {
      if (current != null) {
        _currentThumbnail = current.thumbnail;
        notifyListeners();
      }
    });

    _queue = QueueAudioSource(
      children: [],
      apiRepo: _apiRepo,
    );
  }

  void setup() async {
    _session = await AudioSession.instance;
    await _session.configure(const AudioSessionConfiguration.music());
  }

  late final AudioSession _session;
  final _player = AudioPlayer();
  late final QueueAudioSource _queue;
  final ApiRepository _apiRepo;

  String? _currentThumbnail;
  List<Track>? _selected;

  String? get currentThumbnail => _currentThumbnail;

  List<Track>? get selected => _selected;

  AudioPlayer get player => _player;

  QueueAudioSource get queue => _queue;

  Stream<Track?> get current => Rx.combineLatest2<List<IndexedAudioSource>?, int?, Track?>(
        _player.sequenceStream,
        _player.currentIndexStream,
        (sequence, currentIndex) {
          if (sequence == null || currentIndex == null) return null;
          if (sequence.length <= currentIndex) return null;
          return sequence[currentIndex] as Track?;
        },
      );

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }

  Future<void> playTrackIds(List<String> trackIds, [int from = 0]) async {
    await _player.stop();
    await _player.seek(const Duration());
    await _queue.clear();
    await _queue.addTracks(
      await Future.wait<Track>([
        ...trackIds.sublist(from, trackIds.length),
        ...trackIds.sublist(0, from)
      ].map(_apiRepo.getTrack)),
    );
    await _player.play();
  }
}

import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundroid/utils/utils.dart';

class MusicProvider with ChangeNotifier {
  MusicProvider({
    required this.listenRepo,
    required this.apiRepo,
  }) {
    current.listen((current) {
      if (current != null) {
        _currentThumbnail = current.thumbnail;
        notifyListeners();
      }
    });

    _setupListenTracker();
  }

  final ListenRepository listenRepo;
  final ApiRepository apiRepo;

  final _player = AudioPlayer();
  AudioPlayer get player => _player;

  late final _queue = QueueAudioSource(children: [], apiRepo: apiRepo);
  QueueAudioSource get queue => _queue;

  String? _currentThumbnail;
  String? get currentThumbnail => _currentThumbnail;

  List<Track>? _selected;
  List<Track>? get selected => _selected;

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }

  Stream<Track?> get current => Rx.combineLatest2<List<IndexedAudioSource>?, int?, Track?>(
        _player.sequenceStream,
        _player.currentIndexStream,
        (sequence, currentIndex) {
          if (sequence == null || currentIndex == null) return null;
          if (sequence.length <= currentIndex) return null;
          return sequence[currentIndex] as Track?;
        },
      );

  void _setupListenTracker() {
    bool stored = false;
    Track? track;
    Duration listened = Duration.zero;
    Duration prevPosition = Duration.zero;

    _player.createPositionStream().listen((position) {
      if (position < const Duration(milliseconds: 500)) {
        stored = false;
        listened = Duration.zero;
      }

      final difference = position - prevPosition;
      if (difference > Duration.zero && difference < const Duration(seconds: 1)) {
        listened += difference;
        if (listened > const Duration(seconds: 30) && !stored && track != null) {
          stored = true;
          listenRepo.addRecord(track!.id);
        }
      }

      prevPosition = position;
    });

    current.listen((current) => track = current);
  }

  Future<void> playTrackIds(List<String> trackIds, [int from = 0]) async {
    await _player.stop();
    await _player.seek(Duration.zero, index: 0);
    await _queue.clear();
    await _queue.addTracks(
      await Future.wait<Track>([
        ...trackIds.sublist(from, trackIds.length),
        ...trackIds.sublist(0, from)
      ].map(apiRepo.getTrack)),
    );
    await _player.play();
  }
}

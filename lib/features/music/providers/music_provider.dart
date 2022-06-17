import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundroid/utils/utils.dart';

class MusicProvider with ChangeNotifier {
  String _currentThumbnail = "";
  List<Track>? _selected;
  final _player = AudioPlayer();
  final _queue = QueueAudioSource(children: []);

  String get currentThumbnail => _currentThumbnail;

  List<Track>? get selected => _selected;

  AudioPlayer get player => _player;

  QueueAudioSource get queue => _queue;

  Stream<Track?> get current => Rx.combineLatest2<List<IndexedAudioSource>?, int?, Track?>(
        _player.sequenceStream,
        _player.currentIndexStream,
        (sequence, currentIndex) {
          if (sequence == null || currentIndex == null) return null;
          return sequence[currentIndex] as Track?;
        },
      );

  set currentThumbnail(String thumbnail) {
    _currentThumbnail = thumbnail;
    notifyListeners();
  }

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }
}

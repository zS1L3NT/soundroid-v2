import 'package:api_repository/api_repository.dart';
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

  final ApiRepository _apiRepo;

  String? _currentThumbnail;
  List<Track>? _selected;
  final _player = AudioPlayer();
  late QueueAudioSource _queue;

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
}

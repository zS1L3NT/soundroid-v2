import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:soundroid/utils/queue_audio_source.dart';

class PlayingProvider with ChangeNotifier {
  List<Track>? _selected;
  final _player = AudioPlayer();
  final _queue = QueueAudioSource(children: []);

  List<Track>? get selected => _selected;

  AudioPlayer get player => _player;

  QueueAudioSource get queue => _queue;

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }
}

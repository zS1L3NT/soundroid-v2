import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';

class PlayingProvider with ChangeNotifier {
  List<Track>? _selected;

  List<Track>? get selected => _selected;

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }
}

import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';

class PlayingProvider with ChangeNotifier {
  List<Track>? _selected;

  List<Track>? get selected => _selected;

  set selected(List<Track>? selected) {
    _selected = selected;
    notifyListeners();
  }
}

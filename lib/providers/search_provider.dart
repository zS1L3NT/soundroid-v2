import 'package:flutter/material.dart';
import 'package:soundroid/models/search_result.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController _textEditingController = TextEditingController();
  String _query = "";
  bool _isLoading = false;
  List<String>? _suggestions;
  Map<String, List<SearchResult>>? _results;

  TextEditingController get textEditingController => _textEditingController;
  String get query => _query;
  bool get isLoading => _isLoading;
  List<String>? get suggestions => _suggestions;
  Map<String, List<SearchResult>>? get results => _results;

  set textEditingController(TextEditingController textEditingController) {
    _textEditingController = textEditingController;
    notifyListeners();
  }

  set query(String query) {
    _query = query;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set suggestions(List<String>? suggestions) {
    _suggestions = suggestions;
    notifyListeners();
  }

  set results(Map<String, List<SearchResult>>? results) {
    _results = results;
    notifyListeners();
  }
}

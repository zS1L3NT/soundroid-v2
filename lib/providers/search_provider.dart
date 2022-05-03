import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController _textEditingController = TextEditingController();
  String _query = "";
  // ignore: prefer_function_declarations_over_variables
  Function() _onSearch = () {};
  bool _isLoading = false;
  Map<String, List<Map<String, String>>>? _results;

  TextEditingController get textEditingController => _textEditingController;
  String get query => _query;
  Function() get onSearch => _onSearch;
  bool get isLoading => _isLoading;
  Map<String, List<Map<String, String>>>? get results => _results;

  set textEditingController(TextEditingController textEditingController) {
    _textEditingController = textEditingController;
    notifyListeners();
  }

  set query(String query) {
    _query = query;
    notifyListeners();
  }

  set onSearch(Function() onSearch) {
    _onSearch = onSearch;
    notifyListeners();
  }

  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set results(Map<String, List<Map<String, String>>>? results) {
    _results = results;
    notifyListeners();
  }
}

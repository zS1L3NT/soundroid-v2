import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _query = "";

  String get query => _query;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }
}

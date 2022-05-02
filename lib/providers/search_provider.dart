import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _query = "";
  // ignore: prefer_function_declarations_over_variables
  Function() _onSearch = () {};

  String get query => _query;
  Function() get onSearch => _onSearch;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void setOnSearch(Function() onSearch) {
    _onSearch = onSearch;
    notifyListeners();
  }
}

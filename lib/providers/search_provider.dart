import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/helpers/api_helper.dart';
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

  // This method is moved into the provider so it can be called from multiple places
  void search(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.suggestions = null;
    searchProvider.results = await ApiHelper.fetchSearchResults(searchProvider);
  }
}

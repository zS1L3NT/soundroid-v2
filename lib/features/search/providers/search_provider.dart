import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/search/search.dart';

class SearchProvider with ChangeNotifier {
  final _textEditingController = TextEditingController();
  DateTime _latest = DateTime.fromMicrosecondsSinceEpoch(0);
  bool _isLoading = false;
  List<String> _recentSuggestions = [];
  List<String> _apiSuggestions = [];
  SearchResults? _results;

  TextEditingController get controller => _textEditingController;

  String get query => _textEditingController.text;

  DateTime get latest => _latest;

  bool get isLoading => _isLoading;

  List<Suggestion> get suggestions => [
        ..._recentSuggestions.map(
          (suggestion) => Suggestion(
            type: SuggestionType.recent,
            text: suggestion,
          ),
        ),
        ..._apiSuggestions.where((suggestion) => !_recentSuggestions.contains(suggestion)).map(
              (suggestions) => Suggestion(
                type: SuggestionType.api,
                text: suggestions,
              ),
            ),
      ];

  SearchResults? get results => _results;

  set query(String? query) {
    if (query == null) {
      _textEditingController.clear();
    } else {
      _textEditingController.text = query;
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
    }
    notifyListeners();
  }

  set latest(DateTime latest) {
    _latest = latest;
    notifyListeners();
  }

  set recentSuggestions(List<String> recentSuggestions) {
    _recentSuggestions = recentSuggestions;
    notifyListeners();
  }

  set apiSuggestions(List<String> apiSuggestions) {
    _apiSuggestions = apiSuggestions;
    notifyListeners();
  }

  set results(SearchResults? results) {
    _results = results;
    notifyListeners();
  }

  // This method is moved into the provider so it can be called from multiple places
  void search(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final dateTime = DateTime.now();
    _apiSuggestions = [];
    _isLoading = true;
    notifyListeners();

    final results = await context.read<ApiRepository>().getSearchResults(query);
    if (dateTime.isAfter(latest) || dateTime == latest) {
      _isLoading = false;
      _results = results;
      notifyListeners();
    }
  }
}

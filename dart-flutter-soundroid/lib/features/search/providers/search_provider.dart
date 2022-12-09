import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/features/search/search.dart';

class SearchProvider with ChangeNotifier {
  SearchProvider({
    required this.apiRepo,
    required this.searchRepo,
  });

  final ApiRepository apiRepo;
  final SearchRepository searchRepo;

  /// The [TextEditingController] for the search app bar text field
  TextEditingController get controller => _textEditingController;
  final _textEditingController = TextEditingController();

  String get query => _textEditingController.text;

  /// Changes the text within the search app bar text field.
  ///
  /// This method should be used sparingly and not on every key press.
  set query(String? query) {
    if (query == null) {
      _textEditingController.clear();
    } else {
      _textEditingController.text = query;
      _textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: query.length),
      );
    }

    handleTextChange(query ?? "");
  }

  bool get hasError => _hasError;
  bool _hasError = false;

  /// If search results are loading
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// A list of suggestions which are aware of what type of suggestion it is
  /// e.g. API Suggestion (Suggestion from SounDroid API) or Recent Search (Suggestion from the user's recent searches)
  List<Suggestion> get suggestions => [
        ..._recentSuggestions.map(
          (suggestion) => Suggestion(
            type: SuggestionType.recent,
            text: suggestion,
          ),
        ),
        // If the api suggestion is already suggested above, don't suggest it again
        ..._apiSuggestions.where((suggestion) => !_recentSuggestions.contains(suggestion)).map(
              (suggestions) => Suggestion(
                type: SuggestionType.api,
                text: suggestions,
              ),
            ),
      ];
  List<String> _recentSuggestions = [];
  List<String> _apiSuggestions = [];

  /// Search results from the SounDroid API
  SearchResults? get results => _results;
  SearchResults? _results;

  /// The date that search suggestion last received new data
  DateTime _lastChangedAt = DateTime.fromMicrosecondsSinceEpoch(0);

  void handleTextChange(String query) async {
    /// The date that the current search queries for the [query] was made
    final changedAt = DateTime.now();
    _results = null;
    _hasError = false;

    // If the query is empty, show the recent searches instead
    if (query == "") {
      _lastChangedAt = changedAt;
      _isLoading = false;
      _apiSuggestions = [];
      notifyListeners();
      return;
    }

    apiRepo.getSearchSuggestions(query).then((apiSuggestions) {
      // If when the data comes back and _lastChangedAt is later than changedAt,
      // this means that a query that happened after this request returned a
      // value faster than this, rendering this data as useless, therefore we
      // ignore the data from this api call.
      if (_lastChangedAt.isAfter(changedAt)) return;

      _apiSuggestions = apiSuggestions;
      _lastChangedAt = changedAt;
      notifyListeners();
    }).catchError((e) {
      debugPrint("ERROR ApiRepository.getSearchSuggestions(): $e");
    });

    searchRepo.getRecentSearches(query).then((recentSuggestions) {
      // If when the data comes back and _lastChangedAt is later than changedAt,
      // this means that a query that happened after this request returned a
      // value faster than this, rendering this data as useless, therefore we
      // ignore the data from this api call.
      if (_lastChangedAt.isAfter(changedAt)) return;

      _recentSuggestions = recentSuggestions;
      _lastChangedAt = changedAt;
      notifyListeners();
    });
  }

  /// This method is moved into the provider so it can be called from multiple places
  void search(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final changedAt = DateTime.now();
    _apiSuggestions = [];
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      final results = await apiRepo.getSearchResults(query);

      // If when the data comes back and _lastChangedAt is later than changedAt,
      // this means that a query that happened after this request returned a
      // value faster than this, rendering this data as useless, therefore we
      // ignore the data from this api call.
      if (_lastChangedAt.isAfter(changedAt)) return;

      _results = results;
    } catch (e) {
      _hasError = true;
      debugPrint("ERROR ApiRepository.getSearchResults(): $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}

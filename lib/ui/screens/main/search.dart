import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/models/search.dart';
import 'package:soundroid/models/user.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/ui/widgets/main/search/recommendation_item.dart';
import 'package:soundroid/ui/widgets/app/list_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchesStream = Search.collection
      .where("userRef", isEqualTo: User.collection.doc("jnbZI9qOLtVsehqd6ICcw584ED93"))
      .orderBy("timestamp", descending: true)
      .limit(10)
      .snapshots();

  Widget buildRecents(SearchProvider searchProvider) {
    return StreamBuilder<QuerySnapshot<Search>>(
      stream: _searchesStream,
      builder: (context, snap) {
        if (snap.hasError) {
          debugPrint(snap.error.toString());
          return const Center(
            child: Text("Something went wrong"),
          );
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snap.data!.docs.length,
          itemBuilder: (context, index) {
            return RecommendationItem.recent(snap.data!.docs[index].data().query);
          },
        );
      },
    );
  }

  Widget buildRecommendations(SearchProvider searchProvider) {
    return ListView.builder(
      itemCount: searchProvider.recommendations.length,
      itemBuilder: (context, index) {
        final recommendation = searchProvider.recommendations[index];
        switch (recommendation[0]) {
          case "recent":
            return RecommendationItem.recent(recommendation[1]);
          case "suggestion":
            return RecommendationItem.suggestion(recommendation[1]);
          default:
            throw Error();
        }
      },
    );
  }

  Widget buildSearchResults(SearchProvider searchProvider) {
    return ListView.builder(
      itemCount:
          searchProvider.results!["tracks"]!.length + searchProvider.results!["albums"]!.length,
      itemBuilder: (context, index) {
        final results = [
          ...searchProvider.results!["tracks"]!,
          ...searchProvider.results!["albums"]!
        ];
        return AppListItem.fromSearchResult(
          results[index],
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeIn,
      child: searchProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : searchProvider.results != null
              ? buildSearchResults(searchProvider)
              : searchProvider.query != ""
                  ? buildRecommendations(searchProvider)
                  : buildRecents(searchProvider),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/widgets/main/search/recent_item.dart';
import 'package:soundroid/widgets/main/search/search_result_item.dart';
import 'package:soundroid/widgets/main/search/search_suggestion_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final history = [
    "iu lilac",
    "iu llac",
    "iu strawbrry moon",
    "mago gfriend",
    "invu taeyeon",
    "taeyeon",
    "weeekly holiday paty",
    "iu bluemin",
    "hotel del lna ost",
    "scarlet heart ost",
    "what's wrong with secretary kim ost",
    "it's okay to not be okay ost",
    "goblin the lonely and great god ost"
  ];

  final searchSuggestionsApiData = const [
    "iu lilac",
    "iu lilac cover english a b c d e f g",
    "iu lilac live",
    "iu lilac slowed and reverb",
    "iu lilac album",
    "iu lilac edit audio",
    "iu lilac for 1 hour"
  ];

  final searchApiData = const {
    "tracks": [
      {
        "id": "04tYkKUPPv4",
        "title": "LILAC (라일락)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/-tdq58fAgaawQcx744mZUP67379plUJcWvzPSyfRy305ZmNcYii54WboN9OBa4I-cEdzu7u5yW4nSFlBQA=w120-h120-l90-rj"
      },
      {
        "id": "ZThVobEtp_o",
        "title": "Celebrity",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/uBaev32PTrIygjVxDjBSItjcpXexyBn96cI_y_MupxUyj5fqdRLywaVXuB9s5obmr47n8oLc_CGZmfFB=w120-h120-l90-rj"
      },
      {
        "id": "TqIAndOnd74",
        "title": "My sea (아이와 나의 바다)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/-tdq58fAgaawQcx744mZUP67379plUJcWvzPSyfRy305ZmNcYii54WboN9OBa4I-cEdzu7u5yW4nSFlBQA=w120-h120-l90-rj"
      },
      {
        "id": "E787kCVAeL8",
        "title": "Flu (Flu)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/-tdq58fAgaawQcx744mZUP67379plUJcWvzPSyfRy305ZmNcYii54WboN9OBa4I-cEdzu7u5yW4nSFlBQA=w120-h120-l90-rj"
      },
      {
        "id": "dk22oBpplKA",
        "title": "Coin (Coin)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/-tdq58fAgaawQcx744mZUP67379plUJcWvzPSyfRy305ZmNcYii54WboN9OBa4I-cEdzu7u5yW4nSFlBQA=w120-h120-l90-rj"
      }
    ],
    "albums": [
      {
        "id": "MPREb_iG5q5DIdhdA",
        "title": "IU 5th Album 'LILAC' (IU 5th Album 'LILAC')",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/-tdq58fAgaawQcx744mZUP67379plUJcWvzPSyfRy305ZmNcYii54WboN9OBa4I-cEdzu7u5yW4nSFlBQA=w544-h544-l90-rj"
      },
      {
        "id": "MPREb_8KC1n75czX3",
        "title": "Lilac",
        "artists": "DooPiano",
        "thumbnail":
            "https://lh3.googleusercontent.com/qdZ7ZaWMixrq3tGT7707v5Mw0U5UBxqt9eHVmX0Qd6gydU1-24VcOHOTFa6zEqEzqWIs_AIV53rchCKx=w544-h544-l90-rj"
      },
      {
        "id": "MPREb_10BDz68kZeP",
        "title": "strawberry moon (strawberry moon)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/SZ5mBUus0ipBuOGnrMFNh5sOHZm7EG1EJRrZxAq-RfszLbduUI-wOBmsqYhQh-RFCFBx_z170zy-2fUnYw=w544-h544-l90-rj"
      },
      {
        "id": "MPREb_pkGseOcFtRy",
        "title": "BBIBBI",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/MGMyYgKGVBWN5Nws_Re-d5VtLikXCHevL3MDMI7CGaXCtrpMNNxRu8xH44nIhSnKoePBDcDxNQHvoSAb=w544-h544-l90-rj"
      },
      {
        "id": "MPREb_LGfX8CNIRaL",
        "title": "eight (feat. SUGA)",
        "artists": "IU",
        "thumbnail":
            "https://lh3.googleusercontent.com/raCvjGEtKIiRpduJYDcfclLVqh4LfiESAZU5XxODLlZ2XhCvJ7GCfhrWJ1XD4NiV8oirCVujMsrs-b6C=w544-h544-l90-rj"
      }
    ]
  };

  void fetchResults() {
    if (!context.read<SearchProvider>().isLoading) {
      context.read<SearchProvider>().isLoading = true;
      context.read<SearchProvider>().results = null;
      Future.delayed(const Duration(seconds: 1), () {
        context.read<SearchProvider>().isLoading = false;
        context.read<SearchProvider>().results = searchApiData;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Initialize the setOnSearch method in the SearchProvider
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<SearchProvider>().onSearch = fetchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    final search = context.watch<SearchProvider>();
    return search.isLoading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Column(
                children: search.results != null
                    ? [
                        ...search.results!["tracks"]!
                            .map<Widget>(
                              (track) => SearchResultItem(
                                type: SearchResultType.track,
                                title: track["title"]!,
                                description: track["artists"]!,
                                thumbnail: track["thumbnail"]!,
                              ),
                            )
                            .toList(),
                        ...search.results!["albums"]!
                            .map<Widget>(
                              (track) => SearchResultItem(
                                type: SearchResultType.album,
                                title: track["title"]!,
                                description: track["artists"]!,
                                thumbnail: track["thumbnail"]!,
                              ),
                            )
                            .toList(),
                      ]
                    : search.query.isEmpty
                        ? history
                            .map((search) => RecentItem(text: search))
                            .toList()
                        : searchSuggestionsApiData
                            .map((suggestion) =>
                                SearchSuggestionItem(text: suggestion))
                            .toList(),
              ),
            ),
          );
  }
}

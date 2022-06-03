import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soundroid/models/search_result.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/providers/search_provider.dart';

class Server {
  static bool inDevelopment = false;

  static String get host =>
      inDevelopment ? "http://localhost:5190/api" : "http://soundroid.zectan.com/api";

  static Future<List<Map<String, dynamic>>> fetchFeed() async {
    final response = await get(Uri.parse("$host/feed"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch feed");
    }
  }

  static Future<List<String>> fetchSearchSuggestions(SearchProvider searchProvider) async {
    final response = await get(Uri.parse("$host/suggestions?query=${searchProvider.query}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search suggestions");
    }
  }

  static Future<Map<String, List<SearchResult>>> fetchSearchResults(
      SearchProvider searchProvider) async {
    searchProvider.isLoading = true;
    final response = await get(Uri.parse("$host/search?query=${searchProvider.query}"));

    searchProvider.isLoading = false;
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return <String, List<SearchResult>>{
        "tracks": data["tracks"]!
            .map((tracks) => SearchResult.fromJson(Map.from(tracks)))
            .toList()
            .cast<SearchResult>(),
        "albums": data["albums"]!
            .map((albums) => SearchResult.fromJson(Map.from(albums)))
            .toList()
            .cast<SearchResult>(),
      };
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search results");
    }
  }

  static Future<List<String>> fetchLyrics(Track track) async {
    final response = await get(Uri.parse("$host/lyrics?query=${track.title} IU"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch lyrics");
    }
  }

  static Future<Track> fetchTrack(String id) async {
    if (Track.box.containsKey(id)) {
      return Track.box.get(id)!;
    }

    final response = await get(Uri.parse("$host/track?id=$id"));

    if (response.statusCode == 200) {
      final track = Track.fromJson(jsonDecode(response.body));
      Track.box.put(id, track);
      return track;
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch track");
    }
  }
}

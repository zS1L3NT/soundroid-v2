import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import 'models/models.dart';

class ApiRepository {
  String get _host => "http://soundroid.zectan.com/api";
  final _trackBox = Hive.box<Track>('tracks');

  Future<List<Map<String, dynamic>>> fetchFeed() async {
    final response = await get(Uri.parse("$_host/feed"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<Map<String, dynamic>>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch feed");
    }
  }

  Future<List<String>> fetchSearchSuggestions(String query) async {
    final response = await get(Uri.parse("$_host/suggestions?query=$query"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search suggestions");
    }
  }

  Future<Map<String, List<SearchResult>>> fetchSearchResults(String query) async {
    final response = await get(Uri.parse("$_host/search?query=$query"));

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

  Future<List<String>> fetchLyrics(Track track) async {
    final response = await get(Uri.parse("$_host/lyrics?query=${track.title} IU"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch lyrics");
    }
  }

  Future<Track> fetchTrack(String id) async {
    if (_trackBox.containsKey(id)) {
      return _trackBox.get(id)!;
    }

    final response = await get(Uri.parse("$_host/track?id=$id"));

    if (response.statusCode == 200) {
      final track = Track.fromJson(jsonDecode(response.body));
      _trackBox.put(id, track);
      return track;
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch track");
    }
  }
}

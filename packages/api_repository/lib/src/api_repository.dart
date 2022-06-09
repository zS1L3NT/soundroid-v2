import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import 'models/models.dart';

class ApiRepository {
  const ApiRepository({
    required this.trackBox,
  });

  final Box<Track> trackBox;

  String get _host => "http://soundroid.zectan.com/api";

  Future<List<FeedSection>> getFeed() async {
    final response = await get(Uri.parse("$_host/feed"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List).map((section) {
        switch (section["type"]) {
          case "track":
            return TrackSection.fromJson(section);
          case "artist":
            return ArtistSection.fromJson(section);
          default:
            throw UnsupportedError("Unsupported section type: ${section.type}");
        }
      }).toList();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch feed");
    }
  }

  Future<List<String>> getSearchSuggestions(String query) async {
    final response = await get(Uri.parse("$_host/suggestions?query=$query"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search suggestions");
    }
  }

  Future<SearchResults> getSearchResults(String query) async {
    final response = await get(Uri.parse("$_host/search?query=$query"));

    if (response.statusCode == 200) {
      return SearchResults.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search results");
    }
  }

  Future<List<String>> getLyrics(Track track) async {
    final response = await get(Uri.parse("$_host/lyrics?query=${track.title} IU"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch lyrics");
    }
  }

  Future<Track> getTrack(String id) async {
    if (trackBox.containsKey(id)) {
      return trackBox.get(id)!;
    }

    final response = await get(Uri.parse("$_host/track?id=$id"));

    if (response.statusCode == 200) {
      final track = Track.fromJson(jsonDecode(response.body));
      trackBox.put(id, track);
      return track;
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch track");
    }
  }
}

import 'dart:convert';

import 'package:api_repository/src/models/models.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

/// The API Repository contains all API calls to the SounDroid API.
class ApiRepository {
  const ApiRepository({
    required this.trackBox,
  });

  /// Hive Box for [Track] instances.
  ///
  /// This is a local cache of [Track] instances, stored like a HashMap
  /// with the [Track.id] as the key and the [Track] as the data.
  ///
  /// This cache is used to avoid making unnecessary API calls to fetch [Track] instances
  /// which have already been returned by the API before.
  final Box<Track> trackBox;

  /// The base URL for the SounDroid API
  String get _host => "http://soundroid.zectan.com/api";

  /// Fetch the home feed for the currently authenticated user
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

  /// Fetch search suggestions related to a [query]
  Future<List<String>> getSearchSuggestions(String query) async {
    final response = await get(Uri.parse("$_host/suggestions?query=${Uri.encodeComponent(query)}"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search suggestions");
    }
  }

  /// Fetch search results related to a [query]
  ///
  /// Caches all track results in the [trackBox] for future usage.
  Future<SearchResults> getSearchResults(String query) async {
    final response = await get(Uri.parse("$_host/search?query=${Uri.encodeComponent(query)}"));

    if (response.statusCode == 200) {
      final searchResults = SearchResults.fromJson(jsonDecode(response.body));

      for (final track in searchResults.tracks) {
        if (!trackBox.containsKey(track.id)) {
          trackBox.put(track.id, track);
        }
      }

      return SearchResults.fromJson(jsonDecode(response.body));
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch search results");
    }
  }

  /// Fetch lyrics for a [track]
  Future<List<String>> getLyrics(Track track) async {
    final response = await get(
      Uri.parse(
        "$_host/lyrics?query=${Uri.encodeComponent(track.title)} ${Uri.encodeComponent(track.artists.map((artist) => artist.name).join(" "))}",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch lyrics");
    }
  }

  /// Fetch the track ids of all tracks in an album by the album [id]
  Future<List<String>> getAlbumTrackIds(String id) async {
    final response = await get(Uri.parse("$_host/album?id=$id"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).cast<String>();
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch album tracks");
    }
  }

  /// Fetch a [Track] by its YouTube Video ID.
  ///
  /// If the [Track] has already been cached by Hive, it will be returned synchronously from there.
  /// If not, fetch the [Track] from the API, then cache the [Track].
  Future<Track> getTrack(String id) async {
    if (trackBox.containsKey(id)) {
      return trackBox.get(id)!;
    }

    final response = await get(Uri.parse("$_host/track?id=$id"));

    if (response.statusCode == 200) {
      final track = Track.fromJson(jsonDecode(response.body));
      trackBox.put(id, track); // Caching of Track happens here
      return track;
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch track");
    }
  }

  /// Fetch the content length of a youtube video's audio
  Future<int> getLength(String trackId) async {
    final response = await get(Uri.parse("$_host/length?videoId=$trackId"));

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      debugPrint(response.body);
      throw Exception("Failed to fetch length");
    }
  }

  /// Check if the app can connect to the server
  Future<bool> checkConnection() async {
    final response = await get(Uri.parse("$_host/connecttest"));
    return response.statusCode == 200;
  }
}

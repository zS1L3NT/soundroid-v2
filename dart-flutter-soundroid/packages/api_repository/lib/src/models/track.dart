import 'dart:io';

import 'package:api_repository/src/models/models.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:soundroid/env.dart';

part 'track.g.dart';

/// Track model returned by the SounDroid API
/// - `@CopyWith`
/// - `@HiveType`
/// - `@JSONSerializable`
/// - `ProgressiveAudioSource`
///
/// This class extends [ProgressiveAudioSource] so that it can be
/// added to a music queue as an AudioSource.
@CopyWith()
@HiveType(typeId: 0)
@JsonSerializable()
class Track extends ProgressiveAudioSource {
  static late Directory directory;

  Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
    bool online = false,
  }) : super(
          Uri.parse(
            online ? "$API_URL/api/download?videoId=$id" : "file://${directory.path}/$id.mp3",
          ),
          tag: MediaItem(
            id: id,
            title: title,
            artist: artists.map((artist) => artist.name).join(", "),
            artUri: Uri.parse(thumbnail),
          ),
        );

  Track online() {
    return Track(
      id: id,
      title: title,
      artists: artists,
      thumbnail: thumbnail,
      online: true,
    );
  }

  /// The ID of the Track from YouTube
  @HiveField(0)
  final String id;

  /// The title of the Track
  @HiveField(1)
  final String title;

  /// The artists of the Track
  @HiveField(2)
  final List<Artist> artists;

  /// The thumbnail of the Track
  @HiveField(3)
  final String thumbnail;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);

  @override
  bool operator ==(Object other) => other is Track && other.id == id;

  @override
  int get hashCode => hashValues(id, title, hashList(artists), thumbnail);

  @override
  String toString() {
    return "Track { $id; $title; ${artists.join(", ")} }";
  }
}

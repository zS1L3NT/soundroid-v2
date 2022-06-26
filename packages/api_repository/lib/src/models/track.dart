import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'models.dart';

part 'track.g.dart';

@CopyWith()
@HiveType(typeId: 0)
@JsonSerializable()
class Track extends ProgressiveAudioSource {
  Track({
    required this.id,
    required this.title,
    required this.artists,
    required this.thumbnail,
  }) : super(
          Uri.parse("http://soundroid.zectan.com/api/download?videoId=$id"),
          tag: MediaItem(
            id: id,
            title: title,
            artist: artists.map((artist) => artist.name).join(", "),
            artUri: Uri.parse(thumbnail),
          ),
        );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<Artist> artists;

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

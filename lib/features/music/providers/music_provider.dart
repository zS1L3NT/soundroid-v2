import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soundroid/utils/utils.dart';

class MusicProvider with ChangeNotifier {
  MusicProvider({
    required this.apiRepo,
    required this.listenRepo,
  }) {
    current.listen((current) {
      if (current != null) {
        _currentThumbnail = current.thumbnail;
        notifyListeners();
      }
    });

    _setupListenTracker();
  }

  final ApiRepository apiRepo;
  final ListenRepository listenRepo;

  AudioPlayer get player => _player;
  final _player = AudioPlayer();

  QueueAudioSource? get queue => _player.audioSource as QueueAudioSource?;

  String? get currentThumbnail => _currentThumbnail;
  String? _currentThumbnail;

  /// The current playing track
  ///
  /// I used [Rx.combineLatest2] to combine two streams and listen to both of them at once.
  Stream<Track?> get current => Rx.combineLatest2<List<IndexedAudioSource>?, int?, Track?>(
        _player.sequenceStream,
        _player.currentIndexStream,
        (sequence, currentIndex) {
          if (sequence == null || currentIndex == null) return null;
          if (sequence.length <= currentIndex) return null;
          return sequence[currentIndex] as Track;
        },
      );

  /// Creates a listen tracker records that you've listened to a track.
  ///
  /// Once a user listens to a song for 30s, a record of a listen is created.
  /// Seeking the song does not affect how long the user has listened to the song.
  ///
  /// There probably isn't any way to cheat this listen tracker into thinking
  /// you've listened to a song more than you actually have
  void _setupListenTracker() {
    /// If the current playing track has already been stored
    /// and doesn't need to be stored again
    bool stored = false;

    /// The current playing track
    Track? track;

    /// How you have listened to the current track for
    Duration listened = Duration.zero;

    /// The position of the player in the previous output of the stream
    ///
    /// Used to detect the time difference between the previous output
    /// and the current output, so I know when a user used the
    /// seek bar to change the position of the player.
    Duration prevPosition = Duration.zero;

    _player.createPositionStream().listen((position) {
      // If the current position is < 500ms, take it that a new song is playing
      // regardless of whether the user seeked the player here.
      if (position < const Duration(milliseconds: 500)) {
        stored = false;
        listened = Duration.zero;
      }

      /// The difference in timing between the previous output and the current output
      final difference = position - prevPosition;

      // If the difference is < 0s, the track was seeked backwards, ignore
      // If the difference is > 1s, the track was seeked forwards, ignore
      if (difference > Duration.zero && difference < const Duration(seconds: 1)) {
        // Add the difference to the accumulated time of listening to the current track
        listened += difference;

        // If the user has listened to the current track for 30s
        // AND a record for this has not already been stored,
        // AND the current track is not null (what will the player be playing then!?! but either ways it's good to be safe)
        if (listened > const Duration(seconds: 30) && !stored && track != null) {
          stored = true;
          listenRepo.addRecord(track!.id);
        }
      }

      // Update the previous position to the current position
      prevPosition = position;
    });

    // Update the current track when the player changes tracks
    current.listen((current) => track = current);
  }

  /// Stops the player, clears the queue, and plays the given [trackIds].
  ///
  /// Starts from the [from] position if defined or the first item in the queue.
  Future<void> playTrackIds(List<String> trackIds, [int from = 0]) async {
    await _player.stop();
    await _player.setAudioSource(
      QueueAudioSource(
        children: await Future.wait<Track>([
          ...trackIds.sublist(from, trackIds.length),
          ...trackIds.sublist(0, from)
        ].map(apiRepo.getTrack)),
        apiRepo: apiRepo,
      ),
    );
    await _player.play();
  }
}

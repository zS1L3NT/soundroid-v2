import 'dart:io';
import 'dart:typed_data';

import 'package:api_repository/api_repository.dart';
import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:playlist_repository/playlist_repository.dart';

class DownloadManager extends ChangeNotifier {
  DownloadManager({
    required this.apiRepo,
    required this.playlistRepo,
  });

  final ApiRepository apiRepo;
  final PlaylistRepository playlistRepo;
  late final Directory _directory;

  /// The queue of pending downloads
  ///
  /// If null, no downloads are ongoing
  List<String>? get queue => _queue;
  List<String>? _queue;

  /// The list of tracks currently downloaded
  late final _downloaded =
      _directory.listSync().map((file) => file.path.split("/").last.split(".").first).toList();

  void setup() async {
    _directory = Directory((await getApplicationDocumentsDirectory()).path + "/tracks");
    if (!_directory.existsSync()) _directory.createSync();

    playlistRepo.getDownloadedTrackIds().listen((trackIds) {
      calculateListDiff(
        _downloaded + (queue ?? []),
        trackIds,
        detectMoves: false,
      ).getUpdatesWithData().forEach((change) {
        change.when(
          insert: (_, trackId) {
            download(trackId);
          },
          remove: (_, trackId) {
            // If the track doesn't need to be downloaded, delete it to save space.
            _queue?.remove(trackId);
            _downloaded.remove(trackId);

            final file = getFile(trackId);
            if (file.existsSync()) file.deleteSync();
          },
          change: (_, __, ___) {},
          move: (_, __, ___) {},
        );
      });
    });
  }

  File getFile(String trackId) => File("${_directory.path}/$trackId.mp3");

  void download(String trackId) async {
    if (_queue != null && !_queue!.contains(trackId)) {
      _queue!.add(trackId);
      notifyListeners();
      return;
    }

    _queue = [trackId];
    notifyListeners();

    while (true) {
      if (_queue!.isEmpty) break;

      final trackId = _queue!.first;
      final file = getFile(trackId);
      if (file.existsSync()) continue;

      List<List<int>> chunks = [];
      int downloaded = 0;

      debugPrint("Fetching length of $trackId...");
      final url = Uri.parse("http://soundroid.zectan.com/api/download?videoId=$trackId");
      final response = await Client().send(Request("GET", url));
      final contentLength = await apiRepo.getLength(trackId);

      await for (final chunk in response.stream) {
        if (_queue?.isEmpty ?? _queue!.first != trackId) break;
        debugPrint(
          "Downloading $trackId: ${(downloaded / contentLength * 100).toStringAsFixed(2)}%",
        );

        chunks.add(chunk);
        downloaded += chunk.length;
      }

      if (_queue?.isEmpty ?? _queue!.first != trackId) {
        debugPrint("Download of $trackId cancelled");
        continue;
      }

      debugPrint("Saving $trackId...");
      final bytes = Uint8List(contentLength);
      int offset = 0;
      for (final chunk in chunks) {
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      await file.writeAsBytes(bytes);
      debugPrint("Saved $trackId!");

      _queue!.remove(trackId);
      _downloaded.add(trackId);
      notifyListeners();
    }

    _queue = null;
    notifyListeners();
  }
}

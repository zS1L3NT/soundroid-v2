import 'dart:io';
import 'dart:typed_data';

import 'package:api_repository/api_repository.dart';
import 'package:awesome_notifications/android_foreground_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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

  final notificationId = 16051993;
  final notificationChannelKey = "track_download_progress";

  final ApiRepository apiRepo;
  final PlaylistRepository playlistRepo;
  late final Directory _directory;

  /// The queue of pending downloads
  ///
  /// If null, no downloads are ongoing
  List<String>? get queue => _queue;
  List<String>? _queue;

  /// Last time the download notification was updated
  DateTime _lastNotificationUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  /// The list of tracks currently downloaded
  List<String> get downloaded => _downloaded;
  late final _downloaded =
      _directory.listSync().map((file) => file.path.split("/").last.split(".").first).toList();

  double? get downloadProgress => _downloadProgress;
  double? _downloadProgress;

  void setup() async {
    _directory = Directory((await getApplicationDocumentsDirectory()).path + "/tracks");
    if (!_directory.existsSync()) _directory.createSync();

    playlistRepo.getDownloadedTrackIds().listen((trackIds) {
      calculateListDiff(_downloaded + (queue ?? []), trackIds)
          .getUpdatesWithData()
          .forEach((change) {
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

    apiRepo.getTrack(trackId).then((track) {
      AndroidForegroundService.startForeground(
        content: NotificationContent(
          id: notificationId,
          channelKey: notificationChannelKey,
          title: "Downloading ${_queue!.length} tracks",
          progress: 0,
          notificationLayout: NotificationLayout.ProgressBar,
        ),
      );
    });

    while (true) {
      if (_queue!.isEmpty) break;

      final trackId = _queue!.first;
      final file = getFile(trackId);
      if (file.existsSync()) continue;

      List<List<int>> chunks = [];
      int downloaded = 0;

      final url = Uri.parse("http://soundroid.zectan.com/api/download?videoId=$trackId");
      final response = await Client().send(Request("GET", url));

      int? contentLength;
      try {
        contentLength = await apiRepo.getLength(trackId);
      } catch (e) {
        debugPrint("Could not get file size, using indeterminate");
      }

      await for (final chunk in response.stream) {
        if (_queue?.isEmpty ?? _queue!.first != trackId) break;
        _downloadProgress = contentLength != null ? (downloaded / contentLength) : null;
        _updateNotification(trackId, _downloadProgress != null ? _downloadProgress! * 100 : null);
        notifyListeners();

        chunks.add(chunk);
        downloaded += chunk.length;
      }

      if (_queue?.isEmpty ?? _queue!.first != trackId) {
        continue;
      }
      _downloadProgress = 1;
      _updateNotification(trackId, 100);
      notifyListeners();

      final bytes = Uint8List(downloaded);
      int offset = 0;
      for (final chunk in chunks) {
        bytes.setRange(offset, offset + chunk.length, chunk);
        offset += chunk.length;
      }
      await file.writeAsBytes(bytes);

      _queue!.remove(trackId);
      _downloaded.add(trackId);
      _downloadProgress = 0;
      notifyListeners();
    }

    _queue = null;
    _downloadProgress = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    AndroidForegroundService.stopForeground();
  }

  void _updateNotification(String trackId, double? percent) {
    if (DateTime.now().difference(_lastNotificationUpdate).inSeconds < 1) return;
    _lastNotificationUpdate = DateTime.now();

    apiRepo.getTrack(trackId).then((track) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: notificationId,
          channelKey: notificationChannelKey,
          title: "Downloading ${_queue?.length} tracks",
          body: "${track.title} - ${track.artists.map((artist) => artist.name).join(", ")} " +
              (percent != null ? "(${percent.toStringAsFixed(2)}%)" : ""),
          progress: percent?.round(),
          notificationLayout: NotificationLayout.ProgressBar,
        ),
      );
    });
  }
}

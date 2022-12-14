import 'dart:io';

import 'package:api_repository/api_repository.dart';
import 'package:audio_session/audio_session.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/app.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Track.directory = Directory((await getApplicationDocumentsDirectory()).path + "/tracks");

  // Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(ArtistAdapter());
  Hive.registerAdapter(TrackAdapter());
  final trackBox = await Hive.openBox<Track>("tracks");

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Perfect Volume Control
  PerfectVolumeControl.hideUI = true;

  // Initialize Audio Session
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.zectan.soundroid.audio',
    androidNotificationChannelName: 'Music',
    androidNotificationOngoing: true,
  );
  (await AudioSession.instance).configure(
    const AudioSessionConfiguration.music(),
  );

  // Initialize Notification Channels
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'track_download_progress',
        channelName: 'Track Download Progress',
        channelDescription: 'Notification channel track download progress',
        defaultColor: const Color(0xFF126DFF),
        ledColor: Colors.white,
        importance: NotificationImportance.Low,
        playSound: false,
        enableVibration: false,
      )
    ],
  );

  FlutterNativeSplash.remove();

  final authenticationRepo = AuthenticationRepository();

  runApp(
    MultiRepositoryProvider(
      // Initialize all repositories as providers
      providers: [
        RepositoryProvider(
          create: (_) => ApiRepository(
            trackBox: trackBox,
            getIdToken: authenticationRepo.getTokenId,
          ),
        ),
        RepositoryProvider(
          create: (_) => authenticationRepo,
        ),
        RepositoryProvider(
          create: (_) => ListenRepository(),
        ),
        RepositoryProvider(
          create: (_) => PlaylistRepository(),
        ),
        RepositoryProvider(
          create: (_) => SearchRepository(),
        ),
      ],
      child: MultiProvider(
        // Initialize all providers
        providers: [
          ChangeNotifierProvider(create: (context) {
            return SearchProvider(
              apiRepo: context.read<ApiRepository>(),
              searchRepo: context.read<SearchRepository>(),
            );
          }),
          ChangeNotifierProvider(create: (context) {
            return MusicProvider(
              apiRepo: context.read<ApiRepository>(),
              listenRepo: context.read<ListenRepository>(),
            );
          }),
          ChangeNotifierProvider(create: (context) {
            return DownloadManager(
              apiRepo: context.read<ApiRepository>(),
              playlistRepo: context.read<PlaylistRepository>(),
            );
          })
        ],
        child: const App(),
      ),
    ),
  );
}

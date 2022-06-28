import 'dart:async';

import 'package:api_repository/api_repository.dart';
import 'package:audio_session/audio_session.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/app.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';

void onStart(service) {
  print("started");
  if (service is! AndroidServiceInstance) throw Error();
  WidgetsFlutterBinding.ensureInitialized();

  service.setAsForegroundService();
  service.setForegroundNotificationInfo(
    title: "title",
    content: "content",
  );
}

void main() async {
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

  // Initialize Download Service
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: (_) {},
      onBackground: (_) => true,
    ),
  );
  service.startService();

  runApp(
    MultiRepositoryProvider(
      // Initialize all repositories as providers
      providers: [
        RepositoryProvider(create: (_) => ApiRepository(trackBox: trackBox)),
        RepositoryProvider(create: (_) => AuthenticationRepository()),
        RepositoryProvider(create: (_) => ListenRepository()),
        RepositoryProvider(create: (_) => PlaylistRepository()),
        RepositoryProvider(create: (_) => SearchRepository()),
        // RepositoryProvider(create: (_) => downloadService),
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
            final musicProvider = MusicProvider(
              apiRepo: context.read<ApiRepository>(),
              listenRepo: context.read<ListenRepository>(),
            );

            musicProvider.player.setAudioSource(musicProvider.queue);
            return musicProvider;
          }),
        ],
        child: const App(),
      ),
    ),
  );
}

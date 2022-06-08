import 'package:api_repository/api_repository.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:listen_repository/listen_repository.dart';
import 'package:playlist_repository/playlist_repository.dart';
import 'package:provider/provider.dart';
import 'package:search_repository/search_repository.dart';
import 'package:soundroid/app.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/features/search/search.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(TrackAdapter());
  final trackBox = await Hive.openBox<Track>("tracks");

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => PlayingProvider()),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ApiRepository>(
            create: (_) => ApiRepository(trackBox: trackBox),
          ),
          RepositoryProvider<AuthenticationRepository>(
            create: (_) => AuthenticationRepository(),
          ),
          RepositoryProvider<ListenRepository>(
            create: (_) => ListenRepository(),
          ),
          RepositoryProvider<PlaylistRepository>(
            create: (_) => PlaylistRepository(),
          ),
          RepositoryProvider<SearchRepository>(
            create: (_) => SearchRepository(),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/screens/auth.dart';
import 'package:soundroid/screens/main.dart';
import 'package:soundroid/screens/playlist.dart';
import 'package:soundroid/screens/signin.dart';
import 'package:soundroid/widgets/app/scroll_behaviour.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isWindows) {
    await Firebase.initializeApp();
  }

  // Initialize Hive
  await Hive.initFlutter();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SounDroid',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF126DFF, {
          50: Color.fromRGBO(18, 109, 255, 0.1),
          100: Color.fromRGBO(18, 109, 255, 0.2),
          200: Color.fromRGBO(18, 109, 255, 0.3),
          300: Color.fromRGBO(18, 109, 255, 0.4),
          400: Color.fromRGBO(18, 109, 255, 0.5),
          500: Color.fromRGBO(18, 109, 255, 0.6),
          600: Color.fromRGBO(18, 109, 255, 0.7),
          700: Color.fromRGBO(18, 109, 255, 0.8),
          800: Color.fromRGBO(18, 109, 255, 0.9),
          900: Color.fromRGBO(18, 109, 255, 1)
        }),
        backgroundColor: const Color(0xFF222222),
        fontFamily: "Poppins",
      ),
      scrollBehavior: AppScrollBehavior(),
      initialRoute: AuthScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        PlaylistScreen.routeName: (context) => const PlaylistScreen(),
        AuthScreen.routeName: (context) => const AuthScreen(),
        SigninScreen.routeName: (context) => const SigninScreen(),
      },
    );
  }
}

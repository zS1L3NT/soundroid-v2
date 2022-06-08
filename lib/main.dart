import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/screens/welcome_screen.dart';
import 'package:soundroid/models/artist.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/providers/playing_provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/screens/auth/forgot_password_screen.dart';
import 'package:soundroid/screens/auth/reset_password_screen.dart';
import 'package:soundroid/screens/auth/signin_screen.dart';
import 'package:soundroid/screens/auth/signup_screen.dart';
import 'package:soundroid/screens/auth/verify_email_screen.dart';
import 'package:soundroid/screens/auth/welcome_screen.dart';
import 'package:soundroid/screens/main_screen.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  Hive.registerAdapter(ArtistAdapter());
  Hive.registerAdapter(TrackAdapter());
  await Hive.openBox<Artist>("artists");
  await Hive.openBox<Track>("tracks");

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => PlayingProvider()),
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
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          headline2: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          headline3: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          headline4: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          headline5: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          caption: TextStyle(
            fontSize: 12,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFF222222),
        fontFamily: "Poppins",
      ),
      scrollBehavior: AppScrollBehavior(),
      home: const WelcomeScreen(),
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

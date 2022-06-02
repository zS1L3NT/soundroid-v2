import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/providers/playing_provider.dart';
import 'package:soundroid/providers/search_provider.dart';
import 'package:soundroid/screens/auth/forgot_password_screen.dart';
import 'package:soundroid/screens/auth/reset_password_screen.dart';
import 'package:soundroid/screens/auth/signin_screen.dart';
import 'package:soundroid/screens/auth/signup_screen.dart';
import 'package:soundroid/screens/auth/verify_email_screen.dart';
import 'package:soundroid/screens/auth/welcome_screen.dart';
import 'package:soundroid/screens/main_screen.dart';
import 'package:soundroid/screens/playlist_screen.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

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
        backgroundColor: const Color(0xFF222222),
        fontFamily: "Poppins",
      ),
      scrollBehavior: AppScrollBehavior(),
      initialRoute: WelcomeScreen.routeName,
      routes: {
        MainScreen.routeName: (context) => const MainScreen(),
        PlaylistScreen.routeName: (context) => const PlaylistScreen(),
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        SigninScreen.routeName: (context) => const SigninScreen(),
        ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
        ResetPasswordScreen.routeName: (context) => const ResetPasswordScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        VerifyEmailScreen.routeName: (context) => const VerifyEmailScreen(),
      },
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

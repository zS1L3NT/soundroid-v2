import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/authentication/authentication.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:uni_links/uni_links.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    uriLinkStream.listen((uri) {
      if (uri != null) {
        _navigatorKey.currentState!.push(DeepLinkingScreen.route(uri));
      }
    });
  }

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
            fontSize: 22,
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
        // For sexy Android 12 overscroll behaviour
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      navigatorKey: _navigatorKey,
      home: FutureBuilder<bool?>(
        future: context.read<AuthenticationRepository>().isEmailVerified,
        builder: (context, snap) {
          final isEmailVerified = snap.data;

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: snap.connectionState == ConnectionState.done
                ? isEmailVerified == null
                    ? const WelcomeScreen()
                    : isEmailVerified
                        ? const MainScreen()
                        : const VerifyEmailScreen(showCountdown: false)
                : const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

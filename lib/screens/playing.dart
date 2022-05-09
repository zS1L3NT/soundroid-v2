import 'package:flutter/material.dart';
import 'package:soundroid/screens/playing/current.dart';
import 'package:soundroid/widgets/playing/app_bar.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({Key? key}) : super(key: key);

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  final _screens = const [
    CurrentScreen(),
    Text("Queue"),
    Text("Lyrics"),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlayingAppBar(
        index: _index,
        setIndex: (index) => setState(() => _index = index),
      ),
      body: _screens[_index],
    );
  }
}

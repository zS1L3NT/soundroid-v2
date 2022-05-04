import 'package:flutter/material.dart';
import 'package:soundroid/models/playlist.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  static const routeName = "/playlist";

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _playlist = Playlist(
    name: "Korean Songs",
    userId: "",
    thumbnail:
        "https://thebiaslistcom.files.wordpress.com/2020/11/gfriend-mago.jpg",
    trackIds: [],
  );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text("Playlist"));
  }
}

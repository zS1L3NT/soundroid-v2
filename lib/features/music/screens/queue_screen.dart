import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundroid/features/music/music.dart';
import 'package:soundroid/widgets/widgets.dart';

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  State<QueueScreen> createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  final _tracks = const [
    Track(
      id: "",
      title: "MAGO",
      artists: [
        Artist(
          id: "",
          name: "GFRIEND",
        ),
      ],
      thumbnail:
          "https://static.wikia.nocookie.net/gfriend/images/5/51/GFriend_Walpurgis_Night_Digital_Cover.jpg/revision/latest?cb=20201109125023",
    ),
    Track(
      id: "",
      title: "LA DI DA",
      artists: [
        Artist(
          id: "",
          name: "EVERGLOW",
        ),
      ],
      thumbnail: "https://kbopped.files.wordpress.com/2020/09/la-di-da.jpg",
    ),
    Track(
      id: "",
      title: "Voltage",
      artists: [
        Artist(
          id: "",
          name: "ITZY",
        ),
      ],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b273aecb87fd2574ad79b05cc024",
    ),
    Track(
      id: "",
      title: "Odd Eye",
      artists: [
        Artist(
          id: "",
          name: "Dreamcatcher",
        ),
      ],
      thumbnail:
          "https://colorcodedlyrics.com/wp-content/uploads/2021/01/Dreamcatcher-Dystopia-Road-to-Utopia.jpg",
    ),
    Track(
      id: "",
      title: "Ven Para",
      artists: [
        Artist(
          id: "",
          name: "Weeekly",
        ),
      ],
      thumbnail: "https://images.genius.com/63812adc796134af85c3e8146dc016ef.600x600x1.jpg",
    ),
    Track(
      id: "",
      title: "Black Mamba",
      artists: [
        Artist(
          id: "",
          name: "aespa",
        ),
      ],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/e/e4/Aespa_-_Black_Mamba.png",
    ),
    Track(
      id: "",
      title: "WA DA DA",
      artists: [
        Artist(
          id: "",
          name: "Kep1er",
        ),
      ],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b2732963187314262831fa2baa49",
    ),
    Track(
      id: "",
      title: "TOMBOY",
      artists: [
        Artist(
          id: "",
          name: "(G)I-DLE",
        ),
      ],
      thumbnail: "https://images.genius.com/c5c5b9daef8abffc860437ebd500e555.1000x1000x1.png",
    ),
    Track(
      id: "",
      title: "Why Not?",
      artists: [
        Artist(
          id: "",
          name: "LOONA",
        ),
      ],
      thumbnail:
          "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2020/09/LOONA-1200.jpg?w=640&ssl=1",
    ),
    Track(
      id: "",
      title: "Step Back",
      artists: [
        Artist(
          id: "",
          name: "GOT the beat",
        ),
      ],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/b/b0/Got_the_Beat_-_Step_Back.jpg",
    ),
    Track(
      id: "",
      title: "PLAYING WITH FIRE",
      artists: [
        Artist(
          id: "",
          name: "BLACKPINK",
        ),
      ],
      thumbnail: "https://images.genius.com/4cb3a383634155a13f8db8594a79d27d.600x600x1.jpg",
    ),
    Track(
      id: "",
      title: "PTT (Paint The Town)",
      artists: [
        Artist(
          id: "",
          name: "LOONA",
        ),
      ],
      thumbnail: "https://images.genius.com/b17668a45799ad30aadb722111d5124c.300x300x1.jpg",
    ),
    Track(
      id: "",
      title: "D-D-DANCE",
      artists: [
        Artist(
          id: "",
          name: "IZ*ONE",
        ),
      ],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/8/80/Dddance.jpg",
    ),
    Track(
      id: "",
      title: "LOCO",
      artists: [
        Artist(
          id: "",
          name: "ITZY",
        ),
      ],
      thumbnail: "https://i.ytimg.com/vi/-6gdPbihCNk/maxresdefault.jpg",
    ),
    Track(
      id: "",
      title: "Not Shy",
      artists: [
        Artist(
          id: "",
          name: "ITZY",
        ),
      ],
      thumbnail: "https://upload.wikimedia.org/wikipedia/en/9/9a/Itzy_-_Not_Shy.jpg",
    ),
    Track(
      id: "",
      title: "WANNABE",
      artists: [
        Artist(
          id: "",
          name: "ITZY",
        ),
      ],
      thumbnail:
          "https://popgasa1.files.wordpress.com/2020/03/81382519_1583735274558_1_600x600.jpg",
    ),
    Track(
      id: "",
      title: "달라달라 (DALLA DALLA)",
      artists: [
        Artist(
          id: "",
          name: "ITZY",
        ),
      ],
      thumbnail:
          "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/02/ITZY-IT%E2%80%99z-Different.jpg?fit=600%2C600&ssl=1",
    ),
    Track(
      id: "",
      title: "SO BAD",
      artists: [
        Artist(
          id: "",
          name: "STAYC",
        ),
      ],
      thumbnail: "https://i.scdn.co/image/ab67616d0000b273bc125f40131dd5869b2ec36c",
    ),
    Track(
      id: "",
      title: "Rollin'",
      artists: [
        Artist(
          id: "",
          name: "Brave Girls",
        ),
      ],
      thumbnail:
          "https://static.wikia.nocookie.net/kpop/images/0/04/Brave_Girls_Rollin%27_revised_digital_cover_art.png/revision/latest?cb=20210302021641",
    ),
    Track(
      id: "",
      title: "SMILEY(Feat. BIBI)",
      artists: [
        Artist(
          id: "",
          name: "YENA",
        ),
        Artist(
          id: "",
          name: "BIBI",
        ),
      ],
      thumbnail:
          "https://seoulbeats.com/wp-content/uploads/2022/01/20220123_seoulbeats_yena_smiley_cover.jpg",
    ),
  ];

  Widget buildQueueItem(Track track) {
    final selected = context.read<PlayingProvider>().selected;

    return InkWell(
      onTap: () => onTap(selected, track),
      onLongPress: () => onLongPress(selected, track),
      child: ListTile(
        tileColor: selected != null && selected.contains(track)
            ? Theme.of(context).highlightColor
            : Colors.transparent,
        leading: AppImage.network(
          track.thumbnail,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          size: 56,
        ),
        title: AppText.ellipse(track.title),
        subtitle: AppText.ellipse(track.artists.map((artist) => artist.name).join(", ")),
        trailing: ReorderableDragStartListener(
          index: _tracks.indexOf(track),
          child: AppIcon.black87(
            Icons.drag_handle_rounded,
            onPressed: () {},
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }

  void onTap(List<Track>? selected, Track track) {
    if (selected == null) {
      // Play the song
    } else {
      if (selected.contains(track)) {
        if (selected.length == 1) {
          context.read<PlayingProvider>().selected = null;
        } else {
          context.read<PlayingProvider>().selected = selected.where((t) => t != track).toList();
        }
      } else {
        context.read<PlayingProvider>().selected = selected.toList()..add(track);
      }
    }
  }

  void onLongPress(List<Track>? selected, Track track) {
    if (selected == null) {
      context.read<PlayingProvider>().selected = [track];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      children: _tracks.map(buildQueueItem).toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Track track = _tracks.removeAt(oldIndex);
          _tracks.insert(newIndex, track);
        });
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:soundroid/models/track.dart';
import 'package:soundroid/widgets/main/home/tracks_row.dart';
import 'package:transparent_image/transparent_image.dart';

class MoreFromArtistSection extends StatefulWidget {
  final String artistId;
  const MoreFromArtistSection({
    Key? key,
    required this.artistId,
  }) : super(key: key);

  @override
  State<MoreFromArtistSection> createState() => _MoreFromArtistSectionState();
}

class _MoreFromArtistSectionState extends State<MoreFromArtistSection> {
  var _artist = <String, String>{};
  var _tracks = <Track>[];

  @override
  Widget build(BuildContext context) {
    if (widget.artistId == "UCTUR0sVEkD8T5MlSHqgaI_Q") {
      _artist = {
        "id": "UCTUR0sVEkD8T5MlSHqgaI_Q",
        "name": "IU",
        "thumbnail":
            "https://yt3.ggpht.com/5IxOvld-clJ-zZ0lrLiKjF0ssHnbk3aMWhlQ89eog0sMjy5DkcMwp48kxkGKQfueFJEBLZ_dIg=s88-c-k-c0x00ffffff-no-rj"
      };

      _tracks = [
        Track(
          id: "",
          title: "My Sea",
          artists: "IU",
          thumbnail:
              "https://upload.wikimedia.org/wikipedia/en/4/41/IU_-_Lilac.png",
        ),
        Track(
          id: "",
          title: "Eight",
          artists: "IU",
          thumbnail:
              "https://upload.wikimedia.org/wikipedia/en/c/c2/IU_EIGHT_FT_SUGA.jpg",
        ),
        Track(
          id: "",
          title: "BBiBBi",
          artists: "IU",
          thumbnail:
              "https://m.media-amazon.com/images/M/MV5BNGI1MjcyOWYtMDc3Mi00Mzk0LTk3MzctNTM1ZjlmZjg1NzdjXkEyXkFqcGdeQXVyNDY5MjMyNTg@._V1_.jpg",
        ),
        Track(
          id: "",
          title: "Above the Time",
          artists: "IU",
          thumbnail: "https://i.imgur.com/dWQxywe.jpg",
        ),
        Track(
          id: "",
          title: "Good Day",
          artists: "IU",
          thumbnail:
              "https://i1.sndcdn.com/artworks-000090881151-jg71ro-t500x500.jpg",
        ),
      ];
    }

    if (widget.artistId == "UCwzCuKxyMY_sT7hr1E8G1XA") {
      _artist = {
        "id": "UCwzCuKxyMY_sT7hr1E8G1XA",
        "name": "Taeyeon",
        "thumbnail":
            "https://yt3.ggpht.com/Wp9fZbDLVONlReTs0jp0xEKLgEbIx9r7CASXE1XEwp_m9XawitCizOzI0s523rhE0EipWJQzJw=s88-c-k-c0x00ffffff-no-rj"
      };

      _tracks = [
        Track(
          id: "",
          title: "All With You",
          artists: "Taeyeon",
          thumbnail:
              "http://images.genius.com/9ae86007931fa7108e5331464366cc17.600x600x1.jpg",
        ),
        Track(
          id: "",
          title: "Cover Up",
          artists: "Taeyeon",
          thumbnail:
              "https://i.scdn.co/image/ab67616d0000b2738c7e7f435fdcc70772c5555e",
        ),
        Track(
          id: "",
          title: "Spark",
          artists: "Taeyeon",
          thumbnail:
              "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/10/Taeyeon-Purpose.jpg?fit=1000%2C1000&ssl=1",
        ),
        Track(
          id: "",
          title: "Gravity",
          artists: "Taeyeon",
          thumbnail:
              "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/10/Taeyeon-Purpose.jpg?fit=1000%2C1000&ssl=1",
        ),
        Track(
          id: "",
          title: "Blue",
          artists: "Taeyeon",
          thumbnail:
              "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/03/Taeyeon-Four-Seasons.jpg?fit=600%2C600&ssl=1",
        ),
      ];
    }

    if (widget.artistId == "UCTP45_DE3fMLujU8sZ-MBzw") {
      _artist = {
        "id": "UCTP45_DE3fMLujU8sZ-MBzw",
        "name": "ITZY",
        "thumbnail":
            "https://yt3.ggpht.com/Tcv6hQip2y2lDHjXm0pcUjodYMPdNp4c0o94dQYBjDkOsWI2gH8fnY0IPKk9WG_AVSyHYctZ=s88-c-k-c0x00ffffff-no-rj"
      };

      _tracks = [
        Track(
          id: "",
          title: "Loco",
          artists: "ITZY",
          thumbnail: "https://i.ytimg.com/vi/-6gdPbihCNk/maxresdefault.jpg",
        ),
        Track(
          id: "",
          title: "Not Shy",
          artists: "ITZY",
          thumbnail:
              "https://upload.wikimedia.org/wikipedia/en/9/9a/Itzy_-_Not_Shy.jpg",
        ),
        Track(
          id: "",
          title: "Wannabe",
          artists: "ITZY",
          thumbnail:
              "https://popgasa1.files.wordpress.com/2020/03/81382519_1583735274558_1_600x600.jpg",
        ),
        Track(
          id: "",
          title: "Dalla Dalla",
          artists: "ITZY",
          thumbnail:
              "https://i0.wp.com/colorcodedlyrics.com/wp-content/uploads/2019/02/ITZY-IT%E2%80%99z-Different.jpg?fit=600%2C600&ssl=1",
        ),
        Track(
          id: "",
          title: "Icy",
          artists: "ITZY",
          thumbnail:
              "https://i1.sndcdn.com/artworks-000576804008-p3iewb-t500x500.jpg",
        ),
      ];
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                child: FadeInImage.memoryNetwork(
                  fadeInCurve: Curves.decelerate,
                  placeholder: kTransparentImage,
                  image: _artist["thumbnail"]!,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "More from ",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                _artist["name"]!,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        TracksRow(tracks: _tracks)
      ],
    );
  }
}

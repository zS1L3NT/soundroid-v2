import 'package:api_repository/api_repository.dart';
import 'package:flutter/material.dart';
import 'package:soundroid/env.dart';
import 'package:soundroid/features/home/home.dart';
import 'package:soundroid/widgets/widgets.dart';

class ArtistSectionWidget extends StatelessWidget {
  const ArtistSectionWidget({
    Key? key,
    required this.section,
  }) : super(key: key);

  final ArtistSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              AppImage.network(
                "$API_URL/api/thumbnail?artistId=${section.artist.id}",
                borderRadius: BorderRadius.circular(28),
                size: 56,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "More from",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(
                    section.artist.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 12),
        HorizontalTracks(tracks: section.items),
      ],
    );
  }
}

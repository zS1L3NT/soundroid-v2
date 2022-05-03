import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/text.dart';
import 'package:transparent_image/transparent_image.dart';

enum SearchResultType {
  track,
  album,
}

class SearchResultItem extends StatefulWidget {
  final SearchResultType type;
  final String title;
  final String description;
  final String thumbnail;
  const SearchResultItem({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.thumbnail,
  }) : super(key: key);

  @override
  State<SearchResultItem> createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: FadeInImage.memoryNetwork(
                  fadeInCurve: Curves.decelerate,
                  placeholder: kTransparentImage,
                  image: widget.thumbnail,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    widget.title,
                    width: MediaQuery.of(context).size.width - 124,
                    extraHeight: 8,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    widget.description,
                    width: MediaQuery.of(context).size.width - 124,
                    extraHeight: 7,
                    textAlign: TextAlign.start,
                    fontSize: 12,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
                iconSize: 20,
                splashRadius: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/text.dart';

class LikedSongsItem extends StatefulWidget {
  const LikedSongsItem({Key? key}) : super(key: key);

  @override
  State<LikedSongsItem> createState() => _LikedSongsItemState();
}

class _LikedSongsItemState extends State<LikedSongsItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Container(
                width: 48,
                height: 48,
                color: Theme.of(context).primaryColorLight,
                child: Icon(
                  Icons.favorite,
                  size: 20,
                  color: Theme.of(context).primaryColorDark,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  "Liked Songs",
                  width: MediaQuery.of(context).size.width - 76,
                  extraHeight: 8,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                AppText(
                  "3 tracks",
                  width: MediaQuery.of(context).size.width - 76,
                  extraHeight: 7,
                  fontSize: 12,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

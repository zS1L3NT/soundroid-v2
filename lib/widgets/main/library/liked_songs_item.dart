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
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: ListTile(
          leading: ClipRRect(
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
          title: AppText.ellipse(
            "Liked Songs",
            extraHeight: 9,
            width: MediaQuery.of(context).size.width,
          ),
          subtitle: AppText.ellipse(
            "3 tracks",
            fontSize: 14,
            extraHeight: 11,
            fontWeight: FontWeight.w400,
            width: MediaQuery.of(context).size.width,
          ),
          contentPadding: const EdgeInsets.only(left: 16, right: 8),
        ),
      ),
    );
  }
}

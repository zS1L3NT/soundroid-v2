import 'package:flutter/material.dart';
import 'package:soundroid/ui/widgets/app/text.dart';

class LikedSongsItem extends StatelessWidget {
  const LikedSongsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Container(
            width: 56,
            height: 56,
            color: Theme.of(context).primaryColorLight,
            child: Icon(
              Icons.favorite_rounded,
              size: 20,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        title: AppText.ellipse("Liked Songs"),
        subtitle: AppText.ellipse("3 tracks"),
        contentPadding: const EdgeInsets.only(left: 16),
      ),
    );
  }
}

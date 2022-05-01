import 'package:flutter/material.dart';
import 'package:soundroid/widgets/app/text.dart';

class RecentItem extends StatefulWidget {
  final String text;
  const RecentItem({Key? key, required this.text}) : super(key: key);

  @override
  State<RecentItem> createState() => _RecentItemState();
}

class _RecentItemState extends State<RecentItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16),
        child: Row(
          children: [
            const Icon(Icons.history, color: Colors.black87),
            const SizedBox(width: 16),
            AppText(
              widget.text,
              width: MediaQuery.of(context).size.width - 104,
              height: 36,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 18,
                height: 1.7,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.clear, color: Colors.black87),
              splashRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}

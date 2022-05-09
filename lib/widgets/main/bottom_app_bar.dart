import 'package:flutter/material.dart';

class MainBottomAppBar extends StatelessWidget {
  const MainBottomAppBar({
    Key? key,
    required this.index,
    required this.setIndex,
  }) : super(key: key);

  final int index;

  final Function(int) setIndex;

  @override
  Widget build(BuildContext context) {
    Color getColor(int index) {
      return this.index == index ? Theme.of(context).primaryColor : Colors.grey;
    }

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 59,
        child: Row(
          children: [
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(0);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home, color: getColor(0)),
                    Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(1);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search, color: getColor(1)),
                    Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(2);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.library_music, color: getColor(2)),
                    Text(
                      "Library",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setIndex(3);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: getColor(3)),
                    Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: getColor(3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

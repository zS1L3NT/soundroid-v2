import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soundroid/ui/screens/playing.dart';
import 'package:soundroid/utils/route_transition.dart';

class FloatingMusicButton extends StatefulWidget {
  const FloatingMusicButton({Key? key}) : super(key: key);

  @override
  State<FloatingMusicButton> createState() => _FloatingMusicButtonState();
}

class _FloatingMusicButtonState extends State<FloatingMusicButton>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 15),
  )..repeat();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, child) => Transform.rotate(
              angle: _controller.value * 2 * pi,
              child: child,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/en/c/c0/Strawberry_Moon_IU_cover.jpg",
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              value: 0.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.5),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: const Color.fromRGBO(0, 0, 0, 0.4),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                onTap: () {
                  final size = MediaQuery.of(context).size;
                  Navigator.of(context).push(
                    RouteTransition.reveal(
                      const PlayingScreen(),
                      center: Offset(
                        size.width / 2,
                        size.height - kBottomNavigationBarHeight,
                      ),
                      duration: const Duration(milliseconds: 400),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

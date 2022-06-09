import 'package:flutter/material.dart';
import 'package:soundroid/widgets/widgets.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({Key? key}) : super(key: key);

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _volume = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon.primaryColor(
          Icons.volume_down_rounded,
          context,
          size: 20,
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 1,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
          ),
          child: Expanded(
            child: Slider.adaptive(
              value: _volume,
              onChanged: (volume) {
                setState(() {
                  _volume = volume;
                });
              },
            ),
          ),
        ),
        AppIcon.primaryColorLight(
          Icons.volume_up_rounded,
          context,
          size: 20,
        ),
      ],
    );
  }
}

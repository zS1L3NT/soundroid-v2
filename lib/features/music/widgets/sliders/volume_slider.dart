import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:soundroid/widgets/widgets.dart';

class VolumeSlider extends StatefulWidget {
  const VolumeSlider({Key? key}) : super(key: key);

  @override
  State<VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double? _volume;
  double? _slideVolume;

  @override
  void initState() {
    super.initState();

    // Fetch the current volume
    PerfectVolumeControl.getVolume().then((volume) {
      setState(() => _volume = volume);

      // Subscribe to the volume changes from the OS
      PerfectVolumeControl.stream.listen((volume) {
        if (mounted && _slideVolume == null) {
          setState(() => _volume = volume);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon.primaryColor(
          Icons.volume_down_rounded,
          size: 20,
        ),
        SliderTheme(
          data: const SliderThemeData(
            trackHeight: 1,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 9),
          ),
          child: Expanded(
            child: _volume != null
                ? Slider.adaptive(
                    // If the user is dragging the slider, show the user's slide position instead
                    value: _slideVolume ?? _volume!,
                    onChanged: (volume) {
                      PerfectVolumeControl.setVolume(volume);
                      setState(() => _slideVolume = volume);
                    },
                    onChangeEnd: (volume) {
                      PerfectVolumeControl.setVolume(volume);
                      setState(() {
                        _volume = volume;
                        _slideVolume = null;
                      });
                    },
                  )
                : const SizedBox(height: 24),
          ),
        ),
        AppIcon.primaryColorDark(
          Icons.volume_up_rounded,
          size: 20,
        ),
      ],
    );
  }
}

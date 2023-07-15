import 'package:flutter/material.dart';

class ImpulseSlider extends StatefulWidget {
  const ImpulseSlider({
    required this.title,
    required this.callback,
    super.key,
  });

  final String title;
  final Function(double) callback;

  @override
  State<ImpulseSlider> createState() => _ImpulseSliderState();
}

class _ImpulseSliderState extends State<ImpulseSlider> {
  double impulse = 3;

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SliderTheme(
          data: Theme.of(context).sliderTheme.copyWith(
                showValueIndicator: ShowValueIndicator.always,
              ),
          child: Slider(
            value: impulse,
            min: 0,
            max: 10,
            divisions: 10,
            label: "${impulse.round()}",
            onChanged: (double value) {
              setState(() {
                impulse = value;
              });
            },
            onChangeEnd: (value) => widget.callback(value),
          ),
        ),
        Text(
          widget.title,
          style: t.textTheme.bodySmall!.copyWith(
            color: t.hintColor,
          ),
        ),
      ],
    );
  }
}

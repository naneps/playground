import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:playground/app/models/box_shadow.model.dart';

class ShadowSettingWidget extends StatelessWidget {
  final BoxShadowModel shadow;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onBlurRadiusChanged;
  final ValueChanged<double> onSpreadRadiusChanged;
  final ValueChanged<Offset> onOffsetChanged;
  final void Function(BlurStyle) onBlurStyleChanged;

  const ShadowSettingWidget({
    super.key,
    required this.shadow,
    required this.onColorChanged,
    required this.onBlurRadiusChanged,
    required this.onSpreadRadiusChanged,
    required this.onOffsetChanged,
    required this.onBlurStyleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            const Text('Blur Radius:'),
            Slider(
              value: shadow.blurRadius,
              min: 0,
              max: 100,
              onChanged: onBlurRadiusChanged,
            ),
            Text(shadow.blurRadius.toStringAsFixed(1)),
          ],
        ),
        Row(
          children: [
            const Text('Spread Radius:'),
            Slider(
              value: shadow.spreadRadius,
              min: 0,
              max: 100,
              onChanged: onSpreadRadiusChanged,
            ),
            Text(shadow.spreadRadius.toStringAsFixed(1)),
          ],
        ),
        const SizedBox(height: 10),
        const Text('Offset:'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('X:'),
            Slider(
              value: shadow.offset.dx,
              min: -50,
              max: 50,
              onChanged: (newValue) {
                onOffsetChanged(Offset(newValue, shadow.offset.dy));
              },
            ),
            Text(shadow.offset.dx.toStringAsFixed(1)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('Y:'),
            Slider(
              value: shadow.offset.dy,
              min: -50,
              max: 50,
              onChanged: (newValue) {
                onOffsetChanged(Offset(shadow.offset.dx, newValue));
              },
            ),
            Text(shadow.offset.dy.toStringAsFixed(1)),
          ],
        ),
        const SizedBox(height: 10),
        const Text('Blur Style:'),
        DropdownButtonFormField(
          value: shadow.blurStyle,
          style: const TextStyle(
            color: Colors.black,
          ),
          dropdownColor: Colors.white,
          items: BlurStyle.values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.toString().split('.').last,
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            onBlurStyleChanged(value as BlurStyle);
          },
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ColorPicker(
            pickerColor: shadow.color,
            onColorChanged: onColorChanged,
            paletteType: PaletteType.hueWheel,
            colorPickerWidth: 200,
            colorHistory: [shadow.color],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:playground/app/models/box_shadow.model.dart';
import 'package:playground/app/modules/box_shadow_generator/widgets/custom_slider.widget.dart';

class ShadowSettingWidget extends StatefulWidget {
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
  State<ShadowSettingWidget> createState() => _ShadowSettingWidgetState();
}

class _ShadowSettingWidgetState extends State<ShadowSettingWidget> {
  double maxBlurRadius = 100;

  double maxSpreadRadius = 100;

  double maxOffsetX = 50;

  double minOffsetX = -50;

  double maxOffsetY = 50;

  double minOffsetY = -50;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        CustomSlider(
          label: 'Blur Radius:',
          value: widget.shadow.blurRadius,
          min: 0,
          max: maxBlurRadius,
          onChanged: widget.onBlurRadiusChanged,
          onMinChanged: (min) {
            maxBlurRadius = min;
          },
          hasMin: false,
          onMaxChanged: (max) {
            setState(() {
              maxBlurRadius = max;
            });
          },
        ),
        CustomSlider(
          label: 'Spread Radius:',
          value: widget.shadow.spreadRadius,
          min: 0,
          hasMin: false,
          max: maxSpreadRadius,
          onChanged: widget.onSpreadRadiusChanged,
          onMinChanged: (min) {},
          onMaxChanged: (max) {
            setState(() {
              maxSpreadRadius = max;
            });
          },
        ),
        CustomSlider(
          label: 'Offset X:',
          value: widget.shadow.offset.dx,
          min: minOffsetX,
          max: maxOffsetX,
          onChanged: (newValue) {
            widget.onOffsetChanged(Offset(newValue, widget.shadow.offset.dy));
          },
          onMinChanged: (min) {
            setState(() {
              minOffsetX = min;
            });
          },
          onMaxChanged: (max) {
            setState(() {
              maxOffsetX = max;
            });
          },
        ),
        CustomSlider(
          label: 'Offset Y:',
          value: widget.shadow.offset.dy,
          min: minOffsetY,
          max: maxOffsetY,
          onChanged: (newValue) {
            widget.onOffsetChanged(Offset(widget.shadow.offset.dx, newValue));
          },
          onMinChanged: (min) {
            setState(() {
              minOffsetY = min;
            });
          },
          onMaxChanged: (max) {
            setState(() {
              maxOffsetY = max;
            });
          },
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Blur Style:'),
              const SizedBox(height: 10),
              DropdownButtonFormField(
                value: widget.shadow.blurStyle,
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
                  widget.onBlurStyleChanged(value as BlurStyle);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ColorPicker(
          pickerColor: widget.shadow.color,
          onColorChanged: widget.onColorChanged,
          paletteType: PaletteType.hueWheel,
          colorPickerWidth: 160,
          colorHistory: [widget.shadow.color],
        ),
      ],
    );
  }
}

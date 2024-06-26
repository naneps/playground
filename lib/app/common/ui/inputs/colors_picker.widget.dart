import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerWidget extends StatefulWidget {
  final List<Color> initialColors;
  final ValueChanged<List<Color>> onColorsChanged;

  const ColorPickerWidget({
    super.key,
    required this.initialColors,
    required this.onColorsChanged,
  });

  @override
  _ColorPickerWidgetState createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Colors',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...colors.asMap().entries.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: e.value,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () => _removeColor(e.key),
                        ),
                      ],
                    ),
                  );
                }),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _showColorPicker,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    colors = List.from(widget.initialColors);
  }

  void _addColor(Color color) {
    setState(() {
      colors.add(color);
      widget.onColorsChanged(colors);
    });
  }

  void _removeColor(int index) {
    setState(() {
      colors.removeAt(index);
      widget.onColorsChanged(colors);
    });
  }

  void _showColorPicker() {
    Color pickerColor = Colors.white;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          scrollable: true,
          content: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                ColorPicker(
                  pickerColor: pickerColor,
                  colorPickerWidth: 300.0,
                  portraitOnly: true,
                  onColorChanged: (color) {
                    pickerColor = color;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _addColor(pickerColor);
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Select'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

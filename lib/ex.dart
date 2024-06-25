import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:playground/app/models/box_shadow.model.dart';

void main() => runApp(const MyApp());

class BoxShadowGenerator extends StatefulWidget {
  const BoxShadowGenerator({super.key});

  @override
  _BoxShadowGeneratorState createState() => _BoxShadowGeneratorState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BoxShadow Generator',
      home: BoxShadowGenerator(),
    );
  }
}

class ShadowSettingsTab extends StatelessWidget {
  final BoxShadowModel shadow;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onBlurRadiusChanged;
  final ValueChanged<double> onSpreadRadiusChanged;
  final ValueChanged<Offset> onOffsetChanged;
  final void Function(BlurStyle) onBlurStyleChanged;

  const ShadowSettingsTab({
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
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        const Text('Blur Radius:'),
        Slider(
          value: shadow.blurRadius,
          min: 0,
          max: 50,
          onChanged: onBlurRadiusChanged,
        ),
        const SizedBox(height: 20),
        const Text('Spread Radius:'),
        Slider(
          value: shadow.spreadRadius,
          min: 0,
          max: 50,
          onChanged: onSpreadRadiusChanged,
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        const Text('Blur Style:'),
        DropdownButton<BlurStyle>(
          value: shadow.blurStyle,
          onChanged: (val) {
            onBlurStyleChanged(val!);
          },
          items: const [
            DropdownMenuItem(value: BlurStyle.normal, child: Text('Normal')),
            DropdownMenuItem(value: BlurStyle.inner, child: Text('Inner')),
          ],
        ),
        const SizedBox(height: 20),
        ColorPicker(
          pickerColor: shadow.color,
          onColorChanged: onColorChanged,
        ),
      ],
    );
  }
}

class _BoxShadowGeneratorState extends State<BoxShadowGenerator>
    with SingleTickerProviderStateMixin {
  List<BoxShadowModel> shadows = [
    BoxShadowModel(
      color: Colors.grey,
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 16),
      blurStyle: BlurStyle.normal,
    ),
  ];
  int currentTab = 0;
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BoxShadow Generator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: shadows
                  .map((shadow) => BoxShadow(
                        color: shadow.color,
                        blurRadius: shadow.blurRadius,
                        spreadRadius: shadow.spreadRadius,
                        offset: shadow.offset,
                        blurStyle: shadow.blurStyle,
                      ))
                  .toList(),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {
                      currentTab = index;
                      _tabController.animateTo(index);
                    });
                  },
                  isScrollable: true,
                  tabs: shadows
                      .asMap()
                      .entries
                      .map(
                        (entry) => Tab(text: 'Shadow ${entry.key + 1}'),
                      )
                      .toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    shadows.add(
                      BoxShadowModel(
                        color: Colors.grey,
                        blurRadius: 16,
                        spreadRadius: 0,
                        offset: const Offset(0, 16),
                        blurStyle: BlurStyle.normal,
                      ),
                    );
                    _tabController = TabController(
                      length: shadows.length,
                      vsync: this,
                    );
                    // Set currentTab to the newly added tab
                    currentTab = shadows.length - 1;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: shadows
                  .asMap()
                  .entries
                  .map(
                    (entry) => ShadowSettingsTab(
                      shadow: entry.value,
                      onColorChanged: (color) {
                        setState(() {
                          shadows[entry.key].color = color;
                        });
                      },
                      onBlurRadiusChanged: (blurRadius) {
                        setState(() {
                          shadows[entry.key].blurRadius = blurRadius;
                        });
                      },
                      onSpreadRadiusChanged: (spreadRadius) {
                        setState(() {
                          shadows[entry.key].spreadRadius = spreadRadius;
                        });
                      },
                      onOffsetChanged: (offset) {
                        setState(() {
                          shadows[entry.key].offset = offset;
                        });
                      },
                      onBlurStyleChanged: (blurStyle) {
                        setState(() {
                          shadows[entry.key].blurStyle = blurStyle;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant BoxShadowGenerator oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: shadows.length, vsync: this);
  }
}

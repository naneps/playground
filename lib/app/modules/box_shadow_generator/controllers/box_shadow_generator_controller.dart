import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/box_shadow.model.dart';

class BoxShadowGeneratorController extends GetxController
    with GetTickerProviderStateMixin {
  RxList<BoxShadowModel> boxShadows = <BoxShadowModel>[
    BoxShadowModel(
      color: Colors.black12,
      blurRadius: 5,
      spreadRadius: 5,
      offset: const Offset(0, 1),
      blurStyle: BlurStyle.normal,
    ),
  ].obs;
  late TabController tabController;
  late Worker _worker;
  RxString code = ''.obs;
  void generateCode() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('```dart');
    buffer.writeln('Container(');
    buffer.writeln('  width: 200,');
    buffer.writeln('  height: 200,');
    buffer.writeln('  decoration: BoxDecoration(');
    buffer.writeln('    color: Colors.white,');
    buffer.writeln('    boxShadow: [');

    for (var shadow in boxShadows) {
      buffer.writeln('      BoxShadow(');
      buffer.writeln('        color: ${shadow.color},');
      buffer.writeln('        blurRadius: ${shadow.blurRadius},');
      buffer.writeln('        spreadRadius: ${shadow.spreadRadius},');
      buffer.writeln(
          '        offset: Offset(${shadow.offset.dx}, ${shadow.offset.dy}),');
      buffer.writeln('        blurStyle: ${shadow.blurStyle},');
      buffer.writeln('      ),');
    }

    buffer.writeln('    ],');
    buffer.writeln('  ),');
    buffer.writeln(');');
    buffer.writeln('```');

    code.value = buffer.toString();
  }

  void onAddShadow() {
    boxShadows.add(
      BoxShadowModel(
        color: Colors.black12,
        blurRadius: 5,
        spreadRadius: 5,
        offset: const Offset(0, 1),
        blurStyle: BlurStyle.normal,
      ),
    );
    generateCode();
  }

  void onBlurRadiusChanged(double value) {
    boxShadows[tabController.index].blurRadius = value;
    boxShadows.refresh();
  }

  void onBlurStyleChanged(BlurStyle value) {
    boxShadows[tabController.index].blurStyle = value;
    boxShadows.refresh();
  }

  @override
  void onClose() {
    tabController.dispose();
    _worker.dispose();
    super.onClose();
  }

  void onColorChanged(Color color) {
    boxShadows[tabController.index].color = color;
    boxShadows.refresh();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(
      length: boxShadows.length + 1,
      vsync: this,
    );
    ever(boxShadows, (_) {
      updateTabController();
      generateCode();
    });
  }

  void onOffsetChanged(Offset value) {
    boxShadows[tabController.index].offset = value;
    boxShadows.refresh();
  }

  void onRemoveShadow(int key) {
    boxShadows.removeAt(key);
  }

  void onSpreadRadiusChanged(double value) {
    boxShadows[tabController.index].spreadRadius = value;
    boxShadows.refresh();
  }

  void updateTabController() {
    tabController = TabController(
      initialIndex: tabController.index,
      length: boxShadows.length + 1,
      vsync: this,
    );
    tabController.animateTo(boxShadows.length - 1);
    update(); // Notify GetX to update the UI
  }
}

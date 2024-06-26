import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/gradient.model.dart';

class GradientGeneratorController extends GetxController
    with GetTickerProviderStateMixin {
  Rx<GradientModel> gradient = GradientModel(
    type: GradientType.linear,
    colors: [
      GradientColor(color: const Color.fromARGB(255, 212, 255, 143)),
      GradientColor(color: Colors.blue),
    ].obs,
    begin: Alignment.topLeft,
    stops: [
      StopModel(color: const Color.fromARGB(255, 212, 255, 143), stop: 0.0),
      StopModel(color: Colors.blue, stop: 1.0),
    ],
    end: Alignment.bottomRight,
    center: AlignmentGeometryModel(x: 0.0, y: 0.0),
  ).obs;
  late AnimationController animationController;
  late Tween<double> tween;
  late TabController headingTabController;

  void onAddStep() {
    gradient.update((val) {
      val!.colors.add(GradientColor(color: Colors.white));
    });
  }

  void onAddStops() {
    gradient.update((val) {
      val!.stops!.add(StopModel(color: Colors.white, stop: 0.5));
    });
  }

  void onCenterXChanged(double value) {
    gradient.update((val) {
      val!.center!.x = value;
      val.center = val.center!.copyWith(x: value);
    });
  }

  void onCenterYChanged(double value) {
    gradient.update((val) {
      val!.center!.y = value;
      val.center = val.center!.copyWith(y: value);
    });
  }

  void onColorsChanged(List<Color> selectedValues) {
    gradient.update((val) {
      val!.colors.value = selectedValues
          .map((color) => GradientColor(color: color))
          .toList()
          .obs;
    });
    onAddStops();
  }

  void onEndAngleChanged(double value) {
    gradient.update((val) {
      val!.endAngle = value;
    });
  }

  void onGradientTypeChanged(GradientType value) {
    gradient.value.type = value;
    gradient.refresh();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    headingTabController = TabController(length: 3, vsync: this);
  }

  void onRemoveColor(int key) {
    gradient.value.colors.removeAt(key);
    gradient.refresh();
  }

  void onStartAngleChanged(double value) {
    gradient.update((val) {
      val!.startAngle = value;
    });
  }

  void onStopChanged(int key, String value) {
    gradient.update((val) {
      val!.stops![key].color = gradient.value.colors[key].color;
      val.stops![key].stop = double.parse(value);
    });
  }

  void onStopValueChanged(int index, double value) {
    gradient.update((val) {
      val!.stops![index].stop = value;
      val.stops![index].color = gradient.value.colors[index].color;
    });
    gradient.refresh();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/gradient.model.dart';

class GradientGeneratorController extends GetxController
    with GetTickerProviderStateMixin {
  Rx<GradientModel> gradient = GradientModel(
    type: GradientType.linear,
    colors: [
      GradientColor(color: Colors.blueAccent),
      GradientColor(color: Colors.blue),
    ].obs,
    begin: Alignment.topLeft,
    stops: null,
    end: Alignment.bottomRight,
    center: AlignmentGeometryModel(x: 0.0, y: 0.0),
  ).obs;
  late AnimationController animationController;
  late Tween<double> tween;
  late TabController headingTabController;
  late TabController previewTabController;

  @override
  void onInit() {
    super.onInit();
    headingTabController = TabController(length: 3, vsync: this);
    previewTabController = TabController(length: 2, vsync: this);
    ever(gradient, (__) {
      generateCode();
    });
  }

  void onAddStops() {
    gradient.update((val) {
      final double increment = 1.0 / (val!.colors.length - 1);
      val.stops = List.generate(val.colors.length, (index) {
        return StopModel(
          color: val.colors[index].color,
          stop: index * increment,
        );
      });
    });
  }

  void removeStops() {
    gradient.update((val) {
      val!.stops = null;
    });
  }

  void onCenterXChanged(double value) {
    gradient.update((val) {
      val!.center = val.center!.copyWith(x: value);
    });
  }

  void onCenterYChanged(double value) {
    gradient.update((val) {
      val!.center = val.center!.copyWith(y: value);
    });
  }

  void onColorsChanged(List<Color> selectedValues) {
    gradient.update((val) {
      val!.colors.value = selectedValues
          .map((color) => GradientColor(color: color))
          .toList()
          .obs;
    });
    if (gradient.value.stops != null) {
      onAddStops();
    }
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

  void onRemoveColor(int key) {
    if (gradient.value.colors.length == 2) return;
    gradient.update((val) {
      val!.colors.removeAt(key);
      onAddStops();
    });
  }

  void onStartAngleChanged(double value) {
    gradient.update((val) {
      val!.startAngle = value;
    });
  }

  void onStopChanged(int key, String value) {
    gradient.update((val) {
      val!.stops![key] = StopModel(
        color: gradient.value.colors[key].color,
        stop: double.parse(value),
      );
    });
  }

  void onStopValueChanged(int index, double value) {
    gradient.update((val) {
      val!.stops![index] = StopModel(
        color: gradient.value.colors[index].color,
        stop: value,
      );
    });
  }

  void onTileModeChanged(TileModeType selectedType) {
    gradient.update((val) {
      val!.tileMode = selectedType;
    });
  }

  RxString code = ''.obs;

  void generateCode() {
    code.value = gradient.value.toCode();
  }
}

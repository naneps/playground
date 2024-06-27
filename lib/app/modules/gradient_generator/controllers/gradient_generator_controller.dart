import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/enums/gradient.enum.dart';
import 'package:playground/app/models/aligment_geomertry.model.dart';
import 'package:playground/app/models/container_model.dart';
import 'package:playground/app/models/gradient.model.dart';
import 'package:playground/app/models/stop.model.dart';

class GradientGeneratorController extends GetxController
    with GetTickerProviderStateMixin {
  Rx<ContainerModel> container = ContainerModel().obs;
  Rx<GradientModel> gradient = GradientModel(
    type: GradientType.linear,
    colors: [
      GradientColor(color: Colors.blueAccent),
      GradientColor(color: Colors.blue),
    ].obs,
    begin: AlignmentGeometryModel(x: 0.0, y: 0.0),
    stops: null,
    end: AlignmentGeometryModel(x: 1.0, y: 0.0),
    center: AlignmentGeometryModel(x: 0.0, y: 0.0),
  ).obs;
  late AnimationController animationController;
  late Tween<double> tween;
  late TabController headingTabController;
  late TabController previewTabController;
  RxString code = ''.obs;

  void generateCode() {
    code.value = gradient.value.toCode();
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

  void onBeginAlignmentChanged(List<AlignmentType> value) {
    gradient.update((val) {
      val!.begin = AlignmentGeometryModel(x: 0, y: 0, type: value.first);
    });
  }

  void onBeginXChanged(double value) {
    gradient.update((val) {
      val!.begin!.type = null;
      val.begin = val.begin!.copyWith(x: value, type: null);
    });
  }

  void onBeginYChanged(double value) {
    gradient.update((val) {
      val!.begin!.type = null;
      val.begin = val.begin!.copyWith(y: value, type: null);
    });
  }

  void onCenterXChanged(double value) {
    gradient.update((val) {
      val!.center = val.center!.copyWith(x: value, type: null);
    });
  }

  void onCenterYChanged(double value) {
    gradient.update((val) {
      val!.center = val.center!.copyWith(y: value, type: null);
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

  void onEndAlignmentChanged(List<AlignmentType> value) {
    gradient.update((val) {
      val!.end = AlignmentGeometryModel(
          x: value.first.alignment.x,
          y: value.first.alignment.y,
          type: value.first);
    });
  }

  void onEndAngleChanged(double value) {
    gradient.update((val) {
      val!.endAngle = value;
    });
  }

  void onEndXChanged(double value) {
    gradient.update((val) {
      val!.end!.type = null;
      val.end = val.end!.copyWith(x: value, type: null);
    });
  }

  void onEndYChanged(double value) {
    gradient.update((val) {
      val!.end!.type = null;
      val.end = val.end!.copyWith(y: value, type: null);
    });
  }

  void onGradientTypeChanged(GradientType value) {
    gradient.value.type = value;
    gradient.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    headingTabController = TabController(length: 3, vsync: this);
    previewTabController = TabController(length: 2, vsync: this);
    ever(gradient, (__) {
      generateCode();
    });
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

  void removeStops() {
    gradient.update((val) {
      val!.stops = null;
    });
  }
}

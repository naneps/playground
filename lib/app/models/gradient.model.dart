import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlignmentGeometryModel {
  double x;
  double y;
  AlignmentGeometryModel({required this.x, required this.y});
  AlignmentGeometryModel copyWith({
    double? x,
    double? y,
  }) {
    return AlignmentGeometryModel(
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }

  AlignmentGeometry toAlignmentGeometry() {
    return Alignment(x, y);
  }
}

class GradientColor {
  Color color;
  GradientColor({
    required this.color,
  });
}

class GradientModel {
  GradientType type;
  RxList<GradientColor> colors;
  List<StopModel>? stops;
  AlignmentGeometry begin;
  AlignmentGeometry end;
  double radius;
  AlignmentGeometryModel? center;

  TileMode tileMode;
  double startAngle;
  double endAngle;

  // Constructor for LinearGradient
  GradientModel({
    required this.type,
    required this.colors,
    this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.tileMode = TileMode.clamp,
    this.radius = 0.5,
    this.center,
    this.startAngle = 0.0,
    this.endAngle = 3.14,
  });

  // Method to convert the model to a Flutter Gradient
  Rx<Gradient> toGradient() {
    switch (type) {
      case GradientType.linear:
        return LinearGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          begin: begin,
          end: end,
          tileMode: tileMode,
        ).obs;
      case GradientType.radial:
        return RadialGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          radius: radius,
          tileMode: tileMode,
        ).obs;
      case GradientType.sweep:
        return SweepGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          startAngle: startAngle,
          endAngle: endAngle,
          tileMode: tileMode,
        ).obs;
    }
  }
}

// Enum to represent the gradient types
enum GradientType { linear, radial, sweep }

// Model to represent the gradient configuration
class StopModel {
  double stop;
  Color color;
  StopModel({required this.stop, required this.color});
}

extension GradientTypeExtension on GradientType {
  Gradient get gradient {
    switch (this) {
      case GradientType.linear:
        return const LinearGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        );
      case GradientType.radial:
        return const RadialGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          center: Alignment.center,
          radius: 0.5,
        );
      case GradientType.sweep:
        return const SweepGradient(
          colors: [Colors.red, Colors.blue],
          stops: [0.0, 1.0],
          center: Alignment.center,
          startAngle: 0.0,
          endAngle: 3.14,
        );
    }
  }
}

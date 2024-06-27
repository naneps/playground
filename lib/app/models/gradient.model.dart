import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:playground/app/enums/gradient.enum.dart';
import 'package:playground/app/models/aligment_geomertry.model.dart';
import 'package:playground/app/models/stop.model.dart';

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
  AlignmentGeometryModel? begin;
  AlignmentGeometryModel? end;
  GradientTransform? transform;
  double radius;
  AlignmentGeometryModel? center;
  TileModeType tileMode;
  double startAngle;
  double endAngle;

  // Constructor for LinearGradient
  GradientModel({
    required this.type,
    required this.colors,
    this.stops,
    this.begin,
    this.end,
    this.tileMode = TileModeType.clamp,
    this.radius = 0.5,
    this.center,
    this.startAngle = 0.0,
    this.transform,
    this.endAngle = 3.14,
  });

  String gradientCode() {
    switch (type) {
      case GradientType.linear:
        return _linearGradientCode();
      case GradientType.radial:
        return _radialGradientCode();
      case GradientType.sweep:
        return _sweepGradientCode();
      default:
        return '';
    }
  }

  String toCode() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('```dart');
    buffer.writeln('Container(');
    buffer.writeln('  width: 200,');
    buffer.writeln('  height: 200,');
    buffer.writeln('  decoration: BoxDecoration(');
    buffer.writeln('    gradient: ${gradientCode()},');
    buffer.writeln('  ),');
    buffer.writeln(');');
    buffer.writeln('```');

    return buffer.toString();
  }

  // Method to convert the model to a Flutter Gradient
  Rx<Gradient> toGradient() {
    switch (type) {
      case GradientType.linear:
        return LinearGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          begin: begin!.toAlignmentGeometry(),
          end: end!.toAlignmentGeometry(),
          transform: transform,
          tileMode: tileMode.tileMode,
        ).obs;
      case GradientType.radial:
        return RadialGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          radius: radius,
          transform: transform,
          tileMode: tileMode.tileMode,
        ).obs;
      case GradientType.sweep:
        return SweepGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          startAngle: startAngle,
          endAngle: endAngle,
          transform: transform,
          tileMode: tileMode.tileMode,
        ).obs;
    }
  }

  String _alignmentCode(AlignmentGeometry alignment) {
    if (alignment is Alignment) {
      return 'Alignment(${alignment.x}, ${alignment.y})';
    } else {
      return alignment.toString();
    }
  }

  String _colorsCode() {
    return '[\n    ${colors.map((color) => 'Color(${color.color.value})').join(',\n    ')}\n  ]';
  }

  String _linearGradientCode() {
    return 'LinearGradient(\n'
        '  begin: ${_alignmentCode(begin!.toAlignmentGeometry())},\n'
        '  end: ${_alignmentCode(end!.toAlignmentGeometry())},\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        '  tileMode: $tileMode,\n'
        ')';
  }

  String _radialGradientCode() {
    return 'RadialGradient(\n'
        '  center: ${_alignmentCode(center!.toAlignmentGeometry())},\n'
        '  radius: 0.5,\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        '  tileMode: $tileMode,\n'
        ')';
  }

  String _stopsCode() {
    if (stops == null) {
      return 'null';
    }
    return '[\n    ${stops!.map((stop) => stop.stop.toString()).join(',\n    ')}\n  ]';
  }

  String _sweepGradientCode() {
    return 'SweepGradient(\n'
        '  center: ${_alignmentCode(center!.toAlignmentGeometry())},\n'
        '  startAngle: $startAngle,\n'
        '  endAngle: $endAngle,\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        '  tileMode: $tileMode,\n'
        ')';
  }
}

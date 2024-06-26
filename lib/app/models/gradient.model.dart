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

  static Alignment center = const Alignment(0.0, 0.0);
  static Alignment topLeft = const Alignment(-1.0, -1.0);
  static Alignment topCenter = const Alignment(0.0, -1.0);
  static Alignment topRight = const Alignment(1.0, -1.0);
  static Alignment centerLeft = const Alignment(-1.0, 0.0);
  static Alignment centerRight = const Alignment(1.0, 0.0);
  static Alignment bottomLeft = const Alignment(-1.0, 1.0);
  static Alignment bottomCenter = const Alignment(0.0, 1.0);
  static Alignment bottomRight = const Alignment(1.0, 1.0);
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

  TileModeType tileMode;
  double startAngle;
  double endAngle;

  // Constructor for LinearGradient
  GradientModel({
    required this.type,
    required this.colors,
    this.stops,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
    this.tileMode = TileModeType.clamp,
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
          tileMode: tileMode.tileMode,
        ).obs;
      case GradientType.radial:
        return RadialGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          radius: radius,
          tileMode: tileMode.tileMode,
        ).obs;
      case GradientType.sweep:
        return SweepGradient(
          colors: colors.map((e) => e.color).toList(),
          stops: stops?.map((e) => e.stop).toList(),
          center: center?.toAlignmentGeometry() ?? Alignment.center,
          startAngle: startAngle,
          endAngle: endAngle,
          tileMode: tileMode.tileMode,
        ).obs;
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

  String _linearGradientCode() {
    return 'LinearGradient(\n'
        '  begin: ${_alignmentCode(begin)},\n'
        '  end: ${_alignmentCode(end)},\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        ')';
  }

  String _radialGradientCode() {
    return 'RadialGradient(\n'
        '  center: ${_alignmentCode(center!.toAlignmentGeometry())},\n'
        '  radius: 0.5,\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        ')';
  }

  String _sweepGradientCode() {
    return 'SweepGradient(\n'
        '  center: ${_alignmentCode(center!.toAlignmentGeometry())},\n'
        '  startAngle: $startAngle,\n'
        '  endAngle: $endAngle,\n'
        '  colors: ${_colorsCode()},\n'
        '  stops: ${_stopsCode()},\n'
        ')';
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

  String _stopsCode() {
    if (stops == null) {
      return 'null';
    }
    return '[\n    ${stops!.map((stop) => stop.stop.toString()).join(',\n    ')}\n  ]';
  }
}

// Enum to represent the gradient types
enum GradientType { linear, radial, sweep }

enum TileModeType { clamp, mirror, repeat }

extension TileModeExtension on TileModeType {
  TileMode get tileMode {
    switch (this) {
      case TileModeType.clamp:
        return TileMode.clamp;
      case TileModeType.mirror:
        return TileMode.mirror;
      case TileModeType.repeat:
        return TileMode.repeated;
    }
  }
}

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

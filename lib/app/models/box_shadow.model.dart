import 'package:flutter/material.dart';

/// A model class representing a box shadow.
class BoxShadowModel {
  Color color;
  double blurRadius;
  double spreadRadius;
  Offset offset;
  BlurStyle blurStyle;

  /// Constructs a [BoxShadowModel] with the given parameters.
  ///
  /// The [color], [blurRadius], [spreadRadius], and [offset] parameters are required.
  /// The [blurStyle] parameter is optional and defaults to [BlurStyle.normal].
  BoxShadowModel({
    required this.color,
    required this.blurRadius,
    required this.spreadRadius,
    required this.offset,
    this.blurStyle = BlurStyle.normal,
  });

  @override
  int get hashCode {
    return color.hashCode ^
        blurRadius.hashCode ^
        spreadRadius.hashCode ^
        offset.hashCode ^
        blurStyle.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoxShadowModel &&
        other.color == color &&
        other.blurRadius == blurRadius &&
        other.spreadRadius == spreadRadius &&
        other.offset == offset &&
        other.blurStyle == blurStyle;
  }

  /// Converts the [BoxShadowModel] to a [BoxShadow] object.
  BoxShadow toBoxShadow() {
    return BoxShadow(
      color: color,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
      offset: offset,
      blurStyle: blurStyle,
    );
  }

  /// Converts the [BoxShadowModel] to a Dart code string.
  String toCode() {
    return 'BoxShadow('
        'color: ${color.toString()},'
        'blurRadius: $blurRadius,'
        'spreadRadius: $spreadRadius,'
        'offset: $offset,'
        'blurStyle: $blurStyle,'
        ')';
  }
}

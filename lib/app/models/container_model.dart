import 'package:flutter/material.dart';
import 'package:playground/app/models/box_decoration_model.dart';

class ContainerModel {
  final double? width;
  final double? height;

  final BoxDecorationModel? decoration;
  ContainerModel({
    this.width,
    this.height,
    this.decoration,
  });

  ContainerModel copyWith({
    double? width,
    double? height,
    BoxDecorationModel? decoration,
  }) {
    return ContainerModel(
      width: width ?? this.width,
      height: height ?? this.height,
      decoration: decoration ?? this.decoration,
    );
  }

  Container toContainer() {
    return Container(
      width: width,
      height: height,
      decoration: decoration?.toBoxDecoration(),
    );
  }
}

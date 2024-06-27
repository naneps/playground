import 'package:flutter/material.dart';
import 'package:playground/app/models/gradient.model.dart';

class BoxDecorationModel {
  List<BoxShadow>? boxShadow;
  GradientModel? gradient;

  BoxDecorationModel({
    this.boxShadow,
    this.gradient,
  });

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      boxShadow: boxShadow,
      gradient: gradient?.toGradient().value,
    );
  }
}

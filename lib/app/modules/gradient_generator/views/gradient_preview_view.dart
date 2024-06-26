import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';

class GradientPreviewView extends GetView<GradientGeneratorController> {
  const GradientPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              gradient: controller.gradient.value.toGradient().value,
            ),
          );
        })
      ],
    );
  }
}

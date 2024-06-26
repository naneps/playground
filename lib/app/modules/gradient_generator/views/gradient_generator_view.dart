import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/gradient_generator/views/gradient_preview_view.dart';
import 'package:playground/app/modules/gradient_generator/views/tools_bar_gradient_view.dart';

import '../controllers/gradient_generator_controller.dart';

class GradientGeneratorView extends GetView<GradientGeneratorController> {
  const GradientGeneratorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GRADIENT GENERATOR'),
          centerTitle: true,
        ),
        body: const ResponsiveLayout(
          mobile: Column(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
          tablet: Row(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
          desktop: Row(
            children: [
              Expanded(child: GradientPreviewView()),
              Expanded(child: ToolsBarGradientView())
            ],
          ),
        ));
  }
}

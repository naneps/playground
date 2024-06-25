import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/box_shadow_generator/views/preview_shadow_view.dart';
import 'package:playground/app/modules/box_shadow_generator/views/tools_bar_shadow.view.dart';

import '../controllers/box_shadow_generator_controller.dart';

class BoxShadowGeneratorView extends GetView<BoxShadowGeneratorController> {
  const BoxShadowGeneratorView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box Shadow Generator'),
        centerTitle: true,
        elevation: 0,
      ),
      body: const SafeArea(
        child: ResponsiveLayout(
          mobile: Column(
            children: [
              Expanded(child: PreviewShadowView()),
              Expanded(child: ToolsBarShadowView()),
            ],
          ),
          tablet: Row(
            children: [
              Expanded(child: PreviewShadowView()),
              Expanded(child: ToolsBarShadowView()),
            ],
          ),
        ),
      ),
    );
  }
}

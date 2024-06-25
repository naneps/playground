import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/code_preview.dart';
import 'package:playground/app/modules/box_shadow_generator/controllers/box_shadow_generator_controller.dart';

class PreviewShadowView extends GetView<BoxShadowGeneratorController> {
  const PreviewShadowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Obx(() {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: Get.width * 0.3,
              height: Get.width * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  ...controller.boxShadows
                      .map((element) => element.toBoxShadow())
                ],
              ),
              child: const Center(
                child: Text(
                  'Preview',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ExpansionTile(
              onExpansionChanged: (value) {
                if (value) {
                  controller.generateCode();
                }
              },
              title: const Text('Code'),
              children: [CodePreview(code: controller.code.value)],
            ),
          ],
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:playground/app/common/ui/code_preview.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';

class GradientPreviewView extends GetView<GradientGeneratorController> {
  const GradientPreviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TabBar(controller: controller.previewTabController, tabs: const [
          //  preview
          // code
          Tab(
            text: 'Preview',
          ),
          Tab(
            text: 'Code',
          ),
        ]),
        Expanded(
          child: TabBarView(
            controller: controller.previewTabController,
            children: [
              // preview
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        gradient: controller.gradient.value.toGradient().value,
                      ),
                    );
                  }),
                ],
              ),
              // code
              Obx(() {
                return CodePreview(controller.gradient.value.toCode());
              })
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/code_preview.dart';
import 'package:playground/app/modules/box_shadow_generator/controllers/box_shadow_generator_controller.dart';

class PreviewShadowView extends GetView<BoxShadowGeneratorController> {
  const PreviewShadowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TabBar(
              controller: controller.tabPreviewController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              onTap: (index) {
                controller.tabPreviewController.index = index;
                controller.generateCode();
              },
              tabs: const [
                Tab(
                  text: 'Preview',
                ),
                Tab(
                  text: 'Code',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabPreviewController,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                ...controller.boxShadows.map(
                                  (e) {
                                    return BoxShadow(
                                      color: e.color,
                                      blurRadius: e.blurRadius,
                                      spreadRadius: e.spreadRadius,
                                      offset: e.offset,
                                      blurStyle: e.blurStyle,
                                    );
                                  },
                                ),
                              ]),
                          child: Center(
                            child: Text(
                              'Preview',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  CodePreview(controller.code.value),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

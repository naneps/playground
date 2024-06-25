import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/box_shadow_generator/controllers/box_shadow_generator_controller.dart';
import 'package:playground/app/modules/box_shadow_generator/widgets/shadow_setting.widget.dart';

class ToolsBarShadowView extends GetView<BoxShadowGeneratorController> {
  const ToolsBarShadowView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            TabBar(
              physics: const BouncingScrollPhysics(),
              controller: controller.tabController,
              isScrollable: true,
              tabs: [
                ...controller.boxShadows.asMap().entries.map(
                  (e) {
                    return Tab(
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Shadow ${e.key + 1}',
                          ),
                          Visibility(
                            visible: e.key != 0,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 20,
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.redAccent),
                              ),
                              splashRadius: 20,
                              onPressed: () {
                                controller.onRemoveShadow(e.key);
                              },
                              icon: const Icon(
                                Icons.close,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 20,
                  onPressed: controller.onAddShadow,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  ...controller.boxShadows.map(
                    (shadow) => ShadowSettingWidget(
                      shadow: shadow,
                      onColorChanged: (color) {
                        controller.onColorChanged(color);
                        controller.generateCode();
                      },
                      onBlurRadiusChanged: (value) {
                        controller.onBlurRadiusChanged(value);
                        controller.generateCode();
                      },
                      onSpreadRadiusChanged: (value) {
                        controller.onSpreadRadiusChanged(value);
                        controller.generateCode();
                      },
                      onOffsetChanged: (value) {
                        controller.generateCode();
                        controller.onOffsetChanged(value);
                      },
                      onBlurStyleChanged: (value) {
                        controller.onBlurStyleChanged(value);
                        controller.generateCode();
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

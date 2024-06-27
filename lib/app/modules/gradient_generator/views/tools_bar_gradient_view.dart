import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/inputs/action_chips_seclector.dart';
import 'package:playground/app/common/ui/inputs/colors_picker.widget.dart';
import 'package:playground/app/enums/gradient.enum.dart';
import 'package:playground/app/modules/box_shadow_generator/widgets/custom_slider.widget.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';
import 'package:playground/app/modules/gradient_generator/widgets/tool_stops.widget.dart';
import 'package:playground/app/modules/gradient_generator/widgets/tool_type.widget.dart';

class ToolsBarGradientView extends GetView<GradientGeneratorController> {
  const ToolsBarGradientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(10),
        child: Obx(() {
          return ListView(
            children: [
              const ToolTypeWidget(),
              const SizedBox(height: 10),
              ColorPickerWidget(
                initialColors: controller.gradient.value.colors
                    .map((e) => e.color)
                    .toList(),
                minColors: 2,
                onColorsChanged: (value) {
                  controller.onColorsChanged(value);
                },
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Begin & End Alignment",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    ActionChipsSelector<AlignmentType>(
                      label: "Begin Alignment",
                      items: AlignmentType.values,
                      titleBuilder: (value) {
                        return Text(value.toString().split('.').last);
                      },
                      onChanged: (value) {
                        controller.onBeginAlignmentChanged(value);
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Custom Begin Alignment",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSlider(
                            label: "X",
                            value: controller.gradient.value.begin!.x,
                            min: -1.0,
                            max: 1.0,
                            onChanged: (value) {
                              controller.onBeginXChanged(value);
                            },
                            canEdit: false,
                          ),
                        ),
                        Expanded(
                          child: CustomSlider(
                            label: "Y",
                            value: controller.gradient.value.begin!.y,
                            min: -1.0,
                            max: 1.0,
                            onChanged: (value) {
                              controller.onBeginYChanged(value);
                            },
                            canEdit: false,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    ActionChipsSelector<AlignmentType>(
                      label: "End Alignment",
                      items: AlignmentType.values,
                      titleBuilder: (value) {
                        return Text(value.toString().split('.').last);
                      },
                      onChanged: (value) {
                        controller.onEndAlignmentChanged(value);
                      },
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Custom End Alignment",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomSlider(
                            label: "X",
                            value: controller.gradient.value.end!.x,
                            min: -1.0,
                            max: 1.0,
                            onChanged: (value) {
                              controller.onEndXChanged(value);
                            },
                            canEdit: false,
                          ),
                        ),
                        Expanded(
                          child: CustomSlider(
                            label: "Y",
                            value: controller.gradient.value.end!.y,
                            min: -1.0,
                            max: 1.0,
                            onChanged: (value) {
                              controller.onEndYChanged(value);
                            },
                            canEdit: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const ToolStopsWidget(),
              const SizedBox(height: 10),
              Visibility(
                visible: controller.gradient.value.type == GradientType.sweep,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSlider(
                          label: "Start Angle",
                          value: controller.gradient.value.startAngle,
                          min: 0,
                          max: 3.14 * 2,
                          onChanged: (value) {
                            controller.onStartAngleChanged(value);
                          },
                          canEdit: false,
                        ),
                      ),
                      Expanded(
                        child: CustomSlider(
                          label: "End Angle",
                          value: controller.gradient.value.endAngle,
                          min: 0,
                          max: 3.14 * 2,
                          onChanged: (value) {
                            controller.onEndAngleChanged(value);
                          },
                          canEdit: false,
                          onMaxChanged: (value) {},
                          onMinChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: controller.gradient.value.type != GradientType.linear,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSlider(
                          label: "Center X",
                          value: controller.gradient.value.center!.x,
                          min: -1.0,
                          max: 1.0,
                          onChanged: (value) {
                            controller.onCenterXChanged(value);
                          },
                          canEdit: false,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: CustomSlider(
                          label: "Center Y",
                          value: controller.gradient.value.center!.y,
                          min: -1.0,
                          max: 1.0,
                          onChanged: (value) {
                            controller.onCenterYChanged(value);
                          },
                          canEdit: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

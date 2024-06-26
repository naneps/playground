import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/inputs/action_chips_seclector.dart';
import 'package:playground/app/common/ui/inputs/colors_picker.widget.dart';
import 'package:playground/app/models/gradient.model.dart';
import 'package:playground/app/modules/box_shadow_generator/widgets/custom_slider.widget.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';

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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    Expanded(
                      child: ActionChipsSelector<GradientType>(
                        items: GradientType.values,
                        label: 'Gradient Type',
                        titleBuilder: (type) => type.toString().split('.').last,
                        initialValues: [controller.gradient.value.type],
                        onChanged: (selectedValues) {
                          // Handle single selection
                          if (selectedValues.isNotEmpty) {
                            GradientType selectedType = selectedValues.first;
                            controller.onGradientTypeChanged(selectedType);
                          }
                        },
                        multipleSelection: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ActionChipsSelector<TileModeType>(
                        items: TileModeType.values,
                        label: 'Tile Mode',
                        titleBuilder: (type) => type.toString().split('.').last,
                        initialValues: [controller.gradient.value.tileMode],
                        onChanged: (selectedValues) {
                          // Handle single selection
                          if (selectedValues.isNotEmpty) {
                            TileModeType selectedType = selectedValues.first;
                            controller.onTileModeChanged(selectedType);
                          }
                        },
                        multipleSelection: false,
                      ),
                    ),
                  ],
                ),
              ),
              //
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
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Gradient Settings',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          // button clear stops
                          if (controller.gradient.value.stops != null) ...[
                            TextButton(
                              onPressed: () {
                                controller.removeStops();
                              },
                              child: const Text('Clear Stops'),
                            ),
                          ] else ...[
                            // button add stops
                            TextButton(
                              onPressed: () {
                                controller.onAddStops();
                              },
                              child: const Text('Add Stops'),
                            ),
                          ],
                        ]),
                    const SizedBox(height: 10),
                    if (controller.gradient.value.stops != null) ...[
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 3.5,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.gradient.value.stops!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomSlider(
                                  label: "Stop ${index + 1}",
                                  value: controller
                                      .gradient.value.stops![index].stop,
                                  min: 0,
                                  max: 1,
                                  onChanged: (value) {
                                    controller.onStopValueChanged(index, value);
                                  },
                                  canEdit: false,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: controller
                                    .gradient.value.stops![index].color,
                                radius: 10,
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ],
                ),
              ),
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

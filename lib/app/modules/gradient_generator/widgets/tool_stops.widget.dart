import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/box_shadow_generator/widgets/custom_slider.widget.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';

class ToolStopsWidget extends GetView<GradientGeneratorController> {
  const ToolStopsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: Obx(() {
        return Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;
                  if (constraints.maxWidth < 600) {
                    crossAxisCount = 1;
                  } else {
                    crossAxisCount = 2;
                  }
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3.5,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.gradient.value.stops!.length,
                    itemBuilder: (context, index) {
                      return CustomSlider(
                        label: "Stop ${index + 1}",
                        labelBuilder: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Stop ${index + 1}",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor:
                                  controller.gradient.value.stops![index].color,
                            )
                          ],
                        ),
                        value: controller.gradient.value.stops![index].stop,
                        min: 0,
                        max: 1,
                        onChanged: (value) {
                          controller.onStopValueChanged(index, value);
                        },
                        canEdit: false,
                      );
                    },
                  );
                },
              )
            ],
          ],
        );
      }),
    );
  }
}

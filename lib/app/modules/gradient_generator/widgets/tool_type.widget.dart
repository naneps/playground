import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/inputs/action_chips_seclector.dart';
import 'package:playground/app/enums/gradient.enum.dart';
import 'package:playground/app/modules/gradient_generator/controllers/gradient_generator_controller.dart';

class ToolTypeWidget extends GetView<GradientGeneratorController> {
  const ToolTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          LayoutBuilder(builder: (context, constraint) {
            if (constraint.maxWidth < 600) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGradientType(),
                  const SizedBox(height: 10),
                  _buildGradientTile(),
                ],
              );
            } else {
              return Row(
                children: [
                  Expanded(
                    child: _buildGradientType(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildGradientTile(),
                  ),
                ],
              );
            }
          }),
        ],
      ),
    );
  }

  ActionChipsSelector<TileModeType> _buildGradientTile() {
    return ActionChipsSelector<TileModeType>(
      items: TileModeType.values,
      label: 'Tile Mode',
      titleBuilder: (type) => Text(type.toString().split('.').last),
      initialValues: [controller.gradient.value.tileMode],
      onChanged: (selectedValues) {
        // Handle single selection
        if (selectedValues.isNotEmpty) {
          TileModeType selectedType = selectedValues.first;
          controller.onTileModeChanged(selectedType);
        }
      },
      multipleSelection: false,
    );
  }

  ActionChipsSelector<GradientType> _buildGradientType() {
    return ActionChipsSelector<GradientType>(
      items: GradientType.values,
      label: 'Gradient Type',
      titleBuilder: (type) => Text(type.toString().split('.').last),
      initialValues: [controller.gradient.value.type],
      onChanged: (selectedValues) {
        // Handle single selection
        if (selectedValues.isNotEmpty) {
          GradientType selectedType = selectedValues.first;
          controller.onGradientTypeChanged(selectedType);
        }
      },
      multipleSelection: false,
    );
  }
}

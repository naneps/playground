import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';

import '../controllers/ui_components_controller.dart';

class UiComponentsView extends GetView<UiComponentsController> {
  const UiComponentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayout(mobile: Column()),
    );
  }
}

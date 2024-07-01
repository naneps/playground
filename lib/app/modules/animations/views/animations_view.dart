import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';

import '../controllers/animations_controller.dart';

class AnimationsView extends GetView<AnimationsController> {
  const AnimationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          Center(
            child: Text(
              'AnimationsView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

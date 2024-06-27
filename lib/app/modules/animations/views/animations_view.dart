import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/animations_controller.dart';

class AnimationsView extends GetView<AnimationsController> {
  const AnimationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AnimationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AnimationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

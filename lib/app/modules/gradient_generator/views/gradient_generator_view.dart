import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/gradient_generator_controller.dart';

class GradientGeneratorView extends GetView<GradientGeneratorController> {
  const GradientGeneratorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GradientGeneratorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GradientGeneratorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

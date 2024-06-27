import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ui_components_controller.dart';

class UiComponentsView extends GetView<UiComponentsController> {
  const UiComponentsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UiComponentsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UiComponentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

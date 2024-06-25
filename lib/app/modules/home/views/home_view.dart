import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: controller.navigationList.length,
          itemBuilder: (context, index) {
            final item = controller.navigationList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0.5,
              color: Colors.blueGrey[50],
              child: ListTile(
                title: Text(item.title!),
                onTap: () => Get.toNamed(item.route!),
              ),
            );
          },
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      children: [
        CustomAppBar(),
        Row(
          children: [],
        )
      ],
    ));
  }
}

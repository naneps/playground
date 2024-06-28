// forum_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/forum/controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResponsiveLayout(
      mobile: const Column(),
      tablet: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.amber,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 104, 255, 109),
            ),
          )
        ],
      ),
      desktop: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.amber,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.blue,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green,
            ),
          )
        ],
      ),
    ));
  }
}

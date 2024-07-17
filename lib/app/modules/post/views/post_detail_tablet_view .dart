import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';
import 'package:playground/app/modules/post/views/post_view.dart';

class PostDetailTabletView extends GetView<PostDetailController> {
  const PostDetailTabletView({super.key});
  @override
  get controller =>
      Get.put(PostDetailController(), tag: 'post_detail${Get.arguments}');
  @override
  String get tag => 'post_detail${Get.arguments}';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.red.shade400,
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(color: Colors.red.shade100, child: const PostView()),
        ),
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.red.shade400,
          ),
        ),
      ],
    );
  }
}

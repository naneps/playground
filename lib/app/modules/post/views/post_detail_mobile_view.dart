import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';
import 'package:playground/app/modules/post/views/post_view.dart';

class PostDetailMobileView extends GetView<PostDetailController> {
  const PostDetailMobileView({super.key});
  @override
  get controller =>
      Get.put(PostDetailController(), tag: 'post_detail${Get.arguments}');
  @override
  String get tag => 'post_detail${Get.arguments}';
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        PostView(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/post/controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});
  @override
  get controller => Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'create_post',
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          centerTitle: true,
        ),
        body: const Column(),
      ),
    );
  }
}

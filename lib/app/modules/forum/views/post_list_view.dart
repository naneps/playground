import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/forum/controllers/post_controller.dart';
import 'package:playground/app/modules/forum/widgets/post_widget.dart';

class PostListView extends GetView<PostController> {
  const PostListView({super.key});

  @override
  get controller => Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) {
        final post = controller.posts[index];
        return PostWidget(post: post);
      },
      itemCount: controller.posts.length,
    );
  }
}

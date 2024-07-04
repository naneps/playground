import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/forum/widgets/post_widget.dart';
import 'package:playground/app/modules/post/controllers/post_controller.dart';

class PostListView extends GetView<PostController> {
  final EdgeInsets padding;
  const PostListView({super.key, this.padding = EdgeInsets.zero});
  @override
  get controller => Get.put(PostController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.posts.isEmpty) {
        return const SliverToBoxAdapter(
          child: Center(
            child: Text('No posts available.'),
          ),
        );
      }
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!controller.isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.fetchMorePosts();
            return true;
          }
          return false;
        },
        child: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final post = controller.posts[index];
              return Padding(
                      padding: padding,
                      child: PostWidget(
                        post: post,
                        onLike: () => controller.toggleLike(post),
                        isLiked: controller.isPostLiked(post),
                      )).animate().slideX(
                    begin: 1,
                    end: 0,
                    delay: Duration(milliseconds: (100 * index).clamp(0, 500)),
                  );
            },
            childCount: controller.posts.length,
          ),
        ),
      );
    });
  }
}

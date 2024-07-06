import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
        return SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(MdiIcons.inboxArrowDownOutline,
                  size: 100, color: Theme.of(context).primaryColor),
              Text('No posts available.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
            ],
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

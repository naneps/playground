import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';
import 'package:playground/app/modules/post/views/post_detail_mobile_view.dart';
import 'package:playground/app/modules/post/views/post_detail_tablet_view%20.dart';

class PostDetailView extends GetView<PostDetailController> {
  const PostDetailView({super.key});
  @override
  get controller => Get.put(
        PostDetailController(),
        tag: 'post_detail${Get.arguments}',
      );
  @override
  String get tag => 'post_detail${Get.arguments}';
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: Text(controller.post.value.title!),
            centerTitle: true,
          ),
          body: const ResponsiveLayout(
            mobile: PostDetailMobileView(),
            tablet: PostDetailTabletView(),
          ),
        );
      }),
    );
  }
}

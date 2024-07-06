import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';

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
          body: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: HtmlWidget(
                    controller.post.value.content!,
                  ))
            ],
          ),
        );
      }),
    );
  }
}

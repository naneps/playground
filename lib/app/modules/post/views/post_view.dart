import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:playground/app/common/ui/code_preview.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';

class PostView extends GetView<PostDetailController> {
  const PostView({super.key});
  @override
  get controller =>
      Get.put(PostDetailController(), tag: 'post_detail${Get.arguments}');
  @override
  String get tag => 'post_detail${Get.arguments}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: MarkdownWidget(
                data: controller.post.value.content ?? '',
                shrinkWrap: true,
                config: MarkdownConfig(configs: [
                  CodeConfig(
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade800,
                      backgroundColor: Colors.grey.shade300,
                      fontFamily: 'monospace',
                    ),
                  ),
                  PreConfig(
                    wrapper: (child, code, language) => CodeWrapperWidget(
                      child,
                      code,
                      language,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

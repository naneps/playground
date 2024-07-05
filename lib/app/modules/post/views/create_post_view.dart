import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/post/controllers/create_post_controller.dart';
import 'package:playground/app/modules/post/views/form_create_post.dart';

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
        body: const ResponsiveLayout(
          mobile: FormCreatePost(),
          tablet: FormCreatePost(),
          desktop: Row(
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: FormCreatePost(),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

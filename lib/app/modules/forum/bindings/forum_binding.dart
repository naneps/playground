import 'package:get/get.dart';

import 'package:playground/app/modules/forum/controllers/post_controller.dart';

import '../controllers/forum_controller.dart';

class ForumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(),
    );
    Get.lazyPut<ForumController>(
      () => ForumController(),
    );
  }
}

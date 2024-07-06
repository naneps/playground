import 'package:get/get.dart';
import 'package:playground/app/modules/post/controllers/create_post_controller.dart';
import 'package:playground/app/modules/post/controllers/post_detail_controller.dart';

import '../controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailController>(
      () => PostDetailController(),
    );
    Get.lazyPut<CreatePostController>(
      () => CreatePostController(),
    );
    Get.lazyPut<PostController>(
      () => PostController(),
    );
  }
}

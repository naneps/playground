import 'package:get/get.dart';
import 'package:playground/app/models/post_model.dart';
import 'package:playground/app/repositories/post_repository.dart';

class PostDetailController extends GetxController {
  final postRepository = Get.find<PostRepository>();
  Rx<PostModel> post = PostModel().obs;
//   stream
  void getPostStream() {
    postRepository.streamOne(Get.arguments).listen((newPost) {
      post.value = newPost;
    });
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      getPostStream();
    }
  }
}

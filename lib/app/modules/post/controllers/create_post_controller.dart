import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/post_model.dart';
import 'package:playground/app/repositories/post_repository.dart';
import 'package:playground/app/services/user_service_information.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

class CreatePostController extends GetxController {
  late QuillEditorController qController;
  Rx<PostModel> post = PostModel().obs;
  final userService = Get.find<UserService>();
  final postRepository = Get.find<PostRepository>();
  void createPost() async {
    try {
      print('Create Post');
      await postRepository.add(post.value.copyWith(
        author: userService.user.value,
        authorId: userService.user.value.uid,
        createdAt: Timestamp.now().toDate(),
        likedBy: [],
        likes: 0,
        comments: 0,
        views: 0,
        hashtags: [],
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    qController = QuillEditorController();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/post_model.dart';
import 'package:playground/app/modules/auth/views/auth_view.dart';
import 'package:playground/app/modules/auth/widgets/email_verifictaion.widget.dart';
import 'package:playground/app/modules/post/views/create_post_view.dart';
import 'package:playground/app/repositories/post_repository.dart';
import 'package:playground/app/services/user_service_information.dart';

class PostController extends GetxController {
  final userSerVice = Get.find<UserService>();
  final postRepository = Get.find<PostRepository>();
  RxList<PostModel> posts = <PostModel>[].obs;
  DocumentSnapshot? lastDocument;
  bool isLoading = false;
  final int limit = 3;

  Future<void> createPost() async {
    if (userSerVice.user.value.uid != null) {
      final isVerified = await userSerVice.isEmailVerified();
      if (isVerified) {
        // Create post
        Get.to(() => const CreatePostView());
      } else {
        Get.dialog(
          EmailVerificationWidget(email: userSerVice.user.value.email!),
        );
      }
    } else {
      Get.dialog(const AuthView());
    }
  }

  void fetchMorePosts({
    Map<String, dynamic>? filters,
  }) async {
    await fetchPosts(filters: filters);
  }

  Future<void> fetchPosts({
    Map<String, dynamic>? filters,
  }) async {
    if (isLoading) return;
    isLoading = true;
    final newPosts = await postRepository.getFiltered(
      filters: filters ?? {},
      startAfter: lastDocument,
      limit: limit,
    );
    if (newPosts.isNotEmpty) {
      lastDocument = newPosts.last as DocumentSnapshot;
      posts.addAll(newPosts);
    }
    isLoading = false;
    update();
  }

  void getPostsStream() {
    postRepository.streamAll().listen((newPosts) {
      posts.assignAll(newPosts);
    });
  }

  bool isPostLiked(PostModel post) {
    if (userSerVice.user.value.uid == null) return false;
    return post.likedBy!.contains(userSerVice.uid);
  }

  @override
  void onInit() {
    super.onInit();
    getPostsStream();
  }

  Future<void> toggleLike(PostModel post) async {
    if (isPostLiked(post)) {
      await postRepository.unlikePost(post.id!, userSerVice.uid);
    } else {
      await postRepository.likePost(post.id!, userSerVice.uid);
    }
    update();
  }
}

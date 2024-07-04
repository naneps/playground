import 'package:get/get.dart';
import 'package:playground/app/models/post_model.dart';

class CreatePostController extends GetxController {
  Rx<PostModel> post = PostModel().obs;
}

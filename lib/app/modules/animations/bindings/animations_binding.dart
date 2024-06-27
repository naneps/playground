import 'package:get/get.dart';

import '../controllers/animations_controller.dart';

class AnimationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnimationsController>(
      () => AnimationsController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/box_shadow_generator_controller.dart';

class BoxShadowGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoxShadowGeneratorController>(
      () => BoxShadowGeneratorController(),
    );
  }
}

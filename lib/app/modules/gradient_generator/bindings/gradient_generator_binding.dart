import 'package:get/get.dart';

import '../controllers/gradient_generator_controller.dart';

class GradientGeneratorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GradientGeneratorController>(
      () => GradientGeneratorController(),
    );
  }
}

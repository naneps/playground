import 'package:get/get.dart';

import '../controllers/ui_components_controller.dart';

class UiComponentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UiComponentsController>(
      () => UiComponentsController(),
    );
  }
}

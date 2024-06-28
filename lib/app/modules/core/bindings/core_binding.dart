import 'package:get/get.dart';
import 'package:playground/app/services/user_service_information.dart';

import '../controllers/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(
      () => CoreController(),
    );
    Get.lazyPut<UserService>(
      () => UserService(),
    );
  }
}

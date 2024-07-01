import 'package:get/get.dart';
import 'package:playground/app/services/auth_service.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.lazyPut<AuthService>(() => AuthService());
  }
}

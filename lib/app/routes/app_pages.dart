import 'package:get/get.dart';

import '../modules/box_shadow_generator/bindings/box_shadow_generator_binding.dart';
import '../modules/box_shadow_generator/views/box_shadow_generator_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/gradient_generator/bindings/gradient_generator_binding.dart';
import '../modules/gradient_generator/views/gradient_generator_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CORE,
      page: () => const CoreView(),
      binding: CoreBinding(),
    ),
    GetPage(
      name: _Paths.BOX_SHADOW_GENERATOR,
      page: () => const BoxShadowGeneratorView(),
      binding: BoxShadowGeneratorBinding(),
    ),
    GetPage(
      name: _Paths.GRADIENT_GENERATOR,
      page: () => const GradientGeneratorView(),
      binding: GradientGeneratorBinding(),
    ),
  ];

  AppPages._();
}

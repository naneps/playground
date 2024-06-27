import 'package:get/get.dart';

import '../modules/animations/bindings/animations_binding.dart';
import '../modules/animations/views/animations_view.dart';
import '../modules/box_shadow_generator/bindings/box_shadow_generator_binding.dart';
import '../modules/box_shadow_generator/views/box_shadow_generator_view.dart';
import '../modules/core/bindings/core_binding.dart';
import '../modules/core/views/core_view.dart';
import '../modules/forum/bindings/forum_binding.dart';
import '../modules/forum/views/forum_view.dart';
import '../modules/gradient_generator/bindings/gradient_generator_binding.dart';
import '../modules/gradient_generator/views/gradient_generator_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tools/bindings/tools_binding.dart';
import '../modules/tools/views/tools_view.dart';
import '../modules/ui_components/bindings/ui_components_binding.dart';
import '../modules/ui_components/views/ui_components_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.CORE;

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
        bindings: [
          CoreBinding(),
          BoxShadowGeneratorBinding(),
          GradientGeneratorBinding(),
          ForumBinding(),
          ToolsBinding(),
          AnimationsBinding(),
          UiComponentsBinding(),
        ]),
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
    GetPage(
      name: _Paths.FORUM,
      page: () => const ForumView(),
      binding: ForumBinding(),
    ),
    GetPage(
      name: _Paths.TOOLS,
      page: () => const ToolsView(),
      binding: ToolsBinding(),
    ),
    GetPage(
      name: _Paths.ANIMATIONS,
      page: () => const AnimationsView(),
      binding: AnimationsBinding(),
    ),
    GetPage(
      name: _Paths.UI_COMPONENTS,
      page: () => const UiComponentsView(),
      binding: UiComponentsBinding(),
    ),
  ];

  AppPages._();
}

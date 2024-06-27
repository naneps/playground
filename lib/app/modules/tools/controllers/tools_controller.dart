import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/models/navigation.model.dart';
import 'package:playground/app/routes/app_pages.dart';

class ToolsController extends GetxController {
  //TODO: Implement ToolsController
  RxList<NavigationModel> navigationList = <NavigationModel>[
    NavigationModel(
      title: 'Box Shadow Generator',
      iconData: MdiIcons.boxShadow,
      route: Routes.BOX_SHADOW_GENERATOR,
    ),
    NavigationModel(
      title: 'Gradient Generator',
      iconData: MdiIcons.gradientHorizontal,
      route: Routes.GRADIENT_GENERATOR,
    ),
  ].obs;
}

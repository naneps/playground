import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/models/navigation.model.dart';
import 'package:playground/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreController extends GetxController {
  //TODO: Implement CoreController
  ZoomDrawerController zoomController = ZoomDrawerController();
  RxInt currentIndex = 0.obs;
  RxList<NavigationModel> navigations = <NavigationModel>[
    NavigationModel(
      title: 'Home',
      icon: 'home',
      route: Routes.HOME,
      iconData: MdiIcons.home,
    ),
    NavigationModel(
      title: 'UI Components',
      route: Routes.CORE,
      iconData: MdiIcons.widgets,
    ),
    NavigationModel(
      title: 'Animations',
      icon: 'animation',
      iconData: MdiIcons.animation,
      route: 'animations',
    ),
    // tools
    NavigationModel(
      title: 'Tools',
      icon: 'tools',
      route: '',
      iconData: MdiIcons.tools,
    ),
    NavigationModel(
      title: 'Forum',
      icon: 'contact',
      route: Routes.FORUM,
      iconData: MdiIcons.forum,
    ),
  ].obs;

  void changeIndex(indexOf) {
    currentIndex.value = indexOf;
  }

  Future<void> gotoGithub() async {
    await launchUrl(Uri.parse('https://github.com/naneps/playground'));
  }
}

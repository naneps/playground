import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/models/navigation.model.dart';
import 'package:playground/app/routes/app_pages.dart';
import 'package:playground/app/services/user_service_information.dart';
import 'package:url_launcher/url_launcher.dart';

class CoreController extends GetxController {
  //TODO: Implement CoreController
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userService = Get.find<UserService>();
  RxBool isLogin = false.obs;
  Rx<User?> user = Rx<User?>(null);
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

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    if (user.value != null) {
      userService.setUserOnlineStatus(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _auth.authStateChanges().listen((User? user) {
      print("Auth Changes");
      print('User: $user');
      if (user != null) {
        isLogin.value = true;
        userService.setUserOnlineStatus(true);
      } else {
        isLogin.value = false;
        userService.setUserOnlineStatus(false);
      }
      this.user.value = user;
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (user.value != null) {
      userService.setUserOnlineStatus(true);
    }
  }
}

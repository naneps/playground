import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/routes/app_pages.dart';
import 'package:playground/app/services/notification_service.dart';
import 'package:playground/app/services/user_service_information.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Playground',
      theme: ThemeApp(context: context).themeData(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      darkTheme: ThemeApp(context: context).darkThemeData(),
      defaultTransition: Transition.fadeIn,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        overscroll: true,
        physics: const BouncingScrollPhysics(),
      ),
      onInit: () {},
      onReady: () {
        Get.find<NotificationService>();
        Get.find<UserService>().setUserOnlineStatus(true);
      },
      onDispose: () {
        print('onDispose');
        Get.find<UserService>().setUserOnlineStatus(false);
      },
    );
  }
}

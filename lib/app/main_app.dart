import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/routes/app_pages.dart';
import 'package:playground/app/services/user_service_information.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Playground',
      theme: ThemeApp(context: context).themeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        overscroll: true,
        physics: const BouncingScrollPhysics(),
      ),
      onInit: () {},
      onReady: () {
        Get.find<UserService>().setUserOnlineStatus(true);
      },
      onDispose: () {
        print('onDispose');
        Get.find<UserService>().setUserOnlineStatus(false);
      },
    );
  }
}

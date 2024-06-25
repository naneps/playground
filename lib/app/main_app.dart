import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/routes/app_pages.dart';

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
    );
  }
}

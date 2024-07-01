import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/theme.dart';
import 'package:playground/app/common/ui/navigation_tile.dart';
import 'package:playground/app/modules/animations/views/animations_view.dart';
import 'package:playground/app/modules/forum/views/forum_view.dart';
import 'package:playground/app/modules/home/views/home_view.dart';
import 'package:playground/app/modules/tools/views/tools_view.dart';
import 'package:playground/app/modules/ui_components/views/ui_components_view.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: controller.zoomController,
      style: DrawerStyle.style4,
      closeCurve: Curves.easeInOutBack,
      menuBackgroundColor: Colors.white,
      drawerShadowsBackgroundColor: Colors.grey.shade300,
      overlayBlur: 0.5,
      menuScreen: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Obx(() {
                    return ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var item in controller.navigations)
                          NavigationTile(
                            item: item,
                            badge: item.badge,
                            onTap: () {
                              controller.changeIndex(
                                controller.navigations.indexOf(item),
                              );
                              controller.zoomController.toggle!();
                            },
                            isActive: controller.currentIndex.value ==
                                controller.navigations.indexOf(item),
                          ),
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(color: Colors.grey.shade200),
                  // help and support
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity.compact,
                    leading: Icon(MdiIcons.helpCircle,
                        color: ThemeApp().primaryColor),
                    title: Text('Help & Support',
                        style: Get.textTheme.labelMedium!.copyWith(
                          color: ThemeApp().primaryColor,
                        )),
                    onTap: () {},
                  ),
                  Obx(() {
                    return Visibility(
                      visible: controller.isLogin.value,
                      child: ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(MdiIcons.logout,
                            color: ThemeApp().dangerColor),
                        title: Text('Logout',
                            style: Get.textTheme.labelMedium!.copyWith(
                              color: ThemeApp().dangerColor,
                            )),
                        onTap: () {},
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
      mainScreen: Scaffold(body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            HomeView(),
            UiComponentsView(),
            AnimationsView(),
            ToolsView(),
            ForumView()
            // OrderView(),
            // CartView(),
          ],
        );
      })),
    );
  }
}

// forum_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';
import 'package:playground/app/modules/forum/controllers/forum_controller.dart';
import 'package:playground/app/modules/forum/views/forum_mobile_view.dart';
import 'package:playground/app/modules/forum/views/forum_tablet_view.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: ResponsiveLayout(
          mobile: ForumMobileView(),
          tablet: ForumTabletView(),
        ),
      ),
    );
  }
}

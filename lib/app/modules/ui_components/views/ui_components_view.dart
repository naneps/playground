import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/custom_app_bar.dart';
import 'package:playground/app/common/ui/content_image_carousel.dart';
import 'package:playground/app/common/ui/responsive_layout.dart';

import '../controllers/ui_components_controller.dart';

class UiComponentsView extends GetView<UiComponentsController> {
  const UiComponentsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          Expanded(
            child: ResponsiveLayout(
              mobile: const Column(
                children: [],
              ),
              tablet: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red.shade400,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey.shade200,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ContentImageCarousel(
                            images: [
                              'https://images.unsplash.com/photo-1720983627245-ca4a6913016f?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'https://images.unsplash.com/photo-1718027808460-7069cf0ca9ae?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'https://images.unsplash.com/photo-1720543227828-ec5ae842633a?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                              'https://plus.unsplash.com/premium_photo-1664699106133-c338e54d395b?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.red.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/common/ui/overlays/scalled_dialog.dart';
import 'package:playground/app/modules/auth/views/form_login.dart';
import 'package:playground/app/modules/auth/views/form_register.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  get controller => Get.put(AuthController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ScaleDialog(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          scrollable: true,
          backgroundColor: Colors.transparent,
          content: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: 400,
              maxHeight: Get.height * 0.8,
              minWidth: 400,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    controller: controller.tabController,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    indicatorSize: TabBarIndicatorSize.tab,
                    onTap: controller.changeTabIndex,
                    tabs: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [],
                        ),
                        alignment: Alignment.center,
                        child: const Text('Sign In'),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [],
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/icons/icon.png',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 5),
                  Text.rich(
                    TextSpan(
                      text: 'Welcome to ',
                      children: [
                        TextSpan(
                          text: 'Play',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                        ),
                        TextSpan(
                          text: 'ground',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  if (controller.tabIndex.value == 0) ...[
                    const FormLogin(),
                  ] else ...[
                    const FormRegister(),
                  ],
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

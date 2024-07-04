import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/services/auth_service.dart';

class CountdownController extends GetxController {
  var countdown = 120.obs; // 2 minutes countdown
  late Timer _timer;

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  void resetCountdown() {
    countdown.value = 120; // reset countdown
    _timer.cancel();
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        _timer.cancel();
      }
    });
  }
}

class EmailVerificationWidget extends GetView<CountdownController> {
  final String? email;

  const EmailVerificationWidget({super.key, this.email});
  @override
  get controller => Get.put(CountdownController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            content: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    MdiIcons.emailOutline,
                    size: 100,
                    color: Theme.of(Get.context!).primaryColor,
                  ),
                  const SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      text: 'We have sent a verification email to ',
                      children: [
                        TextSpan(
                          text: email,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(Get.context!).primaryColorDark,
                              ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Please check your email to verify your account',
                    textAlign: TextAlign.center,
                    style: Theme.of(Get.context!).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.countdown.value > 0
                          ? null
                          : () {
                              controller.resetCountdown();
                              // Add your resend email logic here
                              Get.find<AuthService>().sendEmailVerification();
                            },
                      child: Text(
                        controller.countdown.value > 0
                            ? 'Resend Email (${controller.countdown.value})'
                            : 'Resend Email',
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        });
  }
}

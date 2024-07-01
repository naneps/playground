import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/inputs/input_secure.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/modules/auth/controllers/auth_controller.dart';

class FormRegister extends GetView<AuthController> {
  const FormRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [],
      ),
      child: Form(
        key: controller.signUpFormKey,
        canPop: (controller.user.email!.isEmpty &&
            controller.user.password!.isEmpty),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Let\'s create your account',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            XInput(hintText: 'Name', prefixIcon: Icon(MdiIcons.accountOutline)),
            const SizedBox(height: 10),
            XInput(
              hintText: 'Email',
              prefixIcon: Icon(MdiIcons.emailOutline),
              onChanged: (val) {
                controller.user.email = val;
              },
            ),
            const SizedBox(height: 10),
            SecureInput(
              onChanged: (val) {
                controller.user.password = val;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Sign up'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              icon: Icon(MdiIcons.github),
              label: const Text('Sign up with Github'),
            ),
          ],
        ),
      ),
    );
  }
}

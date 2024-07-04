import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/inputs/input_secure.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';
import 'package:playground/app/modules/auth/controllers/auth_controller.dart';

class FormLogin extends GetView<AuthController> {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Form(
        key: controller.signInFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign in to your account',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            XInput(
              hintText: 'Email',
              prefixIcon: Icon(MdiIcons.emailOutline),
              onSaved: (value) {
                controller.user.email = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SecureInput(
              onSaved: (value) {
                controller.user.password = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (controller.signInFormKey.currentState!.validate()) {
                  controller.signInFormKey.currentState!.save();
                  controller.signInWithEmailAndPassword();
                }
              },
              child: const Text('Sign in'),
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.signInWithGitHub();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              icon: Icon(MdiIcons.github),
              label: const Text('Sign in with Github'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/forum_controller.dart';

class ForumView extends GetView<ForumController> {
  const ForumView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ForumView'),
        centerTitle: true,
      ),
      body: Center(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          fixedSize: const Size(200, 50),
        ),
        onPressed: () {
          controller.signInWithGithub();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // login with github
            const Text('Login with Github'),
            Icon(MdiIcons.github)
          ],
        ),
      )),
    );
  }
}

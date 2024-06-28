import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/post_controller.dart';

class PostView extends GetView<PostController> {
  const PostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

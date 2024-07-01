import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/modules/auth/controllers/auth_controller.dart';
import 'package:playground/app/services/user_service_information.dart';

class ForumController extends GetxController {
  final AuthController _authController = Get.put(AuthController());
  final userService = Get.find<UserService>();
  final textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      this.user.value = user;
    });
    setupTypingListeners(userService);
  }

  void setupTypingListeners(UserService userService) {
    textController.addListener(() {
      _updateTypingStatus(userService);
    });

    focusNode.addListener(() {
      _updateTypingStatus(userService);
    });
  }

  Future<void> signInWithGitHub() async {
    await _authController.signInWithGitHub();

    user.value = FirebaseAuth.instance.currentUser;
  }

  Future<void> signOut() async {
    await userService.setUserOnlineStatus(false);
    await _authController.signOut();
  }

  void storeAllDummyToFireStore() async {
    try {
      if (user.value != null) {
        final userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.value!.uid);
        final userPostsCollection = userDoc.collection('posts');
      } else {
        print('User is not logged in');
      }
    } catch (e) {
      print('Error storing dummy posts: $e');
    }
  }

  void _updateTypingStatus(UserService userService) {
    bool isTyping = textController.text.isNotEmpty && focusNode.hasFocus;
    userService.setUserIsTyping(isTyping, 'forum');
  }
}

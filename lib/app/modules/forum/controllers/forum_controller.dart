import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/post_model.dart';
import 'package:playground/app/models/user.model.dart';
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

  void _updateTypingStatus(UserService userService) {
    bool isTyping = textController.text.isNotEmpty && focusNode.hasFocus;
    userService.setUserIsTyping(isTyping, 'forum');
  }

  List<PostModel> dummyPosts = [
    PostModel(
      id: '1',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      imageUrl:
          'https://images.unsplash.com/photo-1571925324027-3b9737413913?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '123',
        name: 'John Doe',
        avatar: 'https://randomuser.me/api/portraits/lego/1.jpg',
        email: 'john.doe@example.com',
      ),
      hashtags: ['flutter', 'dart', 'firebase'],
      views: 10,
      comments: 10,
      likes: 20,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    PostModel(
      id: '2',
      content:
          'Another post content here. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      imageUrl:
          'https://images.unsplash.com/photo-1601925324027-3b9737413913?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '124',
        name: 'Jane Smith',
        avatar: 'https://randomuser.me/api/portraits/lego/2.jpg',
        email: 'jane.smith@example.com',
      ),
      hashtags: ['flutter', 'web', 'design'],
      views: 5,
      comments: 2,
      likes: 8,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PostModel(
      id: '3',
      content:
          'Post number three content. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      imageUrl:
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '125',
        name: 'Alice Johnson',
        avatar: 'https://randomuser.me/api/portraits/lego/3.jpg',
        email: 'alice.johnson@example.com',
      ),
      hashtags: ['mobile', 'development'],
      views: 15,
      comments: 5,
      likes: 30,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    PostModel(
      id: '4',
      content:
          'Fourth post content. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      imageUrl:
          'https://images.unsplash.com/photo-1491927573387-1e30f223e1e1?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '126',
        name: 'Bob Brown',
        avatar: 'https://randomuser.me/api/portraits/lego/4.jpg',
        email: 'bob.brown@example.com',
      ),
      hashtags: ['backend', 'api', 'rest'],
      views: 8,
      comments: 3,
      likes: 12,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PostModel(
      id: '5',
      content:
          'Fifth post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      imageUrl:
          'https://images.unsplash.com/photo-1551650975-65b19c5c8792?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '127',
        name: 'Charlie Davis',
        avatar: 'https://randomuser.me/api/portraits/lego/5.jpg',
        email: 'charlie.davis@example.com',
      ),
      hashtags: ['frontend', 'react'],
      views: 12,
      comments: 4,
      likes: 18,
      createdAt: DateTime.now().subtract(const Duration(hours: 10)),
    ),
    PostModel(
      id: '6',
      content:
          'Sixth post content. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      imageUrl:
          'https://images.unsplash.com/photo-1487260211183-ec2421d68b79?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '128',
        name: 'Daisy Evans',
        avatar: 'https://randomuser.me/api/portraits/lego/6.jpg',
        email: 'daisy.evans@example.com',
      ),
      hashtags: ['cloud', 'aws'],
      views: 20,
      comments: 7,
      likes: 25,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    PostModel(
      id: '7',
      content:
          'Seventh post content. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      imageUrl:
          'https://images.unsplash.com/photo-1593642532871-8b12e02d091c?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '129',
        name: 'Ethan Foster',
        avatar: 'https://randomuser.me/api/portraits/lego/7.jpg',
        email: 'ethan.foster@example.com',
      ),
      hashtags: ['python', 'data'],
      views: 7,
      comments: 2,
      likes: 10,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PostModel(
      id: '8',
      content:
          'Eighth post content. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      imageUrl:
          'https://images.unsplash.com/photo-1593642532871-8b12e02d091c?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '130',
        name: 'Fiona Green',
        avatar: 'https://randomuser.me/api/portraits/lego/8.jpg',
        email: 'fiona.green@example.com',
      ),
      hashtags: ['java', 'spring'],
      views: 18,
      comments: 6,
      likes: 22,
      createdAt: DateTime.now().subtract(const Duration(hours: 7)),
    ),
    PostModel(
      id: '9',
      content:
          'Ninth post content. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      imageUrl:
          'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '131',
        name: 'George Harris',
        avatar: 'https://randomuser.me/api/portraits/lego/9.jpg',
        email: 'george.harris@example.com',
      ),
      hashtags: ['devops', 'ci/cd'],
      views: 22,
      comments: 9,
      likes: 30,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    PostModel(
      id: '10',
      content:
          'Tenth post content. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      imageUrl:
          'https://images.unsplash.com/photo-1517817748490-72b9ce02f237?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      author: UserModel(
        uid: '132',
        name: 'Hannah Johnson',
        avatar: 'https://randomuser.me/api/portraits/lego/10.jpg',
        email: 'hannah.johnson@example.com',
      ),
      hashtags: ['security', 'infosec'],
      views: 25,
      comments: 11,
      likes: 35,
      createdAt: DateTime.now().subtract(const Duration(hours: 15)),
    ),
  ];
}

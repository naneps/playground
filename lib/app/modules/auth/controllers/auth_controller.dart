import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playground/app/models/user.model.dart';
import 'package:playground/app/services/auth_service.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AuthService _authService = Get.put(AuthService(), permanent: true);
  TabController? tabController;
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
  RxInt tabIndex = 0.obs;
  UserModel user = UserModel(
    email: '',
    password: '',
    name: '',
  );
  RxBool isLoading = false.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  Future<void> loginWithEmailAndPassword() async {
    isLoading.value = true;
    await _authService.loginWithEmailAndPassword(
      user.email ?? '',
      user.password ?? '',
    );
    isLoading.value = false;
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  Future<void> registerWithEmailAndPassword() async {
    await _authService.registerWithEmailAndPassword(
      user.email ?? '',
      user.password ?? '',
      user.name ?? '',
    );
  }

  Future<void> signInWithGitHub() async {
    await _authService.signInWithGitHub();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGithub() async {
    try {
      final result = await _auth.signInWithPopup(GithubAuthProvider());
      print(result);

      if (result.user != null) {
        Get.snackbar('Success', 'Logged in successfully');
      }

      Get.snackbar('Error', 'Failed to login');
    } catch (e) {
      print(e);
    }
  }
}

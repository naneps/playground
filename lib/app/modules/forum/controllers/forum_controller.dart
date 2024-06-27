import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ForumController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGithub() async {
    try {
      final result = await _auth.signInWithPopup(GithubAuthProvider());

      if (result.user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        final idToken = await _auth.currentUser!.getIdToken();
        final idTokenResult = await _auth.currentUser!.getIdTokenResult();

        print('ID Token: $idToken');
        print('ID Token Result: $idTokenResult');
        // login with credentials
        final credential = GithubAuthProvider.credential(idToken!);
        final userCredential = await _auth.signInWithCredential(credential);
        print('User Credential: $userCredential');
      } else {
        Get.snackbar('Error', 'Failed to login');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login: $e');
      print('Error during GitHub sign-in: $e');
    }
  }
}

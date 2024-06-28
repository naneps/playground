import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:playground/app/modules/auth/views/github_sign_view.dart';
import 'package:playground/app/services/user_service_information.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userService = Get.find<UserService>();

  Future<http.Response> post(String url, Map<String, String> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Accept': 'application/json',
      },
      body: body,
    );

    return response;
  }

  Future<void> signInWithGitHub() async {
    try {
      if (kIsWeb) {
        // Web-specific code
        final result = await _auth.signInWithPopup(GithubAuthProvider());
        if (result.user != null) {
          Get.snackbar('Success', 'Logged in successfully');
          await userService.createUserInFirestore(result.user!);
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      } else {
        // Mobile-specific code
        // final result = await Get.to(() => const GithubSignView()); change with dialog
        final result = await Get.dialog(
          const AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: GithubSignView(),
          ),
        );
        if (result == null || result is! String) {
          Get.snackbar('Error', 'Failed to get GitHub authorization code');
          return;
        }

        // final code = result;
        final clientID = dotenv.env['GITHUB_CLIENT_ID'];
        final clientSecret = dotenv.env['GITHUB_CLIENT_SECRET'];
        final response = await post(
          'https://github.com/login/oauth/access_token',
          {
            'client_id': clientID!,
            'client_secret': clientSecret!,
            'code': 'XXXX',
          },
        );

        if (response.statusCode != 200) {
          Get.snackbar('Error',
              'Failed to exchange authorization code for access token');
          return;
        }

        final Map<String, dynamic> body = json.decode(response.body);
        final accessToken = body['access_token'];

        final AuthCredential credential =
            GithubAuthProvider.credential(accessToken);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        if (userCredential.user != null) {
          Get.snackbar('Success', 'Logged in successfully');
          await userService.createUserInFirestore(userCredential.user!);
        } else {
          Get.snackbar('Error', 'Failed to login');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to login: $e');
      print('Error during GitHub sign-in: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    userService.setUserOnlineStatus(false);
  }
}

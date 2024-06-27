import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:playground/app/main_app.dart';
import 'package:playground/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

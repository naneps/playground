import 'package:flutter/material.dart';
import 'package:playground/app/main_app.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Highlighter.initialize(['dart', 'yaml', 'sql']);
  runApp(const MainApp());
}

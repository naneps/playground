import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:highlight/highlight.dart' as highlight;

class CodePreview extends StatelessWidget {
  final String code;

  const CodePreview({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    final highlightedCode = highlight.highlight.parse(code, language: 'dart');

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[900],
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: MarkdownBody(
            data: '```dart\n${highlightedCode.toHtml()}\n```',
            styleSheet:
                MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              code: const TextStyle(
                color: Colors.white,
                backgroundColor: Colors.black,
              ),
              codeblockDecoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

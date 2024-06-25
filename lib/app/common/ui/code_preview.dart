import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CodePreview extends StatelessWidget {
  final String code;

  const CodePreview(this.code, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(body: buildMarkdown(context));

  Widget buildMarkdown(BuildContext context) {
    return MarkdownWidget(
      data: code,
      tocController: TocController(),
      config: MarkdownConfig(configs: [
        const HrConfig(),
        const H1Config(),
        const H2Config(),
        const H3Config(),
        const H4Config(),
        const H5Config(),
        const H6Config(),
        const PreConfig(),
        const PConfig(),
        const CodeConfig(
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            backgroundColor: Color.fromARGB(255, 169, 51, 51),
          ),
        ),
        const BlockquoteConfig(),
      ]),
    );
  }
}

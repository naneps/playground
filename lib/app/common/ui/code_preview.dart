import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class CodePreview extends StatelessWidget {
  final String code;

  const CodePreview(this.code, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(body: buildMarkdown(context));

  Widget buildMarkdown(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [],
      ),
      child: MarkdownWidget(
        data: code,
        tocController: TocController(),
        config: MarkdownConfig(configs: [
          PreConfig(
            theme: {
              'comment':
                  const TextStyle(color: Color.fromARGB(255, 57, 31, 255)),
              'quote': const TextStyle(color: Color.fromARGB(255, 6, 27, 255)),
              'variable': const TextStyle(color: Color(0xffd91e18)),
              'template-variable': const TextStyle(color: Color(0xffd91e18)),
              'tag': const TextStyle(color: Color(0xffd91e18)),
              'name': const TextStyle(color: Color(0xffd91e18)),
              'selector-id': const TextStyle(color: Color(0xffd91e18)),
              'selector-class': const TextStyle(color: Color(0xffd91e18)),
              'regexp': const TextStyle(color: Color(0xffd91e18)),
              'deletion': const TextStyle(color: Color(0xffd91e18)),
              'number': const TextStyle(color: Color(0xffaa5d00)),
              'built_in': const TextStyle(color: Color(0xffaa5d00)),
              'builtin-name': const TextStyle(color: Color(0xffaa5d00)),
              'literal': const TextStyle(color: Color(0xffaa5d00)),
              'type': const TextStyle(color: Color(0xffaa5d00)),
              'params': const TextStyle(color: Color(0xffaa5d00)),
              'meta': const TextStyle(color: Color(0xffaa5d00)),
              'link': const TextStyle(color: Color(0xffaa5d00)),
              'attribute': const TextStyle(color: Color(0xffaa5d00)),
              'string': const TextStyle(color: Color(0xff008000)),
              'symbol': const TextStyle(color: Color(0xff008000)),
              'bullet': const TextStyle(color: Color(0xff008000)),
              'addition': const TextStyle(color: Color(0xff008000)),
              'title': const TextStyle(color: Color.fromARGB(255, 0, 191, 255)),
              'section':
                  const TextStyle(color: Color.fromARGB(255, 0, 191, 255)),
              'keyword':
                  const TextStyle(color: Color.fromARGB(255, 188, 54, 255)),
              'selector-tag':
                  const TextStyle(color: Color.fromARGB(255, 190, 60, 255)),
              'root': const TextStyle(
                  backgroundColor: Color(0xfffefefe), color: Color(0xff545454)),
              'emphasis': const TextStyle(fontStyle: FontStyle.italic),
              'strong': const TextStyle(fontWeight: FontWeight.bold),
            },
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            language: 'dart',
            textStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'monospace',
            ),
            wrapper: (child, code, language) => CodeWrapperWidget(
              child,
              code,
              language,
            ),
          ),
          const BlockquoteConfig(),
          const PConfig(),
        ]),
      ),
    );
  }
}

class CodeWrapperWidget extends StatefulWidget {
  final Widget child;
  final String text;
  final String language;

  const CodeWrapperWidget(this.child, this.text, this.language, {super.key});

  @override
  State<CodeWrapperWidget> createState() => _PreWrapperState();
}

class _PreWrapperState extends State<CodeWrapperWidget> {
  late Widget _switchWidget;
  bool hasCopied = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        widget.child,
        Align(
          alignment: Alignment.topRight,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.language.isNotEmpty)
                  SelectionContainer.disabled(
                      child: Container(
                    margin: const EdgeInsets.only(right: 2),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            width: 0.5,
                            color: isDark ? Colors.white : Colors.black)),
                    child: Text(widget.language),
                  )),
                InkWell(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _switchWidget,
                  ),
                  onTap: () async {
                    if (hasCopied) return;
                    await Clipboard.setData(ClipboardData(text: widget.text));
                    _switchWidget = Icon(Icons.check, key: UniqueKey());
                    refresh();
                    Future.delayed(const Duration(seconds: 2), () {
                      hasCopied = false;
                      _switchWidget =
                          Icon(Icons.copy_rounded, key: UniqueKey());
                      refresh();
                    });
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _switchWidget = Icon(Icons.copy_rounded, key: UniqueKey());
  }

  void refresh() {
    if (mounted) setState(() {});
  }
}

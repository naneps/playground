import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:playground/app/common/ui/code_preview.dart';

class MarkdownInput extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const MarkdownInput({super.key, required this.onChanged});

  @override
  State<MarkdownInput> createState() => _MarkdownInputState();
}

enum MarkdownTools {
  bold,
  italic,
  underline,
}

class _MarkdownInputState extends State<MarkdownInput> {
  final TextEditingController _textEditingController = TextEditingController();
  late String _inputText;

  void applyMarkdownTool(MarkdownTools tool) {
    switch (tool) {
      case MarkdownTools.bold:
        _toggleTool(MarkdownTools.bold);
        break;
      case MarkdownTools.italic:
        _toggleTool(MarkdownTools.italic);
        break;
      case MarkdownTools.underline:
        _toggleTool(MarkdownTools.underline);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      constraints: const BoxConstraints(
        minHeight: 300,
        maxHeight: 500,
      ),
      child: DefaultTabController(
        length: 2, // Two tabs: Input and Preview
        child: Column(
          children: [
            TabBar(
              tabs: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.text),
                      const SizedBox(width: 10),
                      const Text('Input'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(MdiIcons.eye),
                      const SizedBox(width: 10),
                      const Text('Preview'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _buildInputTab(),
                  _buildPreviewTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _inputText = '';
  }

  Widget _buildInputTab() {
    return Column(
      children: [
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: 'Type your markdown here...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          maxLines: 30,
          minLines: 5,
          onChanged: (value) {
            setState(() {
              _inputText = value;
              widget.onChanged(value); // Call the callback function
            });
          },
        ),
        // tools section
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var tool in MarkdownTools.values)
                IconButton(
                  icon: Icon(tool.icon),
                  onPressed: () {
                    applyMarkdownTool(tool);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewTab() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MarkdownWidget(
        data: _inputText,
        config: MarkdownConfig(configs: [
          ImgConfig(
            builder: (url, attributes) {
              return Image.network(url);
            },
          ),
          CodeConfig(
              style: TextStyle(
            backgroundColor: Colors.grey.shade100,
            fontFamily: 'monospace',
            fontSize: 12,
          )),
          PreConfig(
            wrapper: (child, code, language) => CodeWrapperWidget(
              child,
              code,
              language,
            ),
          )
        ]),
      ),
    );
  }

  bool _isToolActive(MarkdownTools tool) {
    final String text = _textEditingController.text;
    switch (tool) {
      case MarkdownTools.bold:
        return text.endsWith('**');
      case MarkdownTools.italic:
        return text.endsWith('*');
      case MarkdownTools.underline:
        return text.endsWith('__');
      default:
        return false;
    }
  }

  void _toggleTool(MarkdownTools tool) {
    setState(() {
      switch (tool) {
        case MarkdownTools.bold:
          _textEditingController.text += '**';
          break;
        case MarkdownTools.italic:
          _textEditingController.text += '*';
          break;
        case MarkdownTools.underline:
          _textEditingController.text += '__';
          break;
      }
      _textEditingController.selection =
          TextSelection.collapsed(offset: _textEditingController.text.length);
    });
  }
}

extension MarkdownToolsExtension on MarkdownTools {
  IconData get icon {
    switch (this) {
      case MarkdownTools.bold:
        return MdiIcons.formatBold;
      case MarkdownTools.italic:
        return MdiIcons.formatItalic;
      case MarkdownTools.underline:
        return MdiIcons.formatUnderline;
      default:
        throw Exception('Icon not implemented for this Markdown tool');
    }
  }
}

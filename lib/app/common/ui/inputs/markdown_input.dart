import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MarkdownInput extends StatefulWidget {
  const MarkdownInput({super.key});

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
    return SizedBox.expand(
      child: DefaultTabController(
        length: 2, // Two tabs: Input and Preview
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.edit),
                  text: 'Input',
                ),
                Tab(
                  icon: Icon(Icons.preview),
                  text: 'Preview',
                ),
              ],
            ),
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
        Expanded(
          child: TextField(
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
              });
            },
          ),
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: MarkdownWidget(
          data: _inputText,
          config: MarkdownConfig(configs: [
            PreConfig(
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
            )
          ])),
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

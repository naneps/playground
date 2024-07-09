import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const VerticalText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: text.split('').map((e) {
        return Text(
          e,
          style: style,
        );
      }).toList(),
    );
  }
}

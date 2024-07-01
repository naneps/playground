import 'package:flutter/material.dart';
import 'package:playground/app/common/ui/inputs/x_input.dart';

class SecureInput extends StatefulWidget {
  final String? label;
  final String? initialValue;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  const SecureInput({
    super.key,
    this.label = 'Password',
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  State<SecureInput> createState() => _SecureInputState();
}

class _SecureInputState extends State<SecureInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return XInput(
      label: widget.label!,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      initialValue: widget.initialValue,
      validator: widget.validator,
      obscureText: _obscureText,
      prefixIcon: const Icon(Icons.lock_clock_outlined),
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: _toggleObscureText,
      ),
    );
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

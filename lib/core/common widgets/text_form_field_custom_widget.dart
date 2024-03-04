import 'package:flutter/material.dart';

class TextFormFieldCustomWidget extends StatefulWidget {
  const TextFormFieldCustomWidget(
      {super.key,
      this.hintText,
      this.labelText,
      this.obscureText = false,
      this.autoFocus = false,
      this.focusNode,
      this.errorText,
      required this.onChanged,
      required this.onEditingComplete,
      this.controller,
      required this.validate});

  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final String? errorText;
  final Function(String) onChanged;
  final Function() onEditingComplete;
  final TextEditingController? controller;
  final Function(String) validate;

  @override
  State<TextFormFieldCustomWidget> createState() =>
      _TextFormFieldCustomWidgetState();
}

class _TextFormFieldCustomWidgetState extends State<TextFormFieldCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5,
      ),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        autofocus: widget.autoFocus,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        onEditingComplete: widget.onEditingComplete,
        validator: (value) {
          widget.validate(value!);
          return null;
        },
        onChanged: (value) {
          widget.onChanged(value);
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 20),
            hintText: widget.hintText,
            labelText: widget.labelText,
            errorText: widget.errorText),
      ),
    );
  }
}

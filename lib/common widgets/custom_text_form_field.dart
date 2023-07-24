import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.iconData,
      this.obscureText = false,
      this.autoFocus,
      required this.focusNode,
      this.errorText = '',
      required this.onChanged,
      required this.onEditingComplete,
      this.controller,
      required this.validate})
      : super(key: key);
  final String? hintText;
  final String? labelText;
  final IconData? iconData;
  final bool obscureText;
  final bool? autoFocus;
  final FocusNode focusNode;
  final String errorText;
  final Function(String) onChanged;
  final Function() onEditingComplete;
  final TextEditingController? controller;
  final Function(String) validate;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  _focusListener() {
    setState(() {});
  }

  @override
  void initState() {
    widget.focusNode.addListener(_focusListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextFormField(
        textDirection: TextDirection.ltr,
        autofocus: true,
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
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green),
            ),
            contentPadding: const EdgeInsets.only(top: 20),
            hintText: widget.hintText,
            labelText: widget.labelText,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Icon(widget.iconData),
            ),
            errorText: widget.errorText),
      ),
    );
  }
}

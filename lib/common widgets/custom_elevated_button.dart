import 'package:flutter/material.dart';

class CustomElevatesButton extends StatelessWidget {
  const CustomElevatesButton({Key? key, this.onPressed, this.child})
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

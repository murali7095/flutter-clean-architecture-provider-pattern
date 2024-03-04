import 'package:flutter/material.dart';

class LaptopsWidget extends StatefulWidget {
  const LaptopsWidget({super.key});

  @override
  State<LaptopsWidget> createState() => _LaptopsWidgetState();
}

class _LaptopsWidgetState extends State<LaptopsWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Laptop"),
      ),
    );
  }
}

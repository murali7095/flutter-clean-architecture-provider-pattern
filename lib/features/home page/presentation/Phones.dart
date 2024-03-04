import 'package:flutter/material.dart';

class PhonesWidget extends StatefulWidget {
  const PhonesWidget({super.key});

  @override
  State<PhonesWidget> createState() => _PhonesWidgetState();
}

class _PhonesWidgetState extends State<PhonesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Phone"),
      ),
    );
  }
}

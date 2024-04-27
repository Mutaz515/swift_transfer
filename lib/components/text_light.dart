import 'package:flutter/material.dart';

class TextLight extends StatelessWidget {
  const TextLight(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}

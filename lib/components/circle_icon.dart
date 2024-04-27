import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final Color iconColor;

  const CircleIcon({
    super.key,
    required this.icon,
    this.size = 96,
    this.color = const Color.fromRGBO(24, 74, 255, 1),
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Icon(
          icon,
          size: size * 0.6, // Adjust icon size as needed
          color: iconColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swift_transfer/components/text_bold.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30.0),
          highlightColor: Colors.blue,
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(64.0),
              color: const Color.fromRGBO(231, 236, 252, 1),
            ),
            child: Icon(icon, size: 36.0),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextBold(
          text,
        )
      ],
    );
  }
}

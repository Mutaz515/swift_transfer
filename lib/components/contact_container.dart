import 'package:flutter/material.dart';

import 'package:swift_transfer/components/text_large.dart';

// import 'package:swift_transfer/components/text_medium.dart';

class ContactCointaner extends StatelessWidget {
  const ContactCointaner({
    super.key,
    required this.contactNumber,
  });

  final String contactNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextLarge("+971$contactNumber"),
            ],
          )
        ],
      ),
    );
  }
}

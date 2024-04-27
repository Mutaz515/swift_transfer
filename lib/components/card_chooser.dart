import 'package:flutter/material.dart';
import 'package:swift_transfer/components/long_button.dart';

import 'package:swift_transfer/components/text_large.dart';

import 'package:swift_transfer/components/text_medium.dart';
import 'package:swift_transfer/screens/transaction_status.dart';

class CardChooser extends StatefulWidget {
  const CardChooser({super.key, required this.buttonText});

  final String buttonText;

  @override
  State<CardChooser> createState() => _CardChooserState();
}

class _CardChooserState extends State<CardChooser> {
  void _showCardOptions() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Column(
                  children: [
                    Text('Noon Card'),
                    Text("*************6895"),
                  ],
                ),
                onTap: () {
                  // Handle selection of Card Option 1
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Column(
                  children: [
                    Text('ADCB Card'),
                    Text("*************5585"),
                  ],
                ),
                onTap: () {
                  // Handle selection of Card Option 2
                  Navigator.pop(context);
                },
              ),
              // Add more ListTile widgets for additional card options
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(24),
          left: Radius.circular(24),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const TextLarge("Choose Payment method"),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: _showCardOptions,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextLarge("Mashreq Card"),
                        TextMedium("**** **** **** 6789")
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        LongButton(text: widget.buttonText, onPress: () {}),
        const SizedBox(
          height: 32,
        ),
      ]),
    );
  }
}

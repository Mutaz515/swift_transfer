import 'package:flutter/material.dart';
import 'package:swift_transfer/components/text_bold.dart';
import 'package:swift_transfer/screens/transactions_screen.dart';

class HomeTransactionButton extends StatelessWidget {
  const HomeTransactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const TextBold("Recent Transaction"),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const TransactionsScreen(),
              ),
            );
          },
          child: const Text("See All"),
        ),
      ],
    );
  }
}

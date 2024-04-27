import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swift_transfer/components/text_bold.dart';
import 'package:swift_transfer/components/text_light.dart';
import 'package:swift_transfer/components/transaction_details.dart';
import 'package:swift_transfer/models/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transactions;

  const TransactionTile({super.key, required this.transactions});

  void _onSelectTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const TransactionDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('MMM d').format(transactions.date);
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return InkWell(
      onTap: () {
        _onSelectTransaction(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(231, 236, 252, 1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: transactions.type == TransactionType.debit
                      ? const Icon(Icons.arrow_outward_rounded)
                      : const Icon(Icons.arrow_downward_rounded),
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextBold(transactions.title),
                    TextLight(_getTransactionTypeString(transactions.type)),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "AED ${myFormat.format(transactions.amount)} ",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextLight(formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }

  String _getTransactionTypeString(TransactionType type) {
    return type == TransactionType.debit ? 'Debit' : 'Credit';
  }
}

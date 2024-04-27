import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:swift_transfer/components/long_button.dart';
import 'package:swift_transfer/models/transaction_model.dart';
import 'package:swift_transfer/providers/phone_number_provider.dart';
import 'package:swift_transfer/screens/transaction_status.dart';

class SummaryTransactionScreen extends ConsumerWidget {
  const SummaryTransactionScreen(
      {super.key, required this.receiverPhoneNumber, required this.amount});

  final String receiverPhoneNumber;
  final num amount;

  void sendMoney(BuildContext context, WidgetRef ref) async {
    final senderPhoneNumber = ref.watch(phoneNumberProvider);
    try {
      final senderDocRef =
          FirebaseFirestore.instance.collection('users').doc(senderPhoneNumber);
      final receiverDocRef = FirebaseFirestore.instance
          .collection('users')
          .doc(receiverPhoneNumber);

      final senderDoc = await senderDocRef.get();
      final receiverDoc = await receiverDocRef.get();

      if (senderDoc.exists && receiverDoc.exists) {
        final senderData = senderDoc.data();
        final receiverData = receiverDoc.data();

        if (senderData != null && receiverData != null) {
          // Assuming senderData and receiverData have 'walletBalance' fields
          num senderBalance = senderData['walletBalance'] ?? 0;
          num receiverBalance = receiverData['walletBalance'] ?? 0;

          // Check if sender has sufficient balance
          if (senderBalance >= amount) {
            senderBalance -= amount;
            receiverBalance += amount;

            TransactionModel senderTransaction = TransactionModel(
              amount: amount,
              date: DateTime.now(),
              type: TransactionType.debit,
              title: "Sent Money",
            );
            TransactionModel receiverTransaction = TransactionModel(
              amount: amount,
              date: DateTime.now(),
              type: TransactionType.credit,
              title: "Received Money",
            );

            // Update sender's and receiver's wallet balances in Firestore
            await senderDocRef.update({
              'walletBalance': senderBalance,
              'transactions':
                  FieldValue.arrayUnion([senderTransaction.toJson()]),
            });
            await receiverDocRef.update({
              'walletBalance': receiverBalance,
              'transactions':
                  FieldValue.arrayUnion([receiverTransaction.toJson()]),
            });

            // Transaction successful, navigate to TransactionStatusScreen
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TransactionStatusScreen(
                  isSuccessful: true,
                  contactNumber: receiverPhoneNumber,
                  amount: amount,
                ),
              ),
            );
          } else {
            // Insufficient balance, show failure message
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TransactionStatusScreen(
                  isSuccessful: false,
                  amount: amount,
                ),
              ),
            );
          }
        }
      } else {
        // One or both users do not exist
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => TransactionStatusScreen(
              isSuccessful: false,
              amount: amount,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error sending money: $e');
      // Show error message or navigate to error screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => TransactionStatusScreen(
            isSuccessful: false,
            amount: amount,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Summary"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(16)),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "+971$receiverPhoneNumber",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "AED $amount",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(
                height: 64,
              ),
              LongButton(
                  text: "Proceed to Send",
                  onPress: () {
                    sendMoney(context, ref);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

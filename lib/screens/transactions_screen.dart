import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_transfer/components/transaction_tile.dart';
import 'package:swift_transfer/models/transaction_model.dart';
import 'package:swift_transfer/providers/user_document_provider.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DocumentSnapshot> userData =
        ref.watch(userDocumentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: userData.when(
          data: (snapshot) {
            if (!snapshot.exists || snapshot.data() == null) {
              return const Center(child: Text('User data not found'));
            }

            Map<String, dynamic> userData =
                snapshot.data() as Map<String, dynamic>;
            var transactions = (userData['transactions'] as List<dynamic>)
                .map((transactionJson) =>
                    TransactionModel.fromJson(transactionJson))
                .toList();

            return ListView.separated(
              shrinkWrap: true,
              itemCount: transactions.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                height: 1,
                color: Colors.grey,
              ),
              itemBuilder: (BuildContext context, int index) {
                TransactionModel transaction = transactions[index];
                return TransactionTile(
                  transactions: transaction,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}

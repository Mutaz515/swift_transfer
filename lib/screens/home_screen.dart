import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_transfer/components/balance_container.dart';
import 'package:swift_transfer/components/home_functions.dart';
import 'package:swift_transfer/components/home_transaction_button.dart';
import 'package:swift_transfer/components/text_bold.dart';
import 'package:swift_transfer/components/text_light.dart';
import 'package:swift_transfer/components/transaction_tile.dart';
import 'package:swift_transfer/models/transaction_model.dart';
import 'package:swift_transfer/providers/user_document_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<DocumentSnapshot> userData =
        ref.watch(userDocumentProvider);

    return userData.when(
      data: (snapshot) {
        if (!snapshot.exists || snapshot.data() == null) {
          return const Text('User data not found');
        }

        Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
        var phoneNumber = userData['phone'];
        var transactionsData = (userData['transactions'] as List<dynamic>)
            .map(
                (transactionJson) => TransactionModel.fromJson(transactionJson))
            .toList();
        var walletBalance = userData['walletBalance'];

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextLight("Welcome Back"),
                          TextBold(
                              phoneNumber), // Display the user's phone number
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).primaryColor,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  BalanceContainer(balance: walletBalance),
                  const SizedBox(height: 32),
                  const HomeFunctions(),
                  const SizedBox(height: 32),
                  const HomeTransactionButton(),
                  const SizedBox(height: 8),
                  transactionsData.isNotEmpty
                      ? Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: transactionsData.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final reversedIndex =
                                  transactionsData.length - 1 - index;
                              return TransactionTile(
                                  transactions:
                                      transactionsData[reversedIndex]);
                            },
                          ),
                        )
                      : const Expanded(
                          child: Center(
                          child: TextBold("No Transactions yet"),
                        )),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );
  }
}

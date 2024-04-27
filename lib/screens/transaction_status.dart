import 'package:flutter/material.dart';
import 'package:swift_transfer/components/circle_icon.dart';
import 'package:swift_transfer/components/contact_container.dart';
import 'package:swift_transfer/components/long_button.dart';
import 'package:swift_transfer/components/text_bold.dart';
// import 'package:swift_transfer/components/text_large.dart';
import 'package:swift_transfer/components/text_light.dart';
import 'package:swift_transfer/components/text_medium.dart';
import 'package:swift_transfer/main.dart';

class TransactionStatusScreen extends StatelessWidget {
  const TransactionStatusScreen(
      {super.key,
      required this.isSuccessful,
      this.contactNumber,
      required this.amount});

  final bool isSuccessful;
  final String? contactNumber;
  final num amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Receipt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleIcon(icon: Icons.done),
            const SizedBox(
              height: 32,
            ),
            const TextMedium("Sent Successfully"),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: TextLight(
                  "Your Money has been sent successfully to +971$contactNumber"),
            ),
            const SizedBox(
              height: 16,
            ),
            const TextLight("Total Amount"),
            const SizedBox(
              height: 16,
            ),
            TextBold("AED $amount "),
            const SizedBox(
              height: 16,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: TextBold("Recipient"),
            ),
            const SizedBox(
              height: 16,
            ),
            ContactCointaner(contactNumber: contactNumber!),
            const SizedBox(
              height: 24,
            ),
            LongButton(
              text: "Done",
              onPress: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {}, child: const TextBold("Send More Money"))
          ],
        ),
      ),
    );
  }
}

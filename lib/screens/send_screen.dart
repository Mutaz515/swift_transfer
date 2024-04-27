import 'package:flutter/material.dart';
// import 'package:swift_transfer/components/contact_container.dart';
import 'package:swift_transfer/components/long_button.dart';
import 'package:swift_transfer/components/text_bold.dart';
import 'package:swift_transfer/components/text_light.dart';
import 'package:swift_transfer/screens/summary_transaction_screen.dart';

class SendScreen extends StatefulWidget {
  const SendScreen({super.key});

  @override
  State<SendScreen> createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _formKey = GlobalKey<FormState>();

  var _enteredPhoneNo = "";
  var _enteredAmount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Send Money"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextBold("Contact"),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: const TextLight("Enter Phone Number"),
                          prefixText: "+971 ",
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        style: Theme.of(context).textTheme.titleLarge,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _enteredPhoneNo = newValue!;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const TextBold("Recents"),
                //     TextButton(
                //       onPressed: () {},
                //       child: const Text("See all Contacts"),
                //     ),
                //   ],
                // ),
                // Expanded(
                //   child: ListView(
                //     children: const [
                //       ContactCointaner(),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       ContactCointaner(),
                //       SizedBox(
                //         height: 8,
                //       ),
                //       ContactCointaner(),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 24,
                ),
                const TextBold("Set Amount"),
                const TextLight("How much would you like to send?"),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const TextLight("Amount"),
                    prefixText: "AED ",
                    labelStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredAmount = newValue!;
                  },
                ),
                const SizedBox(
                  height: 32.0,
                ),
                LongButton(
                  text: "Continue",
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => SummaryTransactionScreen(
                            amount: num.parse(_enteredAmount),
                            receiverPhoneNumber: _enteredPhoneNo,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
          ),
        ));
  }
}

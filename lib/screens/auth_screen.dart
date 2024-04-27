import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_transfer/components/long_button.dart';
import 'package:swift_transfer/providers/phone_number_provider.dart';
import 'package:swift_transfer/screens/otp_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredPhone = "";

  void _submit() {
    _formKey.currentState!.save();
    ref
        .read(phoneNumberProvider.notifier)
        .update((state) => state = _enteredPhone);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const OTPScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Auth Screen",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Enter Your Phone Number you would be sent an OTP and you would be prompt to enter it in the next Screen",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.phone_android),
                    prefix: Text(
                      "+971",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                  ),
                  style: Theme.of(context).textTheme.titleLarge,
                  onSaved: (value) {
                    _enteredPhone = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              LongButton(
                text: "Send OTP",
                onPress: _submit,
              )
            ],
          ),
        ),
      ),
    );
  }
}

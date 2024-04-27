import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:swift_transfer/providers/phone_number_provider.dart';
import 'package:swift_transfer/screens/home_screen.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final phoneNumber = ref.watch(phoneNumberProvider);

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
                "Code Verification",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Enter the OTP sent to Verify +971$phoneNumber",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(
                height: 24,
              ),
              Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: _pinPutController,
                pinAnimationType: PinAnimationType.fade,
                onCompleted: (pin) async {
                  try {
                    final PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: _verificationCode!,
                      smsCode: pin,
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(credential)
                        .then((value) async {
                      if (value.user != null) {
                        final user = value.user!;
                        final userDocRef = FirebaseFirestore.instance
                            .collection('users')
                            .doc(phoneNumber);

                        // Check if the user's document already exists
                        final userDocSnapshot = await userDocRef.get();
                        if (!userDocSnapshot.exists) {
                          // Document doesn't exist, create it
                          await userDocRef.set({
                            'uid': user.uid,
                            'phone': phoneNumber,
                            "transactions": [],
                            "walletBalance": 1000000,
                          });
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      }
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    final phoneNumber = ref.read(phoneNumberProvider);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+971$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          _pinPutController.setText(credential.smsCode!);
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}

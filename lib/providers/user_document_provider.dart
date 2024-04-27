import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swift_transfer/providers/phone_number_provider.dart';

final userDocumentProvider = StreamProvider<DocumentSnapshot>((ref) {
  final phoneNumber = ref.watch(phoneNumberProvider);
  return FirebaseFirestore.instance
      .collection('users')
      .doc(phoneNumber)
      .snapshots();
});

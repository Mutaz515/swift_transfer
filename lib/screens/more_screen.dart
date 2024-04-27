import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swift_transfer/screens/auth_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Log Out",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                FirebaseAuth.instance.signOut();
                logOutRoute(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void logOutRoute(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
        (route) => false);
  }
}

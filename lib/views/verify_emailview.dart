import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Note Now'),
        titleTextStyle: const TextStyle(
            fontFamily: 'TitleFont', fontSize: 40, letterSpacing: 5),
        centerTitle: true,
      ),
      body: Column(
          children: [
            const Text('Verify your email address'),
            TextButton(
              onPressed: () async{
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text('Send email verification'),
            ),
          ],
        ),
    );
  }
}
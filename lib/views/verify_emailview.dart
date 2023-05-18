import 'package:flutter/material.dart';
import 'package:notenow/constants/routes.dart';
import 'package:notenow/services/auth/auth_service.dart';

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
          const Text(
              "We've sent you an email verification. Please open it to verify your account"),
          const Text(
              "If you haven't received a verification email yet, press the resend button"),
          TextButton(
            onPressed: () async {
              AuthService.firebase().sendEmailVerificaiton();
            },
            child: const Text('Resend email verification'),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.firebase().logOut();              
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text('Go back to Register'),
          )
        ],
      ),
    );
  }
}

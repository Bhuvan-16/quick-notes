import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notenow/constants/routes.dart';
import 'package:notenow/services/auth/auth_exceptions.dart';
import 'package:notenow/services/auth/auth_service.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final String _emailalreadyinuse = 'Email is already in use';
  final String _invaildemail = "Invaild Email Addres";
  final String _operationnotallowed = "Operation not allowed";
  final String _weakpassword = "Your password is too weak";

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void toastMessage(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

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
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter your email here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {

                await AuthService.firebase().createUser(email: email, password: password);
              
                AuthService.firebase().sendEmailVerificaiton();

                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on EmailAlreadyInUseAuthException {
                toastMessage(_emailalreadyinuse);
              } on InvalidEmailAuthException {
                toastMessage(_invaildemail);
              } on OperationNotAllowedAuthException {
                toastMessage(_operationnotallowed);
              } on WeakPasswordAuthException {
                toastMessage(_weakpassword);
              } on GenericAuthException {
                toastMessage('Authentication Error');
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already registered? Login here'),
          )
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final String _usernotfound = 'User not found';
  final String _invaildemail = "Invaild Email Addres";
  final String _userdisabled = "Your account has been disabled";
  final String _wrongpassword = "Wrong password";

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
        textColor: Colors.white,);
  }

  @override
  Widget build(BuildContext context) {
    var error;

    return Column(
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
                        final userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email, password: password);
                      } on FirebaseAuthException catch (e) {
                        error = e.code;
                        if (error == 'user-not-found') {
                          toastMessage(_usernotfound);
                        }else if(error == 'invalid-email'){
                          toastMessage(_invaildemail);
                        }else if(error == 'user-disabled'){
                          toastMessage(_userdisabled);
                        }else if(error == 'wrong-password'){
                          toastMessage(_wrongpassword);
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
                    },
                    
                    child: const Text("Don't have an account? Register now"),
                  )
                ],
              );
  }
}

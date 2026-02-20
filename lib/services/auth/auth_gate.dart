import 'package:chatting_app/login_page.dart';
import 'package:chatting_app/services/auth/login_or_register.dart';
import 'package:chatting_app/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Homepage();
        } else {
          return const LoginOrRegister();
        }
      },
    ));
  }
}

import 'package:flutter/material.dart';
import '../../../app/login_page.dart';
import '../../../app/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginpage = true;
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginPage(
        ontap: togglePages,
      );
    } else {
      return RegisterPage(
        ontap: togglePages,
      );
    }
  }
}

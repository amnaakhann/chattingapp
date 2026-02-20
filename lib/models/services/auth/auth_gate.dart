import 'package:chatting_app1/models/services/auth/login_or_register.dart';
import 'package:chatting_app1/app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatting_app1/features/auth/presentation/cubit/auth_cubit.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthProvider should be provided in main.dart; use it to decide which page to show
    final authProvider = Provider.of<AuthProvider>(context);
    final userEntity = authProvider.state.user;

    if (userEntity != null) {
      return Homepage();
    } else {
      return const LoginOrRegister();
    }
  }
}

import 'package:flutter/material.dart';

class LoginPageClean extends StatelessWidget {
  final VoidCallback onGoogleSignIn;

  const LoginPageClean({Key? key, required this.onGoogleSignIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to VikiTalkie', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: Image.asset('assets/google_logo.png', height: 20, width: 20),
              label: const Text('Sign in with Google'),
              onPressed: onGoogleSignIn,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chatting_app1/models/services/auth/authservice.dart';
import 'package:chatting_app1/features/component/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? ontap;
  const RegisterPage({super.key, required this.ontap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  //register method
  Future<void> register(BuildContext context) async {
    final _auth = AuthService();
    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        setState(() => _isLoading = true);
        await _auth.signUpWithEmailPassword(_emailcontroller.text, _passwordcontroller.text);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
        if (!mounted) return;
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      } on FirebaseAuthException catch (e, st) {
        debugPrint('FirebaseAuthException during register: ${e.code} ${e.message}');
        debugPrintStack(label: 'register FirebaseAuthException stack', stackTrace: st);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? e.code)),
        );
      } catch (e, st) {
        debugPrint('Exception during register: $e');
        debugPrintStack(label: 'register exception stack', stackTrace: st);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("password don't match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.app_registration_rounded, size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 12),
                  Text('Create an account', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text('Join VikiTalkie — connect with friends', style: TextStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200))),
                  const SizedBox(height: 16),
                  MyTextfield(hintText: 'Email', obscureText: false, controller: _emailcontroller),
                  const SizedBox(height: 12),
                  MyTextfield(hintText: 'Password', obscureText: true, controller: _passwordcontroller),
                  const SizedBox(height: 12),
                  MyTextfield(hintText: 'Confirm Password', obscureText: true, controller: _confirmpasswordcontroller),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => register(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                            child: Text('Create account'),
                          ),
                        ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          ' Log in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

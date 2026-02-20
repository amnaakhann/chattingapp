import 'package:chatting_app1/models/services/auth/authservice.dart';
import 'package:chatting_app1/features/component/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final void Function()? ontap;
  const LoginPage({super.key, required this.ontap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void login(BuildContext context) async {
    final authservice = AuthService();
    try {
      setState(() => _isLoading = true);
      await authservice.signInWithEmailPassword(
          _emailcontroller.text, _passwordcontroller.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful')),
      );
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } on FirebaseAuthException catch (e, st) {
      debugPrint('FirebaseAuthException during login: ${e.code} ${e.message}');
      debugPrintStack(label: 'login FirebaseAuthException stack', stackTrace: st);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? e.code)),
      );
    } catch (e, st) {
      debugPrint('Exception during login: $e');
      debugPrintStack(label: 'login exception stack', stackTrace: st);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void googleLogin(BuildContext context) async {
    final authservice = AuthService();
    try {
      setState(() => _isLoading = true);
      final userCredential = await authservice.signInWithGoogle();
      if (userCredential == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google sign-in cancelled')),
        );
        return;
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google sign-in successful')),
      );
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } catch (e, st) {
      debugPrint('Google sign-in error: $e');
      debugPrintStack(label: 'googleLogin stack', stackTrace: st);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
                  Icon(Icons.login, size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 12),
                  Text('Welcome back', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text('Sign in to continue to VikiTalkie', style: TextStyle(color: Theme.of(context).colorScheme.primary.withAlpha(200))),
                  const SizedBox(height: 16),
                  MyTextfield(hintText: 'Email', obscureText: false, controller: _emailcontroller),
                  const SizedBox(height: 12),
                  MyTextfield(
                    hintText: 'Password',
                    obscureText: _obscurePassword,
                    controller: _passwordcontroller,
                    suffix: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off, color: Theme.of(context).colorScheme.primary),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => login(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12),
                            child: Text('Sign in'),
                          ),
                        ),
                  const SizedBox(height: 12),
                  _isLoading
                      ? const SizedBox.shrink()
                      : OutlinedButton.icon(
                          icon: Icon(Icons.g_mobiledata, color: Theme.of(context).colorScheme.primary, size: 20),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () => googleLogin(context),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                            child: Text('Sign in with Google'),
                          ),
                        ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      GestureDetector(
                        onTap: widget.ontap,
                        child: const Text(
                          " Register now",
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

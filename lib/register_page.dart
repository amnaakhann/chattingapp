import 'package:chatting_app/services/auth/authservice.dart';
import 'package:chatting_app/component/my_button.dart';
import 'package:chatting_app/component/my_textfield.dart';
import 'package:chatting_app/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final void Function()? ontap;
  RegisterPage({super.key, required this.ontap});
  //register method
  void register(BuildContext context) {
    final _auth = AuthService();
    //passwords match create user
    if (_passwordcontroller.text == _confirmpasswordcontroller.text) {
      try {
        _auth.signUpWithEmailPassword(
            _emailcontroller.text, _passwordcontroller.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
    //password don't match
    else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("password don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.app_registration_rounded,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(
              height: 25,
            ),
            Text("Let's create an account for you!"),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: _emailcontroller,
            ),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: _passwordcontroller,
            ),
            SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmpasswordcontroller,
            ),
            SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("already have an account?"),
                GestureDetector(
                  onTap: ontap,
                  child: Text(
                    " login now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

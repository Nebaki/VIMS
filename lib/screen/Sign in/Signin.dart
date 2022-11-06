import 'package:flutter/material.dart';

import 'components/SignIn_form.dart';
import '../../Componets/no_account_text.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:  AppBar(
        centerTitle: true,
        title: Text("Sign In",)),
      
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children:  [
                const SizedBox(height: 40,),
                const Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Sign in with your email and password",
                  textAlign: TextAlign.center,
                ),
                 const SizedBox(height: 20),
                SignForm(),
                const SizedBox(height: 20),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

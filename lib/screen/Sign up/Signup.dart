import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../util/constants.dart';
import 'Components/SignUpForm.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:Text("Sign up",),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children:  [const SizedBox(height: 20,),
              const Text("Register Account", style: headingStyle),
              const Text(
                  "Complete your details ",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SignUpForm(),
                const SizedBox(height:20),],
            ),
          ),
        ),
      )),
    );
  }
}
